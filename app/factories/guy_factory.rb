module GuyFactory
  module_function
  ANIMATION_RATE = 0.25

  def build
    camera = GameObject::Base.find_by_tag("camera")
    guy = Guy.new
    guy.size = Size[119 / 2, 125 / 2]
    # guy.sprite_name = "flap-up"
    guy.position = Vector[guy.position.x, camera.size.height / 2]

    guy.flap_animation = Animation.new(guy, "flap-up", ["flap-down", "flap-up"], ANIMATION_RATE)

    guy
  end
end
