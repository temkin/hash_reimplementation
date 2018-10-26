require 'prime'
require_relative 'ext/inspect'
require_relative 'data_storage'

# THE GOAL:
# Implement Data structure HashTable using arrays.
# Hint: https://launchschool.com/blog/how-the-hash-works-in-ruby

# Minimum Behaviour
# 1)  t = HashTable.new

# t[1] = 2
# t[‘hello’] = ‘world’

# puts t
# => { 1 => 2, ‘hello’ => ‘world’ }

# 2) Add an ability to change hash algorithm.
# Basic algorithm should be based on :object_id method of any ruby object.

# Need to implement one hash function, taking in maid that we need to have a simple way to replace it in the future.

# Requireements:
# Just couple classes covered by tests.

class HashTable
  include Ext::Inspect

  attr_accessor :keys

  def initialize
    self.keys       = []
    # TODO: benchmark to figure out more eficient size/length
    self.max_size   = 20
    self.max_length = 100
    self.storage ||= Array.new(max_size)
  end

  def []=(key, value)
    self.keys << key unless has_key?(key)

    digest = hash_algorithm(key)
    stored = storage[digest]
    case stored
    when nil
      storage[digest] = DataStorage.new.tap { |h| h[key] = value }
    when DataStorage
      (stored[key] = value).tap { extend_storage if stored.length > max_length }
    end
  end

  def [](key)
    data_map = storage[hash_algorithm(key)]
    data_map.nil? ? nil : data_map[key]
  end

  def has_key?(key)
    value_index = hash_algorithm(key)
    return false if storage[value_index].nil?
    storage[value_index].keys.include?(key)
  end

  alias key? has_key?

  def length
    keys.length
  end

  def values
    keys.map { |k| storage[hash_algorithm(k)][k] }
  end

  def delete(key)
    return nil unless keys.include?(key)
    index = hash_algorithm(key)
    storage[index].delete(key).tap do
      keys.delete(key)
    end
  end

  protected

  attr_accessor :max_size, :max_length, :storage

  private

  def hash_algorithm(key)
    raw_digest = key.object_id
    raw_digest % max_size
  end

  def next_size
    primes.detect { |p| p > (max_size * 2) }
  end

  def primes
    @primes ||= Prime.each
  end

  def extend_storage
    new_size = next_size
    other = self.class.new
    other.max_size = new_size
    keys.each { |key| other[key] = self[key] }

    self.storage = other.storage
    self.max_size      = new_size
    self
  end
end
