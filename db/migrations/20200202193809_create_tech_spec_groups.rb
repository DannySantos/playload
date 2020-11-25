# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :tech_spec_groups do
      primary_key :id

      column :name, String, null: false
      column :priority, String, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
