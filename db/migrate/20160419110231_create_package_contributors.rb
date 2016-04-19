class CreatePackageContributors < ActiveRecord::Migration
  def change
    create_table :package_contributors do |t|
      t.integer :package_id, null: false
      t.integer :contributor_id, null: false
      t.integer :contribution_type

      t.timestamps null: false
    end
  end
end
