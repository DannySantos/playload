# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :publication_regions do
      primary_key :id

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      foreign_key :region_id, :regions, null: false, index: true
      foreign_key :publication_id, :publications, null: false, index: true

      unique %i[region_id publication_id]
    end
  end
end
