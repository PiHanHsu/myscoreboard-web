class AddFirstEmailCloumnToUser < ActiveRecord::Migration

  def change
    add_column :users, :email_first, :string
  end

end
