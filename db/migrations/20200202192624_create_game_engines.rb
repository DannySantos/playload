# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :game_engines do
      primary_key :id

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      foreign_key :game_id, :games, null: false, index: true
      foreign_key :engine_id, :engines, null: false, index: true

      unique %i[game_id engine_id]
    end
  end
end
