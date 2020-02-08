# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :games do
      primary_key :id

      column :title, String, null: false, unique: true, index: true
      column :us_title, String, null: true, unique: true
      column :uk_title, String, null: true, unique: true
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
