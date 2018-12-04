# frozen_string_literal: true

class DbSetup < ActiveRecord::Migration[5.2]
  def change

    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :users, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :username, null: false, unique: true
      t.string :email, null: false, unique: true
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.datetime :last_login

      t.timestamps
    end

    create_table :roles, id: :string, primary_key: 'code' do |t|
      t.string :name, null: false
      t.string :description
    end

    create_table :groups, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :name, null: false
      t.string :description
      t.string :inst_code
      t.string :ingest_dir
      t.jsonb :upload_areas, null: false, default: '{}'

      t.uuid :parent_id, index: true

      t.timestamps
    end

    add_index :groups, :upload_areas, using: :gin

    create_table :memberships, id: true, primary_key: [:user_id, :group_id, :role_id] do |t|
      t.references :user, foreign_key: true, type: :uuid
      t.references :group, foreign_key: true, type: :uuid
      t.references :role, foreign_key: {primary_key: 'code'}, type: :string

      t.timestamps
    end

    create_table :code_tables do |t|
      t.string :name, null: false, unique: true
      t.string :type, null: false
      t.string :inst_code
      t.string :ext_id, null: false
      t.jsonb :options

      t.timestamps

      t.index [:type, :ext_id], unique: true
    end

    create_table :representation_types, id: :string, primary_key: 'name' do |t|
      t.string :preservation_type, index: true
      t.string :usage_type
      t.string :representation_code

      t.timestamps
    end

    create_table :ingest_models, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :name
      t.string :description
      t.string :entity_type
      t.string :user_a
      t.string :user_b
      t.string :user_c
      t.string :identifier
      t.string :status

      t.jsonb :manifestations, array: true

      t.references :access_right, foreign_key: {to_table: :code_tables}, null: false
      t.references :retention_policy, foreign_key: {to_table: :code_tables}, null: false

      t.references :template, foreign_key: {to_table: :ingest_models}, type: :uuid

      t.timestamps
    end

    add_index :ingest_models, :manifestations, using: :gin

    create_table :ingest_agreements, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :name
      t.string :project_name
      t.string :collection_name
      t.string :contact_ingest, array: true
      t.string :contact_collection, array: true
      t.string :contact_system, array: true
      t.string :collection_description
      t.string :ingest_job_name
      # t.string :entity_type

      t.string :collector

      t.references :group, foreign_key: true, type: :uuid
      t.references :ingest_model, foreign_key: true, type: :uuid

      t.timestamps
    end

    create_table :ingests, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :stage
      t.string :status
      t.string :name
      t.string :base_dir

      t.references :ingest_agreement, foreign_key: true, type: :uuid

      t.timestamps
    end

    create_table :items, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :type
      t.string :name
      t.string :label

      t.references :ingest, foreign_key: true, type: :uuid

      t.timestamps
    end

    create_table :status_logs, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :task
      t.string :status
      t.integer :progess
      t.integer :max

      t.references :item, foreign_key: true, type: :uuid

      t.timestamps
    end

    create_table :type_db do |t|
      t.string :group
      t.string :name, unique: true
      t.string :description
      t.string :mime_types, array: true
      t.string :puids, array: true
      t.string :extensions, array: true

      t.timestamps

      t.index :mime_types, using: :gin
      t.index :puids, using: :gin
      t.index :extensions, using: :gin

    end

  end
end
