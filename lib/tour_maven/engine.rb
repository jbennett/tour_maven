module TourMaven
  class Engine < ::Rails::Engine
    isolate_namespace TourMaven

    config.app_middleware.use(
      Rack::Static,
      urls: ["/tm-assets"],
      root: TourMaven::Engine.root.join("public")
    )
  end
end
