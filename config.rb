compass_config do |config|
  config.output_style = :compact
end

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

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

configure :build do
  activate :cache_buster

  activate :relative_assets

  activate :helpers
end

activate :deploy do |deploy|
  deploy.method = :git
  deploy.branch = 'master'
  deploy.build_before = true
end
