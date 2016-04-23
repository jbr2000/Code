class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.belongs_to :user, index: true
      t.belongs_to :event, index: true
      t.integer    :status, default: 3 #invited
      
      t.timestamps null: false
    end
  end
end
