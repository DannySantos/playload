# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :reviews do
      primary_key :id

      column :rating, String, null: false
      column :link, String, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      foreign_key :release_id, :releases, null: false, index: true
      foreign_key :reviewer_id, :reviewers, null: false, index: true
      foreign_key :region_id, :regions, null: false, index: true

      unique %i[release_id reviewer_id region_id]
    end
  end
end
