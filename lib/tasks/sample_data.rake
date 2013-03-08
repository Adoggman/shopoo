require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    99.times do |n|
      @user = User.new
      @user.firstname = Faker::Name.first_name
      @user.lastname = Faker::Name.last_name
      @user.email = "#{@user.lastname}.#{@user.firstname}@gmail.com"
      @user.password = "password"
      @cart = Cart.new
      @shipping_address = Address.new
      @billing_address = Address.new
      @billing_info = BillingInfo.new

      if @user.save
        @cart.save
        @shipping_address.save
        @billing_address.save
        @billing_info.save
        @user.update_attribute :cart_id, @cart.id
        @user.update_attribute :address_id, @shipping_address.id
        @user.update_attribute :billing_info_id, @billing_info.id
        @billing_info.update_attribute :address_id, @billing_address.id
      end

    end
  end
end