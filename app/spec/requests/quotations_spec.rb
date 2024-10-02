require 'rails_helper'

RSpec.describe "Quotations", type: :request do
  let!(:category) { Category.create(name: "Inspiration") }
  let!(:quotation) { Quotation.create(author_name: "John Doe", quote: "Keep going.", category: category) }

  describe "GET /quotations" do
    it "returns JSON format" do
      get "/quotations", headers: { "ACCEPT" => "application/json" }
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it "returns XML format" do
      get "/quotations", headers: { "ACCEPT" => "application/xml" }
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("application/xml; charset=utf-8")
    end
  end

  describe "GET /quotations/:id" do
    it "returns a single quotation in JSON format" do
      get "/quotations/#{quotation.id}", headers: { "ACCEPT" => "application/json" }
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it "returns a single quotation in XML format" do
      get "/quotations/#{quotation.id}", headers: { "ACCEPT" => "application/xml" }
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq("application/xml; charset=utf-8")
    end
  end
end
