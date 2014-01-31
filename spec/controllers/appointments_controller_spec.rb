require 'spec_helper'

describe V1::AppointmentsController do

  after(:each) do
    Appointment.destroy_all
  end

  context "GET /" do

    it "should respond with all appointments" do
      FactoryGirl.create(:appointment)
      FactoryGirl.create(:appointment)

      get :index

      appointments = JSON.parse(response.body)

      appointments.length.should eq(2)
    end

    it "should always respond with 200" do

      get :index

      response.status.should eq(200)
    end
  end

  context "GET /:id" do

    before(:each) do
      @appointment = FactoryGirl.create(:appointment)
    end

    it "should respond with correct appointment" do

      get :show, id: @appointment.id

      appointment = JSON.parse(response.body)
      appointment["first_name"].should eq(@appointment.first_name)
      appointment["last_name"].should eq(@appointment.last_name)
      appointment["id"].should eq(@appointment.id)
      appointment["start_time"].should eq(@appointment.start_time)
      appointment["end_time"].should eq(@appointment.end_time)
    end

    it "should respond with 200 when found" do
      get :show, id: @appointment.id

      response.status.should eq(200)
    end

    it "should respond with 404 when not found" do
      get :show, id: 0

      response.status.should eq(404)
    end
  end

  context "POST /" do

    it "should create a new appointment with valid attributes" do
      params = FactoryGirl.attributes_for(:appointment)
      post :create, appointment: params
      
      response.status.should eq(201)

      @appointment = Appointment.where(first_name: params[:first_name], last_name: params[:last_name]).first
      params[:first_name].should eq(@appointment.first_name)
      params[:last_name].should eq(@appointment.last_name)
      params[:start_time].should eq(@appointment.start_time)
      params[:end_time].should eq(@appointment.end_time)
    end

    it "should not create new appointment with invalid attributes" do
      post :create, appointment: {first_name: ""}
      
      response.status.should eq(422)
      Appointment.all.empty?.should eq(true)
    end
  end

  context "PUT /:id" do

    before(:each) do
      @appointment = FactoryGirl.create(:appointment)
    end

    it "should update an appointment with valid attributes" do
      put :update, id: @appointment.id, appointment: {first_name: "updated"}

      appointment = Appointment.find(@appointment.id)

      appointment.first_name.should eq("updated")
      response.status.should eq(200)
    end

    it "should not update an appointment with invalid attributes" do
      put :update, id: @appointment.id, appointment: {first_name: ""}

      appointment = Appointment.find(@appointment.id)

      appointment.first_name.should_not eq("updated")
      response.status.should eq(422)
    end

    it "should respond with 404 when not found" do
      put :update, id: 0

      response.status.should eq(404)
    end


  end

  context "DELETE /:id" do

    before(:each) do
      @appointment = FactoryGirl.create(:appointment)
    end

    it "should delete an appointment when found" do
      delete :destroy, id: @appointment.id

      Appointment.exists?(id:  @appointment.id).should eq(false)
      response.status.should eq(200)
    end

    it "should respond with 404 when not found" do
      delete :destroy, id: 0

      response.status.should eq(404)
    end

  end
end