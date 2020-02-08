# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :screenshots do
      primary_key :id

      column :resolution, String, null: false
      column :url, String, null: false, unique: true, index: true
      column :type, String, null: false
      column :group_id, Integer, null: false, index: true
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      foreign_key :release_id, :releases, null: false, index: true
    end
  end
end
