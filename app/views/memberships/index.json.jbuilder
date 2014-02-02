json.array!(@memberships) do |membership|
  json.extract! membership, :id, :User_id, :BeerClub_id
  json.url membership_url(membership, format: :json)
end
