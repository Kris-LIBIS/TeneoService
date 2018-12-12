ActiveAdmin.register User do
  # remove_filter :memberships, :lock_version, :password_digest,
  #               :created_at, :updated_at,
  #               :reset_password_token, :reset_password_sent_at
  filter :organizations
  filter :roles
  filter :first_name_or_last_name_cont, as: :string, label: 'Name'
  filter :email
  # filter :first_name
  # filter :last_name

  config.sort_order = 'email_asc'
  config.batch_actions = false

  permit_params :email, :first_name, :last_name, :password,
                memberships_attributes: [:id, :_destroy, :organization_id, :role_id, :user_id]

  index do
    column :email
    column :first_name
    column :last_name
    actions
  end

  show do
    columns do
      column span: 2 do
        attributes_table do
          row :email
          row :first_name
          row :last_name
        end
      end
      column do
        panel 'User Roles' do
          table_for user.memberships do
            column :organization
            column :role
          end
        end
      end
    end

  end

  form do |f|
    f.inputs 'User info' do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :password
    end

    f.inputs 'Membership info' do
      f.has_many :memberships, heading: false, allow_destroy: true do |m|
        m.input :organization
        m.input :role
      end
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
