# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :videos do
      primary_key :id

      column :url, String, null: false
      column :embed_url, String, null: false
      column :info, String, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      foreign_key :release_id, :releases, null: false, index: true
    end
  end
end
