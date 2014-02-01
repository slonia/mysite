class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :number, null: false

      t.timestamps
    end
  end
end
