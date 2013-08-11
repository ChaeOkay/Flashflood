class AddMaxGuessesToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :max_guesses, :integer, :default => 3
  end
end
