# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :release_classifications do
      primary_key :id

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      foreign_key :release_id, :releases, null: false, index: true
      foreign_key :classification_id, :classifications, null: false, index: true

      unique %i[release_id classification_id]
    end
  end
end
