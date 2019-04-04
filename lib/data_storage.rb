# frozen_string_literal: true

require_relative 'ext/inspect'

class DataStorage
  include Ext::Inspect
  def initialize
    self.data = []
  end

  def []=(key, value)
    buff = data_storage_with_key(key)
    if buff
      buff[1] = value
    else
      data << [key, value]
    end
  end

  def [](key)
    (data_storage_with_key(key) || [])[1]
  end

  def keys
    data.map { |buff| buff[0] }
  end

  def values
    data.map { |buff| buff[1] }
  end

  def delete(key)
    index = data.index { |buff| buff[0].eql?(key) }
    data.delete_at(index)[1] if index
  end

  def key?(key)
    keys.include?(key)
  end

  def length
    data.length
  end

  alias size length

  protected

  attr_accessor :data

  def data_storage_with_key(key)
    data.detect { |buff| buff[0].eql?(key) }
  end
end
