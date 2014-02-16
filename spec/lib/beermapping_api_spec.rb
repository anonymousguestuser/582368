require 'spec_helper'

describe "BeermappingApi" do
  it "When HTTP GET returns one entry, it is parsed and returned" do

    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>13307</id><name>O'Connell's Irish Bar</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=13307</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=13307&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=13307&amp;d=1&amp;type=norm</blogmap><street>Rautatienkatu 24</street><city>Tampere</city><state></state><zip>33100</zip><country>Finland</country><phone>35832227032</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*tampere/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("tampere")

    expect(places.size).to eq(1)
    place = places.first
    expect(place.name).to eq("O'Connell's Irish Bar")
    expect(place.street).to eq("Rautatienkatu 24")
  end

  it "When HTTP GET returns nothing, empty array is returned" do
    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id></id><name></name><status></status><reviewlink></reviewlink><proxylink></proxylink><blogmap></blogmap><street></street><city></city><state></state><zip></zip><country></country><phone></phone><overall></overall><imagecount></imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*tallinn/).to_return(body: canned_answer, headers: {'Content-Type' => "text/xml"})

    places = BeermappingApi.places_in("tallinn")

    expect(places.size).to eq(0)
    expect(places.first).to eq(nil)
  end

  it "When HTTP GET returns multiple entries, all are parsed and returned" do

    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>7428</id><name>Oliver Twist</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=7428</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=7428&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=7428&amp;d=1&amp;type=norm</blogmap><street>Repslagargatan 6</street><city>Stockholm</city><state></state><zip>118 46</zip><country>Sweden</country><phone>46 (0)8 640 05 66</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>7429</id><name>Akkurat</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=7429</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=7429&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=7429&amp;d=1&amp;type=norm</blogmap><street>Hornsgatan 18</street><city>Stockholm</city><state></state><zip></zip><country>Sweden</country><phone>(08) 6440015</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>7430</id><name>Glenfiddich Warehouse No. 68</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=7430</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=7430&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=7430&amp;d=1&amp;type=norm</blogmap><street>Västerlånggatan 68</street><city>Stockholm</city><state></state><zip>111 29</zip><country>Sweden</country><phone>(08) 791 90 90</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>10371</id><name>Monks Café and Brewery</name><status>Brewpub</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=10371</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=10371&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=10371&amp;d=1&amp;type=norm</blogmap><street>Wallingatan 38</street><city>Stockholm</city><state></state><zip>11124</zip><country>Sweden</country><phone>08-23 00 30</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>10372</id><name>Monks Café</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=10372</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=10372&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=10372&amp;d=1&amp;type=norm</blogmap><street>Sveavägen 39</street><city>Stockholm</city><state></state><zip>11134</zip><country>Sweden</country><phone>08-24 13 10</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>10412</id><name>Järnet Restaurang o Bar</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=10412</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=10412&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=10412&amp;d=1&amp;type=norm</blogmap><street>Österlånggatan 34</street><city>Stockholm</city><state></state><zip>111 31</zip><country>Sweden</country><phone>+46-8-107137</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>10413</id><name>Man in the Moon</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=10413</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=10413&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=10413&amp;d=1&amp;type=norm</blogmap><street>Tegnérgatan 2 C</street><city>Stockholm</city><state></state><zip>113 58</zip><country>Sweden</country><phone>+46-8-458 95 00</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>10414</id><name>Mackinlay's Inn</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=10414</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=10414&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=10414&amp;d=1&amp;type=norm</blogmap><street>Fleminggatan 85</street><city>Stockholm</city><state></state><zip>112 34</zip><country>Sweden</country><phone>+46-8-650 83 20</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>11741</id><name>Bishops Arms</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=11741</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=11741&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=11741&amp;d=1&amp;type=norm</blogmap><street>Folkungagatan</street><city>stockholm</city><state></state><zip>11630</zip><country>Sweden</country><phone>004686418890</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*stockholm/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("stockholm")

    expect(places.size).to eq(9)
    expect(places.first.name).to eq("Oliver Twist")
    expect(places.last.name).to eq("Bishops Arms")

  end

end