# frozen_string_literal: true

module Console
  class Entry
    attr_accessor :name, :metadata, :parent, :type

    def initialize(name = nil, metadata = nil, parent = nil, _content = nil, type = nil)
      @name = name
      @metadata = metadata
      @parent = parent
      @type = type
    end
  end
end
