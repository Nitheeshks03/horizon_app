#seed data

def seed_category
  categories = ["Casual", "Formal", "Sports"]

  categories.each do |category|
    Category.create(name: category)
  end

  puts "Categories seeded successfully"
end

#call seed methods

seed_category
