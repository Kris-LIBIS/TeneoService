ActiveAdmin.register Producer do
  menu parent: 'Code tables'

  filter :name
  filter :code
  filter :inst_code
  filter :agent
  filter :description

  index do
    column :name
    column :code
    column :inst_code
    column :agent
    column :description
    actions
  end

  permit_params :name, :code, :inst_code, :agent, :password, :description

end
