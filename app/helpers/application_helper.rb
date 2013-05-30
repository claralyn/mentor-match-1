module ApplicationHelper

	def yes_format (yes)
		if yes == "y"
			"Yes"
		else
			"No"
		end
	end

	def empty_answer(attribute)
		attribute.presence ? attribute : "-"
	end

end
