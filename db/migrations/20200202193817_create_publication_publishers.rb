# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :publication_publishers do
      primary_key :id

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      foreign_key :publication_id, :publications, null: false, index: true
      foreign_key :publisher_id, :publishers, null: false, index: true

      unique %i[publication_id publisher_id]
    end
  end
end
