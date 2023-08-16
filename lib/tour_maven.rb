require "tour_maven/version"
require "tour_maven/engine"

module TourMaven

  class << self
    attr_reader :admin_user
    attr_reader :parent_controller

    def config(&blk)
      yield(self)
    end

    def admin_user?(&blk)
      @admin_user = blk if blk
      @admin_user
    end

    def parent_controller
      @parent_controller || "::ApplicationController"
    end
  end
end
