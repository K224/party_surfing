ActiveAdmin.register Party do
  permit_params :title, :type, :coor_latitude, :coord_longitude, :date

  index do
    column :title
    column :host
    column :type
    column :created_at
    column :updated_at
    actions
  end

  sidebar "Guests", only: [:show, :edit] do
    link_to "Guests list", admin_party_guests_path(party)
  end

  filter :created_at
  filter :updated_at
  filter :type

end
