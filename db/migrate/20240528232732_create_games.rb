class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games, id: :string do |t|
      t.string :assets
      t.string :market
      t.string :collectors
      t.string :deck
      t.string :vault
      t.string :discard

      t.timestamps
    end
  end
end
