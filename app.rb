require_relative 'lib/database_connection'
require_relative 'lib/recipes_repository'

DatabaseConnection.connect('recipes_library')

recipes_repository = RecipesRepository.new

recipes_repository.all.each do |recipe|
  p recipe
end
