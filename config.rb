###
# Compass
###

# Susy grids in Compass
# First: gem install compass-susy-plugin
# require 'susy'

# Change Compass configuration
compass_config do |config|
  config.output_style = :compact
end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
helpers do
  # Implements the Paul Irish IE conditional comments HTML tag--in HAML.
  # http://paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/
  # Usage, instead of %html use:
  # != cc_html do
  def cc_html(options={}, &blk)
    attrs = options.map { |k, v| " #{h k}='#{h v}'" }.join('')
    [ "<!--[if lt IE 7 ]> <html#{attrs} class='ie6 no-js'> <![endif]-->",
      "<!--[if IE 7 ]>    <html#{attrs} class='ie7 no-js'> <![endif]-->",
      "<!--[if IE 8 ]>    <html#{attrs} class='ie8 no-js'> <![endif]-->",
      "<!--[if IE 9 ]>    <html#{attrs} class='ie9 no-js'> <![endif]-->",
      "<!--[if (gt IE 9)|!(IE)]><!--> <html#{attrs} class='no-js'> <!--<![endif]-->",
      capture_haml(&blk).strip,
      "</html>"
    ].join("\n")
  end

  def h(str); Rack::Utils.escape_html(str); end

end

# require 'source/helpers/helpers.rb'

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  activate :cache_buster

  # Use relative URLs
  activate :relative_assets

  activate :helpers

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end

activate :deploy do |deploy|
  deploy.method = :rsync
  deploy.host = 'r.tomeij.net'
  deploy.user = 'advancedsass'
  deploy.path = '/home/advancedsass/public_html'
  deploy.build_before = true
  deploy.clean = true
end
