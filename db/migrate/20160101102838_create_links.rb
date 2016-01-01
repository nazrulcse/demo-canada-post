class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :rel
      t.text :href
      t.text :media_type
      t.integer :shipping_id

      t.timestamps null: false
    end
  end
end
