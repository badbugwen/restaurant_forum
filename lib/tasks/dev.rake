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
        category: Category.all.sample
      )
    end
    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data"

    users = User.all
    users.each do |user|
          if !user.admin?
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