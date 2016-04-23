class CreateImageusers < ActiveRecord::Migration
  def change
    create_table :imageusers do |t|
      t.belongs_to :user, index: true
      t.belongs_to :image, index: true

      t.timestamps
    end
  end
end