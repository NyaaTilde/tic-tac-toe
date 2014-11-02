class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.timestamps null: false
      t.string :proponent, null: false
      t.string :opponent, null: false
      t.integer :status, null: false
    end
  end
end
