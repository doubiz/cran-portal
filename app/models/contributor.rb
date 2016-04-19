class Contributor < ActiveRecord::Base
  #Validations
  validates_presence_of :name
  validates_uniqueness_of :name

  #Relations
  has_many :package_contributors
  has_many :packages,  through: :package_contributors
  has_many :authored_packages, -> {where(package_contributors: {contribution_type: 1})} , through: :package_contributors, source: :package
  has_many :maintaining_packages, -> {where(package_contributors: {contribution_type: 2})} , through: :package_contributors, source: :package
end
