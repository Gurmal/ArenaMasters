class Dice < Numeric
  @@sides = 20

  def initialize(sides=20)
    @sides = sides
    @lastroll = self.roll
  end

  def roll()
    rand(@sides)+1
  end

  def to_s
    "1D"+@sides
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