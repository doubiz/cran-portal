class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name, index: true, null: false
      t.string :version
      t.string :title
      t.datetime :date
      t.text :description
      t.string :dependencies
      t.string :imports
      t.string :license

      t.timestamps null: false
    end
  end
end
