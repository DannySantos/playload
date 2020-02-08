# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :classifications do
      primary_key :id

      column :name, String, null: false
      column :priority, String, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      foreign_key :classification_category_id, :classification_categories, null: false, index: true
    end
  end
end
