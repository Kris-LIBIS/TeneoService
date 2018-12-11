ActiveAdmin.register AccessRight do

  menu parent: 'Code tables'

  config.sort_order = 'id_asc'

  remove_filter :lock_version

  permit_params :name, :code, :description

  index do
    column :name
    column :code
    column :description
    actions
  end

  show do
    attributes_table do
      row :name
      row :code
      row :description
    end
  end

end
