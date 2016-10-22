require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  describe "PUT #update" do
    it "updates a post" do
      topic = create(:topic)
      post = create(:post, topic: topic)

      put :update, topic_id: topic.id, id: post.id, post: {
        title: "This is a test title",
        body: "This is a test body body body"
      }, format: :json

      response_body = JSON.parse(response.body)

      expect(response_body["title"]).to eq("This is a test title")
      expect(response_body["body"]).to eq("This is a test body body body")
    end
  end

  describe "DELETE #destroy" do
    it "destroys a post" do
      topic = create(:topic)
      post = create(:post, topic: topic)

      delete :destroy, topic_id: topic.id, id: post.id

      response_body = JSON.parse(response.body)

      expect(response_body["id"]).to eq(post.id)
      expect(Post.where(id: post.id).count).to eq(0)
    end
  end

  describe "POST #create" do
    it "creates a post" do
      user = create(:user)
      topic = create(:topic)

      post :create, topic_id: topic.id, post: {
        title: "This is a test title",
        body: "This is a test body body body",
        user_id: user.id
      }, format: :json

      response_body = JSON.parse(response.body)

      expect(response_body["title"]).to eq("This is a test title")
      expect(response_body["body"]).to eq("This is a test body body body")
      expect(response_body["user_id"]).to eq(user.id)
    end
  end
end
