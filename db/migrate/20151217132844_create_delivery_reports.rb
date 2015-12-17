class CreateDeliveryReports < ActiveRecord::Migration
  def change
    create_table :delivery_reports do |t|

      t.timestamps null: false
    end
  end
end
