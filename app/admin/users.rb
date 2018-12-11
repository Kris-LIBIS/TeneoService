ActiveAdmin.register User do
  remove_filter :memberships, :lock_version, :password_digest

  config.sort_order = 'email_asc'
  config.batch_actions = false

  permit_params :email, :first_name, :last_name, :password, :sysadmin,
                memberships_attributes: [:id, :organization_id, :role_id, :user_id]

  index do
    column :email
    column :first_name
    column :last_name
    bool_column :sysadmin
    actions
  end

  show do
    attributes_table do
      row :email
      row :first_name
      row :last_name
      bool_row :sysadmin
    end

    table_for user.memberships do
      column :organization
      column :role
    end
  end

  form do |f|
    f.inputs 'User info' do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :password
      f.input :sysadmin
    end
    f.inputs 'Memberships' do
      f.has_many :memberships do |m|
        m.input :organization
        m.input :role
      end
    end
    actions
  end

end
