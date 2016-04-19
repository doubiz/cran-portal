class PackageContributor < ActiveRecord::Base
  #Enum
  enum contribution_type: {author: 1, maintainer: 2}
  #Validations
  validates_presence_of :package_id, :contributor_id, :contribution_type
  #Relations
  belongs_to :contributor
  belongs_to :package

end
