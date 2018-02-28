class Station
  attr_reader :zone, :name
  def initialize(name, zone)
    @zone, @name = zone, name
  end
end
