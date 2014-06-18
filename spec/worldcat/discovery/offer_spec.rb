# Copyright 2014 OCLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require_relative '../../spec_helper'

describe WorldCat::Discovery::Offer do
  
  context "when retrieving holdings as offers" do
    before(:all) do
      wskey = OCLC::Auth::WSKey.new('api-key', 'api-key-secret')
      WorldCat::Discovery.configure(wskey)
    end
    
    context "when parsing holdings for The Wittgenstein Reader" do
      before(:all) do
        url = 'https://beta.worldcat.org/discovery/offer/oclc/30780581'
        stub_request(:get, url).to_return(:body => body_content("offer_set.rdf"), :status => 200)
        @results = WorldCat::Discovery::Offer.find_by_oclc(30780581)
      end
    
      it "should return a result set of Offers" do
        @results.offers.each {|offer| offer.class.should == WorldCat::Discovery::Offer}
      end
    end
    
  end
  
end