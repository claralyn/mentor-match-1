FactoryGirl.define do
	factory :user do
		sequence(:email){ |n| "user#{n}@email.com"}
		password "password"
		password_confirmation "password"

		factory :confirmed_user do
			after_create do |user|
				user.approval = 1
				user.save!
			end
		end


		factory :admin_user do
		  after_create do |user|
		    user.approval = 1
		    user.update_attribute(:admin, true)
			end
		end
	end
end