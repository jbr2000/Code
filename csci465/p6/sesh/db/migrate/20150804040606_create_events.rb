class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :creator, index: true
      t.string     :title, null: false, default: ""
      t.datetime   :date_time, null: false, default: DateTime.now
      t.string     :image_filename, default: "default_event.jpg"

      t.timestamps null: false
    end
  end
end
