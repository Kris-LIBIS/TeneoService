ActiveAdmin.register Role do

  menu parent: 'Code tables'

  config.sort_order = 'code_asc'

  remove_filter :lock_version

  permit_params :code, :name, :description

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

  form do |f|
    f.inputs do
      f.input :code if f.object.new_record?
      f.input :name
      f.input :description
    end
    actions
  end

end
