class CreateShippings < ActiveRecord::Migration
  def change
    create_table :shippings do |t|
      t.string :xmlns
      t.string :shipment_id
      t.string :shipment_status
      t.string :tracking_pin
      t.timestamps null: false
    end
  end
end
