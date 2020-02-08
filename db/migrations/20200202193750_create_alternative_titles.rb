# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :alternative_titles do
      primary_key :id

      column :title, String, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      foreign_key :release_id, :releases, null: false, index: true
    end
  end
end
