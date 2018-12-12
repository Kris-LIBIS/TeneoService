ActiveAdmin.register AdminUser do

  config.sort_order = 'email_asc'

  filter :email

  permit_params :email, :password

  index do
    column :email
    actions
  end

  show do
        attributes_table do
          row :email
        end
  end

  form do |f|
    f.inputs 'User info' do
      f.input :email
      f.input :password
    end
    actions
  end

  controller do
    def update_resource(object, attributes)
      if attributes.first[:password].blank?
        object.update_without_password *attributes
      else
        object.update *attributes
      end
    end
  end

end
