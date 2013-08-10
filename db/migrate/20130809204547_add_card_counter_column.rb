class AddCardCounterColumn < ActiveRecord::Migration
  def change
    add_column :rounds, :card_counter, :integer, :default => 0
  end
end
