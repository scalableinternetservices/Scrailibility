class DiscoveriesController < ApplicationController
	before_filter :authenticate_user!
	#need to change here! currently just show all the registered users
	#how to verify the identify of current user
  	def show
  		if current_user.profile.nil?
  			redirect_to new_profile_path
  			return
  		end
  		@people = Profile.all

      	#@people = Discoveries.instance.findNearbyUsers(current_user.id, 500)

  	end

end
