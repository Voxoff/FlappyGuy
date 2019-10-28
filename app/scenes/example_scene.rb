class ExampleScene
  def root
    root = RootFactory.build

    root.guy = GuyFactory.build

    root.camera.target = root.guy

    root
  end
end
