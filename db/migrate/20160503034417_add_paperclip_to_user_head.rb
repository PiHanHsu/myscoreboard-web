class AddPaperclipToUserHead < ActiveRecord::Migration


  def up
    add_attachment :users, :head
  end

  def down
    remove_attachment :users, :head
  end

end

