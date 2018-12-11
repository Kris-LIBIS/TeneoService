ActiveAdmin.register Organization do

  config.sort_order = 'id_asc'

  remove_filter :memberships, :lock_version, :users, :ingest_dir, :producer, :material_flow

  permit_params :name, :description, :inst_code,
                :ingest_dir, :upload_areas,
                :producer_id, :material_flow_id, :parent_id

  index do
    column :parent
    column :name
    column :description
    column :inst_code
    actions
  end

  show do
    attributes_table do
      row :parent
      row :name
      row :description
      row :inst_code
      row :ingest_dir
      list_row :upload_areas
      row :producer
      row :material_flow
    end

    table_for organization.memberships do
      column :user
      column :role
    end

  end

  form do |f|
    f.inputs 'Organization info' do
      f.input :parent
      f.input :name
      f.input :description
      f.input :inst_code
      f.input :ingest_dir
      f.input :upload_areas, as: :text, input_html: { class: 'jsoneditor-target' }
      f.input :producer
      f.input :material_flow
    end
    f.inputs 'Memberships' do
      f.has_many :memberships do |m|
        m.input :user
        m.input :role
      end
    end
    actions
  end

end
