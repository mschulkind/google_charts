module GoogleCharts

  autoload :Charts, File.dirname(__FILE__) + "/google_charts/charts"

  module Helpers
    def self.define( name, options = {} )
      helper_name = [options[:prefix], name, options[:suffix]||'chart'].compact.join( '_' )

      default_chart_options = options[:defaults] || {}

      GoogleCharts::Helpers.module_eval <<-DEF
        def #{helper_name}( data, options={} )
          chart = GoogleCharts::Charts::#{name.to_s.capitalize}.new( self, data, #{default_chart_options}.merge(options) )
          yield chart if block_given?

          chart.to_html
        end
      DEF
    end

    define :line, defaults: {pointSize: 4}
    define :pie
    define :area, defaults: {pointSize: 4}
    define :bar
    define :column
    define :geo
  end

end

ActionView::Base.send :include, GoogleCharts::Helpers

