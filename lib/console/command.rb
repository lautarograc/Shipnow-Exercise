# frozen_string_literal: true

module Console
  class Command
    attr_accessor :folder_array, :working_directory

    def initialize
      @commands = %w[help create save load ls metadata cd whereami cdparent show
                     destroy]
      @working_directory = working_directory
      self.folder_array = []
    end

    def save
      Dir.mkdir('../saves') unless Dir.exist?('../saves')
      File.open('../saves/folder_array.txt', 'wb') { |f| f.write(Marshal.dump(@folder_array)) }
    end

    def load
      File.open('../saves/folder_array.txt', 'rb') { |f| @folder_array = Marshal.load(f) }
    end

    def help
      puts 'Remember that you only need to enter the name of the command you want to execute, input will then be asked for the necessary information'
      puts "Available commands: #{@commands}"
      puts 'Command create will create a new file or folder'
      puts 'Command ls will list all files and folders in the current directory'
      puts 'Command show will show the content of a file'
      puts 'Command destroy will destroy a file or folder'
      puts 'Command metadata will show the metadata of a file or folder'
      puts 'Command whereami will show the current working directory'
      puts 'Command cd will change the current working directory'
      puts 'Command cdparent will change the current working directory to the parent directory'
      puts 'Command save will save the current state of the folder_array'
      puts 'Command load will load the last saved state of the folder_array'
      puts 'Command help will show this help'
    end

    def cd
      puts 'Enter the name of the folder you want to set as working directory'
      input = gets.chomp
      if folder_array.include?(input)
        @working_directory = input
      else
        new_folder = Console::Folder.new(name = input)
        @working_directory = new_folder.name
        folder_array << { name: input, type: 'folder',
                          metadata: new_folder.metadata, parent: Console::Folder.new(name = 'root').name }
      end
    end

    def metadata
      puts 'Enter the name of the file or folder you want to get the metadata from'
      name = gets.chomp
      folder_array.each do |key|
          puts "Metadata: #{key[:metadata]}" if key[:name] == name
      end
    end

    def whereami
      puts "The current working directory is #{@working_directory}"
    end

    def cdparent
      folder_array.each do |key|
          @working_directory = key[:parent] if key[:name] == @working_directory
        end
      end

    def show
      puts 'Enter the name of the file you want to show'
      name = gets.chomp
        folder_array.each do |key|
          if key[:name] == name && key[:type] == 'file'
            puts "Title: #{key[:name]}, Metadata: #{key[:metadata]}, Content: #{key[:content]}, Parent: #{key[:parent]}"
          end
      end
    end

    # now working?
    def destroy
      puts 'Enter the name of the file or folder you want to destroy'
      name = gets.chomp
      folder_array.each do |key|
        if key[:name] == name && key[:type] == 'file'
          folder_array.delete(key)
        elsif key[:name] == name && key[:type] == 'folder'
          folder_array.reject! { |f| f[:parent] == name }
          folder_array.delete(key)
        end
      end
    end

    def create; end

    def ls
      puts "List of files and folders in #{@working_directory}"
      @folder_array.each do |f|
        puts "#{f[:name]} (#{f[:type]})" if f[:parent] == @working_directory
      end
    end

    def execute_command
      if @folder_array == []
        puts 'Do you want to load the last saved state? (y/n)'
        answer = gets.chomp
        load if answer == 'y'
      end
      cd if @working_directory.nil?
      puts 'Enter the name of the command you want to execute. PS: Type help for a list of commands'
      command = gets.chomp
      if @commands.include?(command)
        case command
        when 'help'
          help
        when 'save'
          save
        when 'whereami'
          whereami
        when 'cdparent'
          cdparent
        when 'destroy'
          destroy
        when 'metadata'
          metadata
        when 'cd'
          cd
        when 'create'
          puts 'Enter folder to create a folder or file to create a file'
          type = gets.chomp
          if type == 'folder'
            new_folder = Console::Folder.new.create
            folder_array << { name: new_folder.name, type: 'folder', metadata: new_folder.metadata,
                              parent: @working_directory }
          else
            new_file = Console::Document.new.create
            folder_array << { name: new_file.name, type: 'file', content: new_file.content, metadata: new_file.metadata,
                              parent: @working_directory }
          end
        when 'ls'
          ls
        when 'show'
          show
        end
        execute_command
      else
        puts 'Command not found'
      end
    end
  end
end
