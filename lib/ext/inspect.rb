# frozen_string_literal: true

module Ext
  module Inspect
    def inspect
      parts = keys.map do |key|
        [key, self[key]].map(&:inspect).join('=>')
      end
      '{' + parts.join(', ') + '}'
    end

    alias to_s inspect
  end
end
