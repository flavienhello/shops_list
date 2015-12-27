class RemoveUselessFieldsFromShop < ActiveRecord::Migration
  def change
    remove_columns :shops,
                   :department,
                   :hours,
                   :store_id,
                   :is_address_computed,
                   :is_location_computed,
                   :ignored,
                   :ignore_reason,
                   :overload_chain_name,
                   :madatory_coords
  end
end
