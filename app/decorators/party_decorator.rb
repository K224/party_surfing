class PartyDecorator < Draper::Decorator
  delegate_all

  def map_image
    markers="markers=color:blue|#{coord_latitude},#{coord_longitude}"
    parameters = "center=#{coord_latitude},#{coord_longitude}&size=300x300&zoom=14&sensor=false"
    h.image_tag "https://maps.googleapis.com/maps/api/staticmap?#{parameters}&#{markers}", class: "img-responsive"
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
