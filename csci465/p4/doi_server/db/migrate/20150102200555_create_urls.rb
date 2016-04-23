class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.belongs_to :doi, index:true
      t.string :url
      t.timestamps
    end
  end
end
