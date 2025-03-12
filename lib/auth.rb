require 'jwt'

class jwt

    SECRET_KEY = ENV['JWT_SECRET']


    def self.encode(payload, exp = 24.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, SECRET_KEY, 'HS256')
    end


    def self.decode(token)
        JWT.decode(token, SECRET_KEY, 'HS256')
    end
    

end
