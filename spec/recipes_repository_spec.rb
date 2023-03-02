
RSpec.describe RecipesRepository do
  def reset_recipes_table
    seed_sql = File.read('spec/seeds_recipes_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
    connection.exec(seed_sql)
  end
  
  describe RecipesRepository do
    before(:each) do 
      reset_recipes_table
    end
  
  
    #1
    repo = RecipeRepository.new
    recipe = repo.find(1)
  
    recipe.id # =>  1
    recipe.name # => 'Carbonara'
    recipe.cooking_time # => 12
    recipe.rating # => 5
  
  
    #2
    repo = RecipeRepository.new
    recipe = repo.find(3)
  
    recipe.id # =>  3
    recipe.name # => 'Fried pizza'
    recipe.cooking_time # => 15
    recipe.rating # => 3
  end

end