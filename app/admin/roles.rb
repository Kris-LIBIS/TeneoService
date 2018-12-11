ActiveAdmin.register Role do

  menu parent: 'Code tables'

  config.sort_order = 'code_asc'

  remove_filter :lock_version

  permit_params :name, :description

  index do
    column :name
    column :description
    actions
  end

  show do
    attributes_table do
      row :name
      row :description
    end
  end

end
