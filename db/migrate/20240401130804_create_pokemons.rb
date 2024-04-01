# frozen_string_literal: true

class CreatePokemons < ActiveRecord::Migration[7.1]
  def up
    create_table :pokemons do |t|
      t.string :name, null: false
      t.string :primary_type, null: false
      t.string :secondary_type
      t.integer :total, null: false
      t.integer :hp, null: false
      t.integer :attack, null: false
      t.integer :defense, null: false
      t.integer :sp_atk, null: false
      t.integer :sp_def, null: false
      t.integer :speed, null: false
      t.integer :generation, null: false
      t.boolean :legendary, null: false

      t.timestamps
    end

    add_index :pokemons, :name, unique: true, name: 'pokemon_name_idx'
  end

  def down
    drop_table :pokemons
  end
end
