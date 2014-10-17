ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation

  actions :all, except: [:new]

  index do
    column :id
    column :email
    column :last_sign_in_at
    column :created_at
    column :profile

    actions
  end

  filter :created_at
  filter :email

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
