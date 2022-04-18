# frozen_string_literal: true

module Console
  class Folder < Entry
    attr_accessor :name, :metadata, :parent

    def initialize(name = nil, metadata = nil)
      super(name, metadata, type = 'folder')
    end

    def create
      puts 'Enter the name of the folder you want to create'
      name = gets.chomp
      metadata = "Created by #{ENV['USER']} at #{Time.now}"
      parent = @working_directory
      Console::Folder.new(name, metadata)
    end
  end
end
