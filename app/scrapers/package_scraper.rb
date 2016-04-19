require 'rubygems/package'
require 'zlib'
require "dcf"
class PackageScraper
  BASE_URL = "http://cran.r-project.org/src/contrib/"
  FILE_EXT = ".tar.gz"
  Description_FILE_NAME = "DESCRIPTION"
  DICTIONARY = {"Package" => "name", "Version" => "version", "Depends" => "dependencies", "Import" => "imports",
                "Title" => "title", "Description" => "description", "License" => "license", "Date" => "date",
                "Publication" => "date", "Date/Publication" => "date"}
  CONTRIBUTORS_KEYS = ["Author", "Authors","Maintainer", "Maintainers"]


  attr_accessor :package_info, :authors, :maintainers

  def initialize(options = {})
    @package_info = {}
    @authors = [] 
    @maintainers = []
    if (options["Package"].present? && options["Version"].present?)
      unless Package.find_by(name: options["Package"], version: options["Version"]).present?
        translate_data(options)
        get_extra_info
        create_package
      else
        raise "Package Already exists"
      end
    else
      raise "Missing package information"
    end
  end

  def package_url
    BASE_URL + @package_info["name"] + "_" + @package_info["version"] + FILE_EXT
  end

  def translate_data(hash)
    hash.each do |key, value|
      @package_info[DICTIONARY[key]] ||= value.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '') if DICTIONARY[key].present?
    end
  end

  def get_extra_info
    desc = get_description_data
    translate_data(desc)
    build_contributors(desc)
  end

  #Getting contributors requires a lot of cases handling because the way authors are displayed is not consistent.
  #Changing this method requires generating good regexs to handle different display of Authors.
  #Some of the authors have their names in non-Ascii characters.
  def build_contributors(hash)
    CONTRIBUTORS_KEYS.each do |key|
      if hash[key].present?
        contributors = hash[key].encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
                        .gsub(/\[[a-zA-Z]*,*\s*[a-zA-Z]*\]/,"").split(/\sand\s|,/)
        contributors.each do |contributor|
          splitted = contributor.split("<")
          name = splitted[0].split("[")[0].strip
          email = splitted[1].split(">")[0].downcase.strip if splitted[1].present?
          created_contributor = Contributor.find_or_create( name, email || nil)
          key.starts_with?("A") ? @authors << created_contributor : @maintainers << created_contributor
        end
      end
    end
  end

  def get_description_data
    url = URI.parse(package_url)
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    raise "Error in request" unless res.code == "200"
    extracted_tar = Gem::Package::TarReader.new(Zlib::GzipReader.new(StringIO.new(res.body.to_s)))
    extracted_tar.each do |entry|
      if entry.full_name.split("/")[1] == Description_FILE_NAME
        return Dcf.parse(entry.read)[0]
      end
    end
  end

  def create_package
    p = Package.new(@package_info)
    p.save
    p.authors << @authors
    p.maintainers << @maintainers
  end


end