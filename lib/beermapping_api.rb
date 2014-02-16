class BeermappingApi
    def self.places_in(city)
      city = city.downcase
      Rails.cache.fetch(city, expires_in: 60*60*24*7) { fetch_places_in(city) } # cache expires in one week
    end

    def self.get(id)
      unless id.to_i.equal?(0)
        Rails.cache.fetch(id, expires_in: 60*60*24*7) { fetch_id(id) }
      end
    end

    private

    def self.fetch_places_in(city)
      url = "http://beermapping.com/webservice/loccity/#{key}/"

      response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
      places = response.parsed_response["bmp_locations"]["location"]

      return [] if places.is_a?(Hash) and places['id'].nil?

      places = [places] if places.is_a?(Hash)
      places.inject([]) do | set, place |
        set << Place.new(place)
      end
    end

    def self.fetch_id(id)
      url = "http://beermapping.com/webservice/locquery/#{key}/"
      response = HTTParty.get "#{url}#{id}"
      details = response.parsed_response["bmp_locations"]["location"]

      return nil if details.is_a?(Hash) and details['id'].nil?
      return Place.new(details)
    end

  def self.key
    Settings.beermapping_apikey
  end

end