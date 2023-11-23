# TourMaven

TourMaven is a Rails engine to give your Rails project a built in tour guides backend.

## Installation

1. Add to your Gemfile: `gem "tour_maven", git: 'https://github.com/jbennett/tour_maven.git', branch: 'main'`
2. Copy over the migrations: `rails tour_maven:install:migrations`
3. Mount the engine in your routes.rb: `mount TourMaven::Engine => "/tour_maven"`
4. Add the helpers to your controller: `helper TourMaven::SharedHelpers`
5. Add the javascript includes to your layout <head>: `tour_maven_assets`
6. Add the helpers to the bottom of your layout:
   ```erb
   <%= available_tour_controllers(user: current_user) %>
   <%= tours_controller %>
   ```
7. Add an initializer to authorize the user:
   ```ruby
   TourMaven.configure do |config|
     config.admin_user? do
       current_user&.admin?
     end
   end
   ```

With this setup you can create tours at `/tour_maven/tours`. See the documentation for [Tourguide.js steps](https://tourguidejs.com/docs/steps.html#steps-array) for details on creating your own tours.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
