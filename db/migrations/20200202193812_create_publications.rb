# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :publications do
      primary_key :id

      column :title, String, null: false, unique: true, index: true
      column :gameopedia_id, String, null: false, unique: true, index: true
      column :barcode, String, null: false
      column :release_date, DateTime, null: false
      column :distribution, String, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      foreign_key :release_id, :releases, null: false, index: true
    end
  end
end
