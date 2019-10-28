class Guy < GameObject::Base
  belongs_to :root

  boolean :renderable, default: true
  FALLING_SPEED = 5

  def update
    fall
  end

  def fall
    if position.y > (0 + (size.height / 2))
      self.position = Vector[position.x, position.y - FALLING_SPEED]
    end
  end

  def flap
    # input = Input.get_touch(0)

  end
end
