class AddRoundCounts < ActiveRecord::Migration
  def change
  	add_column :rounds, :round_count, :integer, :default => 0
  end
end
