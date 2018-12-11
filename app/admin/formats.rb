require 'activeadmin_addons'

ActiveAdmin.register Format do

  menu parent: 'Code tables'

  config.sort_order = 'category_asc, name_asc'
  config.paginate = false

  permit_params :category, :name, :description, mime_types: [], puids: [], extensions: []

  index as: :grouped_tabs, group_by_attribute: :category do
    column :name
    column :description
    column :extensions
    actions
  end

end
