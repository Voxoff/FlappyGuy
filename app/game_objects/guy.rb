class Guy < GameObject::Base
  belongs_to :root

  boolean :renderable, default: true

  number :flap_duration, default: 0
  number :falling_duration, default: 0

  vector :rotation, default: Vector[0,1]
  vector :flap_vector, default: Vector[0,0]
  vector :target_rotation, default: nil

  behavior :flap_animation

  FALLING_SPEED = 5
  ROTATION_SPEED = 0.1
  DOWN_ROTATION_SPEED = 0.03

  def update
    fall
    handle_falling
    read_user_input
    flap
    follow_target_rotation
    flap_animation.when(true)
  end

  def fall
    if position.y > (0 + (size.height / 2))
      self.position = Vector[position.x, position.y - FALLING_SPEED]
    end
  end

  def falling?
    flap_duration <= 0
  end

  def read_user_input
    input = Input.get_touch(0)
    return if input.nil?

    if input.phase == :began
      self.flap_vector = Vector[0, 10]
      self.flap_duration = 0.5
      self.target_rotation = Vector[-0.2,1]
    end
  end

  def handle_falling
    return unless falling?

    self.falling_duration += Time.delta

    if falling_duration > 0.5
      self.target_rotation = Vector[0.4,1]
    end

    self.flap_vector = Vector[0, 0]
  end

  def flap
    return if falling?

    self.falling_duration = 0
    self.position = self.position + flap_vector
    self.flap_duration -= Time.delta
  end

  def follow_target_rotation
    return unless target_rotation

    rotation_x = self.rotation.x.round(2)
    target_rotation_x = self.target_rotation.x.round(2)

    if target_rotation_x < rotation_x
      self.rotation = Vector[rotation_x - ROTATION_SPEED, self.rotation.y]
    elsif target_rotation_x > rotation_x
      self.rotation = Vector[rotation_x + DOWN_ROTATION_SPEED, self.rotation.y]
    else
      self.target_rotation = nil
    end
  end
end
