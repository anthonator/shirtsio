class Shirtsio::DSL
  SIZES = [:xxsml, :xsml, :sml, :med, :lrg, :xlg, :xxl, :xxxl, :xxxxl, :xxxxxl, :xxxxxxl]
  private_constant :SIZES

  QUOTE = [
    :print_type,
    :personalization,
    :address_count,
    :extra_screens,
    :ship_type,
    :international_garment_count,
    :garment => [
      :product_id,
      :color,
      :sizes => SIZES
    ],
    :print => [
      :front => [:color_count, :colors],
      :left => [:color_count, :colors],
      :right => [:color_count, :colors],
      :back => [:color_count, :colors]
    ]
  ]

  ORDER = [
    :test,
    :price,
    :print_type,
    :extra_screens,
    :ship_type,
    :packing_slip,
    :garment => [
      :product_id,
      :color,
      :sizes => SIZES
    ],
    :print => [
      :front => [:artwork, :proof, :color_count, :colors, :dimensions, :placement],
      :left => [:artwork, :proof, :color_count, :colors, :dimensions, :placement],
      :right => [:artwork, :proof, :color_count, :colors, :dimensions, :placement],
      :back => [:artwork, :proof, :color_count, :colors, :dimensions, :placement]
    ],
    :personalization => [
      :size,
      :batch,
      :number,
      :number_size,
      :name,
      :name_size
    ],
    :addresses => [
      :name,
      :company,
      :address,
      :address2,
      :city,
      :state,
      :zipcode,
      :country,
      :batch,
      :sizes => SIZES,
    ]
  ]

  class QueryBuilder
    def initialize(dsl, prefixes_with_index = [], &block)
      @dsl = dsl
      @prefixes_with_index = []
      @prefixes_with_index << prefixes_with_index
      @prefixes_with_index.flatten!
      @params = {}
      yield self
    end

    def method_missing(method, *args, &block)
      index = extract_index(method.to_sym)
      return super unless index
      params = {}
      if index.kind_of?(Symbol)
        if args[0].kind_of?(Array)
          args[0].each_with_index do |v,i|
            params[method] = { i => v }
          end
        else
          params[method] = args[0]
        end
      elsif index.kind_of?(Array)
        params[method] = QueryBuilder.new(index, @prefixes_with_index, &block).to_hash
      end
      params.map do |k,v|
        if @prefixes_with_index.include?(k)
          @params[k] = {} if @params[k].nil?
          @params[k].merge!({ @params[k].size => v })
        else
          @params.merge!({ k => v })
        end
      end
    end

    def to_hash
      @params
    end

    private
    def extract_index(method)
      return method if @dsl.include?(method)
      @dsl.each do |i|
        if i.kind_of?(Hash) && !i[method].nil?
          return i[method]
        end
      end
      nil
    end
  end
end
