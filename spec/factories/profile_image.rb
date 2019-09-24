FactoryBot.define do
	factory :profile_image do
		profile_image {Refile::FileDouble.new("dummy", "logo.png", content_type: "image/png")}
	end
end