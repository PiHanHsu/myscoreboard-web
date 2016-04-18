class AddSomeColumToUsers < ActiveRecord::Migration

  def change
    add_column :users, :username, :string
    add_column :users, :gender, :string
    add_column :users, :photo, :string

    add_column :users, :fb_uid, :string
    add_column :users, :fb_token, :string
    add_column :users, :authentication_token, :string

    add_index :users, :fb_uid
    add_index :users, :authentication_token, :unique => true

    User.find_each do |u|
      puts "generate user #{u.id} token"
      u.generate_authentication_token
      u.save!
    end

  end
end
