# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :publications do
      primary_key :id

      column :title, String, null: false, index: true
      column :gameopedia_id, String, null: false, unique: true, index: true
      column :barcode, String, null: true
      column :gameopedia_release_date, String, null: true
      column :release_date, String, null: true
      column :distribution, String, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      foreign_key :release_id, :releases, null: false, index: true
    end
  end
end
