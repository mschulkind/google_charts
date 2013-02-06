module GoogleCharts::Charts

  class Line < GoogleCharts::Charts::Base
    def initialize( template, collection, options = {} )
      super

      @label, @values = [], []
    end

    def label(name, method = nil, &block); @label = [name, block ? block : method]; end
    def value(name, method = nil, type = 'number', &block); @values << [name, type, block ? block : method]; end


    private

    def setup_data
      unless @label.empty?
        # setup the columns
        add_column( 'string', @label.first )
      end
      
      @values.each { |val| add_column( val[1], val.first ) }

      # setup the rows
      @collection.each do |col|
        unless @label.empty?
          label = value_for( @label.last, col )
        end
        values = @values.map { |value| value_for( value.last, col ) }

        add_row( [label, *values].compact )
      end
    end
  end

end

