class AddRemoveColumnInImage < ActiveRecord::Migration
  def change
    remove_column :images, :url
    add_column :images, :name, :string
  end
end
