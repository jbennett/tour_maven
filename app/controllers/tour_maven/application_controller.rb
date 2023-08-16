module TourMaven
  class ApplicationController < TourMaven.parent_controller.constantize
    before_action :_authenticate!

    private

    def _authenticate!
      unless instance_eval(&TourMaven.admin_user?)
        redirect_to "/", status: :unauthorized
      end
    end
  end
end
