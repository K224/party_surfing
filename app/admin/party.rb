ActiveAdmin.register Party do
  permit_params :title, :type, :summary, :blocked, :block_message

  actions :all, except: [:new]

  index do
    column :title
    column :host
    column :type
    column :created_at
    column :updated_at
    actions
  end
  
  form do |f|
    f.inputs do
      f.input :title
      f.input :type
      f.input :summary, :as => 'ckeditor', :label => false
      f.input :blocked
      f.input :block_message
    end
    
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :coord_longitude
      row :coord_latitude
      row :date
      row :host
      row :type
      row :created_at
      row :updated_at
      row :blocked
      row :block_message
      row :summary do |instance| 
        raw instance.summary
      end
    end 
  end
  
  sidebar "Guests", only: [:show, :edit] do
    link_to "Guests list", admin_party_guests_path(party)
  end

  filter :id
  filter :created_at
  filter :updated_at
  filter :type

end
