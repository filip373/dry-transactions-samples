require 'dry/transaction'
require_relative './container'

# module for reusing the configuration as configured in the container

module MyApp
  Transaction = Dry::Transaction(container: Container)
end
