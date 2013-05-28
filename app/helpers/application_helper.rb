module ApplicationHelper
	def yes_format (yes)
		if yes == "y"
			"Yes"
		else
			"No"
		end
	end
end
