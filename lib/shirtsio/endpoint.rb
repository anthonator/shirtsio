class Shirtsio::Endpoint
  def initialize(json)
    @mash = Hashie::Mash.new(json)
  end

  def method_missing(method, *args, &block)
    return super unless @mash.respond_to?(method)
    @mash.send(method, *args, &block)
  end

  def respond_to?(method)
    @mash.respond_to?(method)
  end
end
