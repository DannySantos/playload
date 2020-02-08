# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :key_features do
      primary_key :id

      column :text, String, null: false
      column :type, String, null: false
      column :region, String, null: false
      column :std, TrueClass, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      foreign_key :publication_id, :publications, null: false, index: true
    end
  end
end
