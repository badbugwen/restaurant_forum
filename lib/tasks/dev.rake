namespace :dev do
  task fake: :environment do
    Restaurant.destroy_all

    500.times do |i|
      Restaurant.create!(
        name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample,
        image: File.open(Rails.root.join("seed_img/#{rand(1..3)}.jpg"))
      )
    end
    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data"

    users = User.all
    users.each do |user|
          if !user.admin? && user.name != "User"
            user.destroy
          end
        end

    20.times do |i|
      User.create!(
        email: FFaker::Internet.email,
        password: "123456",
        name: FFaker::Name.name,
        intro: FFaker::Lorem.paragraph
        )
    end  
    puts "have created fake users"
    puts "now you have #{User.count} users date"


    1500.times do |i|
      Favorite.create!(
        user_id: User.all.sample.id,
        restaurant_id: Restaurant.all.sample.id
        )
    end
    puts "have created fake favorites"
    puts "now you have 1500 fake favorites"

    1500.times do |i|
      Like.create!(
        user_id: User.all.sample.id,
        restaurant_id: Restaurant.all.sample.id
        )
    end
    puts "have created fakelikes"
    puts "now you have 1500 fake likes"


    Comment.destroy_all
    restaurants = Restaurant.all 
    restaurants.each do |restaurant|
      3.times do |i|
        Comment.create!(
          content: FFaker::Lorem.sentence,
          restaurant_id: restaurant.id,
          user_id: User.all.sample.id
          )
      end
    end
    puts "have created fake comments"
    puts "now you have #{Comment.count} comments data"  

  end
end