ActiveAdmin.register Type do

  permit_params :title, :description

  config.filters = false

end
