require "dcf"
require 'net/http'
class CranScraper
  attr_accessor :unparsed_packages
  CRAN_URL = "http://cran.r-project.org/src/contrib/PACKAGES"
  SPLIT_STR = "\n\n"

  def initialize(parse = true)
    @unparsed_packages = []
    get_page
    parse_reponse if parse
  end

  def get_page
    #response is 1.1 Mb 
    #If response size increases than that think about parsing the response in chunks
    #IO Stream
    #For now 1.1Mb is not large
    url = URI.parse(CRAN_URL)
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    @unparsed_packages = res.body.split(SPLIT_STR)
  end

  def parse_reponse
    @unparsed_packages.each do |unpkg|
      ppkg = Dcf.parse(unpkg)[0]
      begin
        PackageScraper.new(ppkg)
      rescue Exception => e
        p e
      end
      
    end
  end

end