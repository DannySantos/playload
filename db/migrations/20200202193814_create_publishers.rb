# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :publishers do
      primary_key :id

      column :name, String, null: false, unique: true, index: true
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
