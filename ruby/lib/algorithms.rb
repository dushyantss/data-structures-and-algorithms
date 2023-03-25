# frozen_string_literal: true

# Algorithms is the top level module for all algorithms
module Algorithms; end
# DataStructures is the top level module for all data structures
module DataStructures; end

# Quick and easy way to require everything
lib_dir = File.dirname(__FILE__)
%w[algorithms data_structures].each do |subfolder|
  Dir.glob("#{lib_dir}/#{subfolder}/**/*.rb").each { |f| require f }
end
