class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :value
      t.belongs_to :image
      t.timestamps
    end
  end
end
