require 'activeadmin_addons'

ActiveAdmin.register Format do

  menu parent: 'Code tables'

  config.sort_order = 'name_asc'
  # config.paginate = false

  permit_params :category, :name, :description, mime_types: [], puids: [], extensions: []

  filter :category, as: :select, collection: -> { Format.distinct.order(:category).pluck(:category) }
  filter :name
  filter :description
  filter :mime_types
  filter :puids
  filter :extensions

  index do
    column :name
    column :category
    column :description
    column :extensions
    actions
  end

  show do
    attributes_table do
      row :category
      row :name
      row :description
      list_row :extensions
      list_row :mime_types
      list_row :puids
    end
  end

  form do |f|
    f.inputs 'Format info' do
      f.input :category, as: :select, collection: Format.distinct.order(:category).pluck(:category)
      f.input :name
      f.input :description
      f.input :extensions, as: :tags
      f.input :mime_types, as: :tags
      f.input :puids, as: :tags
    end
    actions
  end

end
