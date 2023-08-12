module TourMaven
  class Engine < ::Rails::Engine
    isolate_namespace TourMaven

    config.app_middleware.use(
      Rack::Static,
      urls: ["/tour_maven"],
      root: TourMaven::Engine.root.join("public")
    )

    initializer 'tour_maven.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper TourMaven::SharedHelpers
      end
    end
  end
end
