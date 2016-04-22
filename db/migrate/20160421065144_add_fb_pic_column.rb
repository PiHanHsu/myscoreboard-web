class AddFbPicColumn < ActiveRecord::Migration

  def change
    add_column :users, :fb_pic, :string
    add_column :users, :fb_raw_data, :text
  end

end


