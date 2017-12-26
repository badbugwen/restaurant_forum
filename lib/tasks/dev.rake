namespace :dev do
  task fake: :environment do
    Restaurant.destroy_all

    500.times do |i|
      Restaurant.create!(name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample
      )
    end
    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data"

    
  
    20.times do |i|
      User.create!(email: FFaker::Internet.email,
        password: "123456"
        )
    end  
    puts "now you have #{User.count} users data"


    
  end
end