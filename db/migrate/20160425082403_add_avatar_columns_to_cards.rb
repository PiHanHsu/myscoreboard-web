class AddAvatarColumnsToCards < ActiveRecord::Migration
  def up
    add_attachment :cards, :avatar
  end

  def down
    remove_attachment :cards, :avatar
  end
end
