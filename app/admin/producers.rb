ActiveAdmin.register Producer do

  menu parent: 'Code tables'

  config.sort_order = 'id_asc'

  remove_filter :lock_version, :password

  permit_params :name, :code, :inst_code, :description, :agent, :password

  index do
    column :id
    column :name
    column :code
    column :inst_code
    column :agent
    column :description
    actions
  end

  show do
    attributes_table do
      row :name
      row :code
      row :inst_code
      row :agent
      row :description
    end
  end

end
