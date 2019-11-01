class Guy < GameObject::Base
  belongs_to :root

  boolean :renderable, default: true
  vector :flap_vector, default: Vector[0,0]
  number :flap_duration, default: 0

  vector :flap_rotation, default: Vector[0,1]

  behavior :flap_animation

  FALLING_SPEED = 5

  def update
    fall
    read_user_input
    flap
    flap_animation.when(true)
  end

  def fall
    if position.y > (0 + (size.height / 2))
      self.position = Vector[position.x, position.y - FALLING_SPEED]
    end
  end

  def read_user_input
    input = Input.get_touch(0)
    return if input.nil?

    if input.phase == :began
      self.flap_vector = Vector[0, 10]
      self.flap_duration = 0.5
    end
  end

  def flap
    if flap_duration <= 0
      self.flap_vector = Vector[0, 0]
    end
    self.flap_rotation = Vector[0,10]

    self.position = self.position + flap_vector
    self.flap_duration -= Time.delta
  end
end
