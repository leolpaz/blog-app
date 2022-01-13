class AddAddressToLikes < ActiveRecord::Migration[7.0]
  def change
    add_column :likes, :address, :string
    add_index :likes, :address
  end
end
