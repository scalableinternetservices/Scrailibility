class Profile < ActiveRecord::Base
	belongs_to :user, foreign_key: "user_id", class_name: 'User'
	
	validates :name, presence: true
	has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png",
					  url: "/assets/profile/image/:id/:style/:basename.:extesnsion",
					  path: ":rails_root/public/assets/profile/image/:id/:style/:basename.:extesnsion"
    # attr_accessible :add1,:add2,:city,:state,:post_code,:latitude, :longitude
    geocoded_by :full_street_address   # can also be an IP address
 
  

   def full_street_address
     [add1, add2, city, state, post_code].compact.join(', ')
   end
    after_validation :geocode ,:if => :add1_changed?
    # ,:if => :address_changed?      # auto-fetch coordinates

  	validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  	validates_attachment_size :photo, less_than: 5.megabytes
end
