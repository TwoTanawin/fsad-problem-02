# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear out existing records to avoid duplicates
Category.destroy_all
Quotation.destroy_all

# Create Categories
unknown_heroine = Category.create!(name: 'Unknown Heroine')
ted_turner = Category.create!(name: 'Ted Turner')
anne_slater = Category.create!(name: 'Anne Slater')
gene_fowler = Category.create!(name: 'Gene Fowler')
edward_murrow = Category.create!(name: 'Edward R. Murrow')
frank_leahy = Category.create!(name: 'Frank Leahy')

# Create Quotations
Quotation.create!(author_name: 'Ted Turner', quote: 'I feel like those Jewish people in Germany in 1942.', category: ted_turner)
Quotation.create!(author_name: 'Unknown Heroine', quote: 'If a man speaks in the forest and there is no woman there to hear him, is he still wrong?', category: unknown_heroine)
Quotation.create!(author_name: 'Unknown Heroine', quote: 'Men are like a fine wine. They all start out like grapes, and it’s our job to stomp on them and keep them in the dark where they will mature into something you’d want to have dinner with.', category: unknown_heroine)
Quotation.create!(author_name: 'Anne Slater', quote: 'A woman needs four animals in her life. A mink in the closet. A jaguar in the garage. A tiger in bed. And an ass to pay for it all.', category: anne_slater)
Quotation.create!(author_name: 'Gene Fowler', quote: 'An editor should have a pimp for a brother, so he’d have someone to look up to.', category: gene_fowler)
Quotation.create!(author_name: 'Edward R. Murrow', quote: 'The newest computer can merely compound, at speed, the oldest problem in the relations between human beings, and in the end the communicator will be confronted with the old problem, of what to say and how to say it.', category: edward_murrow)
Quotation.create!(author_name: 'Frank Leahy', quote: 'Egotism is the anesthetic that dulls the pain of stupidity.', category: frank_leahy)

puts "Seeding completed!"
