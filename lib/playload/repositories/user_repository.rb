class UserRepository < Hanami::Repository
	def find_by(conditions)
		users.where(conditions).limit(1).one
	end
end
