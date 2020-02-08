# frozen_string_literal: true

Hanami::Model.migration do
  change do
    extension :pg_enum

    create_enum :link_type, %w[Facebook Twitter YouTube Website]

    create_table :links do
      primary_key :id

      column :url, String, null: false
      column :type, :link_type, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      foreign_key :release_id, :releases, null: false, index: true
    end
  end
end
