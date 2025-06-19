# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Tuning.create(ep:1, T:0.13, M:0.13, C:0.13)
Tuning.create(ep:2, T:0.26, M:0.26, C:0.26)
Tuning.create(ep:3, T:0.39, M:0.39, C:0.39)
Tuning.create(ep:4, T:0.52, M:0.52, C:0.52)
Tuning.create(ep:5, T:0.65, M:0.65, C:0.65)