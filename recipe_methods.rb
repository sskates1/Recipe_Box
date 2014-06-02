require 'pg'

def db_connection
  begin
    connection = PG.connect(dbname: 'recipes')

    yield(connection)

  ensure
    connection.close
  end
end

def get_recipe_names()
  query = "SELECT id,name FROM recipes ORDER BY name"

  recipes = db_connection do |conn|
    conn.exec(query)
  end
  return recipes.to_a
end

def get_recipe(id)
  query = "SELECT name, instructions, description
          FROM recipes
          WHERE id = $1"

  recipe = db_connection do |conn|
    conn.exec_params(query, [id])
  end
  query = "SELECT name
          FROM ingredients
          WHERE recipe_id = $1"

  ingredients = db_connection do |conn|
    conn.exec_params(query,[id])
  end
  return   recipe.to_a, ingredients.to_a
end

