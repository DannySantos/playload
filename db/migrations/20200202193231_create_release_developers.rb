# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :release_developers do
      primary_key :id

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      foreign_key :release_id, :releases, null: false, index: true
      foreign_key :developer_id, :developers, null: false, index: true

      unique %i[release_id developer_id]
    end
  end
end
