# frozen_string_literal: true

class DbSetup < ActiveRecord::Migration[5.2]
  def change

    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :users, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :username, null: false, index: {unique: true}
      t.string :email, null: false, index: {unique: true}
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.datetime :last_login

      t.column :lock_version, :integer, null: false, default: 0
    end

    create_table :roles, id: :string, primary_key: 'code' do |t|
      t.string :name, null: false, index: {unique: true}
      t.string :description

      t.column :lock_version, :integer, null: false, default: 0
    end

    create_table :producers do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.string :inst_code, null: false
      t.string :description
      t.string :agent, null: false
      t.string :password, null: false

      t.index [:inst_code, :name], unique: true

      t.column :lock_version, :integer, null: false, default: 0
    end

    create_table :material_flows do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.string :inst_code
      t.string :description

      t.index [:inst_code, :name], unique: true

      t.column :lock_version, :integer, null: false, default: 0
    end

    create_table :organizations do |t|
      t.string :name, null: false, index: {unique: true}
      t.string :description
      t.string :inst_code
      t.string :ingest_dir
      t.jsonb :upload_areas, null: false, default: '{}'
      t.references :producer, foreign_key: true
      t.references :material_flow, foreign_key: true

      t.references :parent, foreign_key: {to_table: :organizations}

      t.column :lock_version, :integer, null: false, default: 0
    end

    add_index :organizations, :upload_areas, using: :gin

    create_table :memberships do |t|
      t.references :user, foreign_key: true, type: :uuid
      t.references :organization, foreign_key: true
      t.references :role, foreign_key: {primary_key: 'code'}, type: :string

      t.index [:user_id, :organization_id, :role_id], unique: true

      t.column :lock_version, :integer, null: false, default: 0
    end

    create_table :access_rights do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.string :description

      t.column :lock_version, :integer, null: false, default: 0
    end

    create_table :retention_policies do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.string :description

      t.column :lock_version, :integer, null: false, default: 0
    end

    create_table :representation_types do |t|
      t.string :name, null: false, index: {unique: true}
      t.string :preservation_type, null: false, index: true
      t.string :usage_type
      t.string :representation_code

      t.column :lock_version, :integer, null: false, default: 0
    end

    create_table :ingest_models do |t|
      t.string :name, null: false, index: {unique: true}
      t.string :description
      t.string :entity_type
      t.string :user_a
      t.string :user_b
      t.string :user_c
      t.string :identifier
      t.string :status

      t.jsonb :manifestations, array: true

      t.references :access_right, foreign_key: true, null: false
      t.references :retention_policy, foreign_key: true, null: false

      t.references :template, foreign_key: {to_table: :ingest_models}

      t.column :lock_version, :integer, null: false, default: 0
    end

    add_index :ingest_models, :manifestations, using: :gin

    create_table :ingest_agreements do |t|
      t.string :name, null: false, index: {unique: true}
      t.string :project_name
      t.string :collection_name
      t.string :contact_ingest, array: true
      t.string :contact_collection, array: true
      t.string :contact_system, array: true
      t.string :collection_description
      t.string :ingest_job_name

      t.string :collector

      t.references :organization, foreign_key: true
      t.references :ingest_model, foreign_key: true

      t.column :lock_version, :integer, null: false, default: 0
    end

    create_table :ingests do |t|
      t.string :name, null: false
      t.string :stage
      t.string :status
      t.string :base_dir

      t.references :ingest_agreement, foreign_key: true

      t.timestamps default: -> {'CURRENT_TIMESTAMP'}
      t.column :lock_version, :integer, null: false, default: 0
    end

    create_table :items do |t|
      t.string :type, null: false
      t.string :name, null: false
      t.string :label

      t.references :parent, foreign_key: {to_table: :items, on_delete: :cascade}
      t.references :ingest, foreign_key: true

      t.timestamps default: -> {'CURRENT_TIMESTAMP'}
      t.column :lock_version, :integer, null: false, default: 0
    end

    # noinspection RubyResolve
    create_table :status_logs do |t|
      t.string :task
      t.string :status
      t.integer :progess
      t.integer :max

      t.references :item, foreign_key: true

      t.timestamps default: -> {'CURRENT_TIMESTAMP'}
    end

    create_table :formats do |t|
      t.string :name, null: false, index: {unique: true}
      t.string :category, index: true
      t.string :description
      t.string :mime_types, array: true
      t.string :puids, array: true
      t.string :extensions, array: true

      t.timestamps default: -> {'CURRENT_TIMESTAMP'}

      t.index :mime_types, using: :gin
      t.index :puids, using: :gin
      t.index :extensions, using: :gin
    end

  end
end
