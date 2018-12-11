ActiveAdmin.register RepresentationType do

  menu parent: 'Code tables'

  config.sort_order = 'id_asc'

  remove_filter :lock_version

  permit_params :name, :preservation_type, :usage_type, :representation_code

  index do
    column :id
    column :name
    column :preservation_type
    column :usage_type
    column :representation_code
    actions
  end

  show do
    attributes_table do
      row :name
      row :preservation_type
      row :usage_type
      row :representation_code
    end
  end

end
