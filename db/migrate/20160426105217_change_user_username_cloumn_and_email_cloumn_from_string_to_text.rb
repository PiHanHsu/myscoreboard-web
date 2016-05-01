class ChangeUserUsernameCloumnAndEmailCloumnFromStringToText < ActiveRecord::Migration


    def up
      change_column :users, :email, :text
      change_column :users, :username, :text
    end

    def down

      change_column :users, :email, :string
      change_column :users, :username, :string
    end

end
