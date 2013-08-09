class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.references :deck
      t.text :question
      t.string :answer
    end
  end
end
