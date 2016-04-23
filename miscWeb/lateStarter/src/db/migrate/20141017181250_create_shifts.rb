class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.belongs_to :user, index: true
      t.string :start_time
      t.string :end_time

      t.timestamps null: false
    end
  end
end
