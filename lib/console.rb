# frozen_string_literal: true

module Console
end
lib_path = __dir__
Dir["#{lib_path}/console/**/*.rb"].sort.each { |file| require file }
