ActiveAdmin.register Organization do

  config.sort_order = 'id_asc'

  filter :name
  filter :description
  filter :inst_code

  permit_params :name, :description, :inst_code,
                :ingest_dir, :upload_areas,
                :producer_id, :material_flow_id,
                memberships_attributes: [:id, :_destroy, :organization_id, :role_id, :user_id]

  index do
    column :name
    column :description
    column :inst_code
    actions
  end

  show do
    columns do
      column span: 2 do
        attributes_table do
          row :name
          row :description
          row :inst_code
          row :ingest_dir
          list_row :upload_areas
          row :producer
          row :material_flow
        end
      end
      column do
        panel 'Organization Assignments' do
          table_for organization.memberships do
            column :user
            column :role
          end
        end
        panel 'Ingest Agreements' do

        end
      end
    end


  end

  form do |f|
    f.inputs 'Organization info' do
      f.input :name
      f.input :description
      f.input :inst_code
      f.input :ingest_dir
      f.input :upload_areas, as: :text, input_html: {class: 'jsoneditor-target'}
      f.input :producer
      f.input :material_flow
    end

    f.inputs 'Membership info' do
      f.has_many :memberships, heading: false, allow_destroy: true do |m|
        m.input :user, member_label: :full_name
        m.input :role
      end
    end

    actions
  end

end
