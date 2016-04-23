class CreateDois < ActiveRecord::Migration
  def change
    create_table :dois do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
