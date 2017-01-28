class Dice < Numeric
  
  def initialize(sides=20,quantity=1,modifier=0)
    @sides = sides
    @quantity = quantity
    @modifier = modifier
    @lastroll = roll()
  end

  def roll()
    @lastroll = 0
    @quantity.times do
      @lastroll += rand(@sides)+1
    end
    @lastroll+=@modifier
    return @lastroll
  end

  def to_s
    @quantity.to_s+"D"+@sides.to_s
  end

  def to_i
    @lastroll
  end

  def coerce(other)
    [self.class.new(other.to_i),self]
  end

  def <=>(other)
    to_i <=> other.to_i
  end

  def +(other)
    to_i + other.to_i
  end
end