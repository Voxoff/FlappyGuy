module GuyFactory
  module_function

  def build
    camera = GameObject::Base.find_by_tag("camera")
    guy = Guy.new
    guy.size = Size[119 / 2, 125 / 2]

    guy.position = Vector[guy.position.x, camera.size.height / 2]
    guy
  end
end
