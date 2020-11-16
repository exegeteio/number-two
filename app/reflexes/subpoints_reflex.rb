# frozen_string_literal: true

class SubpointsReflex < ApplicationReflex
  def update(points)
    cable_ready["subpoints_#{current_user.username}"].inner_html(
      selector: '#subpoints',
      html: points
    )
    cable_ready.broadcast
  end
end
