{{Recipes_directory}} Model and Repository Classes Design Recipe
Copy this recipe template to design and implement Model and Repository classes for a database table.

1. Design and create the Table
As a food lover,
So I can stay organised and decide what to cook,
I'd like to keep a list of all my recipes with their names.

As a food lover,
So I can stay organised and decide what to cook,
I'd like to keep the average cooking time (in minutes) for each recipe.

As a food lover,
So I can stay organised and decide what to cook,
I'd like to give a rating to each of the recipes (from 1 to 5).

If the table is already created in the database, you can skip this step.

Otherwise, follow this recipe to design and create the SQL schema for your table.

In this template, we'll use an example table students

# EXAMPLE

Table: recipes

Columns:
id | name | cooking_time | rating
2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE recipes RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes (name, cooking_time, rating) VALUES ('Carbonara', '12', 5);
INSERT INTO recipes (name, cooking_time, rating) VALUES ('Scallop soup', '40', 5);
INSERT INTO recipes (name, cooking_time, rating) VALUES ('Fried pizza', '15', 3);


psql -h 127.0.0.1 recipes_directory < seeds_recipes.sql
3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

# EXAMPLE
# Table name: recipes

# Model class
# (in lib/recipes.rb)
class Recipe
end

# Repository class
# (in lib/recipe_repository.rb)
class RecipeRepository
end
4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: recipes

# Model class
# (in lib/recipe.rb)

class Recipe

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :cooking_time, :rating
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.

5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# EXAMPLE
# Table name: recipes

# Repository class
# (in lib/recipes_repository.rb)

class RecipesRepository
  
  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cooking_time, rating FROM recipes WHERE id = $1;

    # Returns a single Recipe object.
  end

end
6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get a single recipe id =1

repo = RecipeRepository.new

recipe = repo.find(1)

recipe.id # =>  1
recipe.name # => 'Carbonara'
recipe.cooking_time # => 12
recipe.rating # => 5

# 1
# Get a single recipe id =3

repo = RecipeRepository.new

recipe = repo.find(3)

recipe.id # =>  3
recipe.name # => 'Fried pizza'
recipe.cooking_time # => 15
recipe.rating # => 3
 

Encode this example as a test.

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/recipes_repository_spec.rb

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory' })
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


8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.

