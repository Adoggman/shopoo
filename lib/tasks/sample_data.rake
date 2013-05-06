require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke

    Item.create(:name => "The Elder Scrolls V: Skyrim",
                :description => "RPG",
                :category => "ps3",
                :cost => 59.99,
                :stock => 100,
                :url => "http://videogames.techfresh.net/wp-content/uploads/2011/06/The-Elder-Scrolls-V-Skyrim-Box-Art-11.jpg")

    Item.create(:name => "Guild Wars 2",
                :description => "MMORPG",
                :category => "pc",
                :cost => 59.99,
                :stock => 100,
                :url => "http://i739.photobucket.com/albums/xx35/saladin001/Guild-wars-2-white-cover.jpg")

    Item.create(:name => "Fifa 13",
                :description => "Sports",
                :category => "ps3",
                :cost => 39.99,
                :stock => 100,
                :url => "http://footballtainment.files.wordpress.com/2012/08/fifa13-cover-italy.jpg")

    Item.create(:name => "Halo 4",
                :description => "Shooter",
                :category => "xbox360",
                :cost => 59.99,
                :stock => 100,
                :url => "http://images1.wikia.nocookie.net/__cb20121009145241/halo/images/a/a1/Halo-4-Box-Art.jpg")

    Item.create(:name => "Killzone 3",
                :description => "Shooter",
                :category => "ps3",
                :cost => 29.99,
                :stock => 100,
                :url => "http://mediablogs.los40.com/lanzamientos-2011/files/2011/01/killzone-3-cover.jpg")

    Item.create(:name => "Assassin's Creed 3",
                :description => "Action",
                :category => "ps3",
                :cost => 59.99,
                :stock => 100,
                :url => "http://cdn.slashgear.com/wp-content/uploads/2012/03/42135310150594294428068611916306791026801864215996n.jpg")


    99.times do |n|
      @user = User.new
      @user.firstname = Faker::Name.first_name
      @user.lastname = Faker::Name.last_name
      @user.email = "#{@user.lastname}.#{@user.firstname}@gmail.com"
      @user.password = "password"
      @cart = Cart.new
      @cart.update_attribute :user_id, @user.id
      @shipping_address = Address.new
      @billing_address = Address.new
      @billing_info = BillingInfo.new

      if @user.save
        @cart.save
        @shipping_address.save
        @billing_address.save
        @billing_info.save
        @user.update_attribute :address_id, @shipping_address.id
        @user.update_attribute :billing_info_id, @billing_info.id
        @billing_info.update_attribute :address_id, @billing_address.id
      end

    end
  end
end