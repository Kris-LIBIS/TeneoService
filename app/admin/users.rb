ActiveAdmin.register User do
  remove_filter :memberships, :lock_version, :password_digest

  config.sort_order = 'username_asc'
  config.batch_actions = false

  permit_params :username, :email, :first_name, :last_name, :password,
                memberships_attributes: [:id, :organization_id, :role_id, :user_id]

  index do
    column :username
    column :email
    column :first_name
    column :last_name
    column :last_login
    actions
  end

  show do
    attributes_table do
      row :username
      row :email
      row :first_name
      row :last_name
      row :last_login
    end

    table_for user.memberships do
      column :organization
      column :role
    end
  end

  form do |f|
    f.inputs 'User info' do
      f.input :username
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :password
    end
    f.inputs 'Memberships' do
      f.has_many :memberships do |m|
        m.input :organization
        m.input :role
      end
    end
  end

end
