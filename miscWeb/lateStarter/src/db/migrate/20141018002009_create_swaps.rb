class CreateSwaps < ActiveRecord::Migration
  def change
    create_table :swaps do |t|
      t.belongs_to :owner, index: true
      t.belongs_to :taker, index: true
      t.belongs_to :shift, index: true

      t.timestamps null: false
    end
  end
end
