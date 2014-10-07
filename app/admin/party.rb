ActiveAdmin.register Party do

  index do
    column :title
    column :host
    column :type
    column :created_at
    column :updated_at
    actions
  end

  filter :created_at
  filter :updated_at
  filter :type

end
