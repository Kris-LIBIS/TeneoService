ActiveAdmin.register MaterialFlow do
  menu parent: 'Code tables'

  filter :name
  filter :code
  filter :inst_code
  filter :description

  permit_params :name, :code, :inst_code, :description

  index do
    column :name
    column :code
    column :inst_code
    column :description
    actions
  end

end
