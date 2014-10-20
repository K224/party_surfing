ActiveAdmin.register Profile do
  permit_params :name, :surname, :birthday, :contacts, :photo

  actions :all, except: [:new]

  menu false
  
  index do
    column :full_name
    column :user
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :surname
      f.input :birthday
      f.input :photo
      f.input :contacts, :as => :ckeditor, :label => false
    end
    
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :surname
      row :photo
      row :birthday
      row :user
      row :created_at
      row :updated_at
      row :contacts do |instance| 
        raw instance.contacts
      end
    end 
  end

  filter :name
  filter :surname
  filter :birthday

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
