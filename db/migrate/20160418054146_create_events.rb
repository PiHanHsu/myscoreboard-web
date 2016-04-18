class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|

      t.text :topic
      t.timestamps null: false
    end
  end
end
