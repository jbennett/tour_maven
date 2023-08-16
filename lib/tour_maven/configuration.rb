module TourMaven
  class Configuration
    attr_accessor :admin_user
    attr_accessor :parent_controller
    attr_accessor :redirect_url

    def initialize
      @redirect_url = "/"
    end

    def parent_controller
      (@parent_controller || "::ApplicationController").to_s.constantize
    end

    def admin_user?(&blk)
      @admin_user = blk if blk
      @admin_user
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield(configuration)
  end
end