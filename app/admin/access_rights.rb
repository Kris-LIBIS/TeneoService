ActiveAdmin.register AccessRight do

  menu parent: 'Code tables'

  config.sort_order = 'id_asc'

  remove_filter :lock_version

  index do
    column :id
    column :name
    column :code
    column :description
    actions
  end

end
