module TourMaven
  class ApplicationController < TourMaven.configuration.parent_controller
    before_action :_authenticate!

    private

    def _authenticate!
      unless instance_eval(&TourMaven.configuration.admin_user?)
        redirect_to TourMaven.configuration.redirect_url, alert: I18n.t("tour_maven.flashes.failure_when_not_signed_in")
      end
    end
  end
end
