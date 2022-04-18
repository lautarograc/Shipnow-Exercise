# frozen_string_literal: true

module Console
  class Document < Entry
    attr_accessor :name, :content, :metadata, :parent

    def initialize(name = nil, content = nil, metadata = nil, parent = nil)
      super(name, metadata, parent, type = 'file')
      @content = content
    end

    def create
      puts 'Enter the name of the file you want to create'
      name = gets.chomp
      puts 'Enter the content of the file you want to create'
      content = gets.chomp
      metadata = "Created by #{ENV['USER']} at #{Time.now}"
      parent = @working_directory
      Console::Document.new(name, content, metadata)
    end
  end
end
