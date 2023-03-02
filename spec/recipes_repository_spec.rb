# Paired with Paul Lazar

require 'recipes_repository'
require 'database_connection'

RSpec.describe RecipesRepository do
  def reset_recipes_table
    seed_sql = File.read('spec/seeds_recipes_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_recipes_table
  end
  
  it "Returns all recipes from the list of recipes." do
    repo = RecipesRepository.new
    recipe = repo.all
    expect(recipe.first.id).to eq 1
    expect(recipe.first.name).to eq "Carbonara" 
    expect(recipe.first.cooking_time).to eq 12 
    expect(recipe.first.rating).to eq 5 
  end

  it "Returns recipe 1 when id = 1." do
    repo = RecipesRepository.new
    recipe = repo.find(1)
    
    expect(recipe.id).to eq 1
    expect(recipe.name).to eq 'Carbonara'
    expect(recipe.cooking_time).to eq 12
    expect(recipe.rating).to eq 5
  end
   
  it "Returns recipe 3 when id = 3." do
    repo = RecipesRepository.new
    recipe = repo.find(3)
  
    expect(recipe.id).to eq 3
    expect(recipe.name).to eq 'Fried pizza'
    expect(recipe.cooking_time).to eq 15
    expect(recipe.rating).to eq 3
  end
end