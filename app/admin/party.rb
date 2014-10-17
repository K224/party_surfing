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
      f.input :summary
      f.input :blocked
      f.input :block_message
    end
    
    f.actions
  end

  sidebar "Guests", only: [:show, :edit] do
    link_to "Guests list", admin_party_guests_path(party)
  end

  filter :created_at
  filter :updated_at
  filter :type

end
