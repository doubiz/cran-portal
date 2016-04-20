class Package < ActiveRecord::Base
  BASE_URL = "http://cran.r-project.org/src/contrib/"
  FILE_EXT = ".tar.gz"
  #Validations
  validates_presence_of :name, :version
  validates :name, uniqueness: { scope: :version}

  #Relations
  has_many :package_contributors
  has_many :contributors, through: :package_contributors
  has_many :authors, -> {where(package_contributors: {contribution_type: 1})} , through: :package_contributors, source: :contributor
  has_many :maintainers, -> {where(package_contributors: {contribution_type: 2})} , through: :package_contributors, source: :contributor

  def versions
    Package.where(name: self.name)
  end

  def url
    BASE_URL + name + "_" + version + FILE_EXT
  end
end
