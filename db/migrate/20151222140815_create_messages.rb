class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|

      t.integer :messageable_id
      t.string :messageable_type
      t.timestamps null: false
    end

    add_index :messages, :messageable_id
  end
end
