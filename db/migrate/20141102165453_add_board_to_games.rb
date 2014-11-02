class AddBoardToGames < ActiveRecord::Migration
  def change
    add_column :games, :tl, :integer, null: false, default: 0
    add_column :games, :tc, :integer, null: false, default: 0
    add_column :games, :tr, :integer, null: false, default: 0
    add_column :games, :ml, :integer, null: false, default: 0
    add_column :games, :mc, :integer, null: false, default: 0
    add_column :games, :mr, :integer, null: false, default: 0
    add_column :games, :bl, :integer, null: false, default: 0
    add_column :games, :bc, :integer, null: false, default: 0
    add_column :games, :br, :integer, null: false, default: 0
  end
end
