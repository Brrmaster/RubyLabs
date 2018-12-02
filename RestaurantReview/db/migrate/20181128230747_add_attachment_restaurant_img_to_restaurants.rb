class AddAttachmentRestaurantImgToRestaurants < ActiveRecord::Migration[5.0]
  def self.up
    change_table :restaurants do |t|
      t.attachment :restaurant_img
    end
  end

  def self.down
    remove_attachment :restaurants, :restaurant_img
  end
end
