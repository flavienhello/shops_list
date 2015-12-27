class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :chain
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :city
      t.string :zip
      t.string :department
      t.string :phone
      t.text :hours
      t.integer :store_id
      t.boolean :is_address_computed
      t.boolean :is_location_computed
      t.string :key
      t.boolean :ignored
      t.string :ignore_reason
      t.string :overload_chain_name
      t.boolean :madatory_coords
      t.string :country_code

      t.timestamps null: false
    end
  end
end
