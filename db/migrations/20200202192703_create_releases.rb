# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :releases do
      primary_key :id

      column :updated_by_gameopedia, String, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      foreign_key :game_id, :games, null: false, index: true
      foreign_key :platform_id, :platforms, null: false, index: true
    end
  end
end
