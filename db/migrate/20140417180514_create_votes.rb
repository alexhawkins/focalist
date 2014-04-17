class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :value
      t.references :user, index: true
      t.references :item, index: true

      t.timestamps
    end
  end
end
