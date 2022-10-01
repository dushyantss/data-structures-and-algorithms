# frozen_string_literal: true

# The top level module for all algorithms
module Algorithms; end
# The top level module for all data structures
module DataStructures; end

# Quick and easy way to require everything
lib_dir = File.dirname(__FILE__)
%w[algorithms data_structures].each do |subfolder|
  Dir.glob("#{lib_dir}/#{subfolder}/**/*.rb").sort.each { |f| require f }
end
