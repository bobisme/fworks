require 'json'

module JSONSerializable
  def to_json(*)
    to_h.to_json
  end
end

class Artist
  include JSONSerializable

  attr_accessor :id, :name

  def initialize(**kwargs)
    @id = kwargs[:id]
    @name = kwargs[:name]
  end

  def to_h
    { id: id, name: name }
  end
end
