class CreateGuess < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.references :card
      t.references :round
      t.boolean :correct

      t.timestamps
    end
  end
end
