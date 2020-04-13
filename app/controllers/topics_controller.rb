class TopicsController < ApplicationController
  def index
    @connect = current_company.connects.find(params[:connect_id])
    @topics = @connect.topics
  end

  def show
    @topic = Topic.find(params[:id])
    @connect = @topic.connect
  end

  def create
    @connect = current_company.connects.find(params[:connect_id])
    @topic = @connect.topics.create(topic_variety: 'other', title: 'その他')
    redirect_to topic_path(@topic)
  end
end
