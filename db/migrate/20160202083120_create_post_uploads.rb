class CreatePostUploads < ActiveRecord::Migration
  def change
    create_table :post_uploads do |t|
      t.string :image

      t.timestamps null: false
    end
  end
end
