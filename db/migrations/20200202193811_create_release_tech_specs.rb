# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :release_tech_specs do
      primary_key :id

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      foreign_key :release_id, :releases, null: false, index: true
      foreign_key :tech_spec_id, :tech_specs, null: false, index: true
    end
  end
end
