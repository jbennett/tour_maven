# TourMaven

TourMaven is a Rails engine to give your Rails project a built in tour guides backend.

Add the gem, mount the engine, install the migrations, and add a 3 lines to your layout and you are ready to go! 

## Installation

1. Add to your Gemfile: `gem "tour_maven", git: 'https://github.com/jbennett/tour_maven.git', branch: 'main'`
2. Copy over the migrations: `rails tour_maven:install:migrations`
3. Mount the engine in your routes.rb: `mount TourMaven::Engine => "/tour_maven"`
4. Add the javascript includes to your layout <head>:
   ```
   <%= javascript_include_tag "/tm-assets/application.js", "data-turbo-track": "reload" %>
   <%= stylesheet_link_tag "/tm-assets/application.css", "data-turbo-track": "reload" %>
   ```
5. Add the helpers to the bottom of your layout:
   ```
   <%= available_tour_controllers(user: current_user) %>
   <%= tours_controller %>
   ```

With this setup you can create tours at `/tour_maven/tours`. See the documentation for [Tourguide.js steps](https://tourguidejs.com/docs/steps.html#steps-array) for details on creating your own tours.   

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
