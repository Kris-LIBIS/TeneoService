ActiveAdmin.register MaterialFlow do

  menu parent: 'Code tables'

  config.sort_order = 'id_asc'

  remove_filter :lock_version

  permit_params :name, :code, :inst_code, :description

  index do
    column :name
    column :code
    column :inst_code
    column :description
    actions
  end

  show do
    attributes_table do
      row :name
      row :code
      row :inst_code
      row :description
    end
  end

end
