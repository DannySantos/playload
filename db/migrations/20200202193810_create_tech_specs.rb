# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :tech_specs do
      primary_key :id

      column :name, String, null: false
      column :priority, String, null: true
      column :value, String, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      foreign_key :tech_spec_group_id, :tech_spec_groups, null: false, index: true
    end
  end
end
