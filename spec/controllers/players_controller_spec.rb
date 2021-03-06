require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe PlayersController do
  login_player

  let(:player) { FactoryGirl.create(:player) }

  # This should return the minimal set of attributes required to create a valid
  # Player. As you add validations to Player, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    attributes = FactoryGirl.attributes_for(:player).except(:confirmed_at, :changed_password)
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PlayersController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all players as @players" do
      player
      get :index, {}
      assigns(:players).should include player
    end
  end

  describe "GET index format JSON" do
    it "renders the correct template" do
      get :index, :format => :json
      response.should render_template "index"
    end
  end

  describe "GET show" do
    let(:player) { FactoryGirl.build_stubbed(:player) }
    before { Player.stub(find: player) }
    it "assigns the requested player as @player" do
      get :show, {:id => player.to_param}
      assigns(:player).should eq(player)
    end
  end

  describe "GET show format JSON" do
    it "renders the correct template" do
      get :show, :id => player.to_param, :format => :json
      response.should render_template "show"
    end
  end

  describe "GET current " do
    it "should not find a route" do
      get :current
      response.should_not be_ok
    end
  end

  describe "GET current format JSON" do
    it "renders the correct template" do
      get :current, :format => :json
      response.should render_template "show"
    end
  end

  describe "GET new" do
    it "assigns a new player as @player" do
      get :new, {}
      assigns(:player).should be_a_new(Player)
    end
  end

  describe "GET edit" do
    it "assigns the requested player as @player" do
      get :edit, {:id => player.to_param}
      assigns(:player).should eq(controller.current_player)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Player" do
        expect {
          post :create, {:player => valid_attributes}
        }.to change(Player, :count).by(1)
      end

      it "assigns a newly created player as @player" do
        post :create, {:player => valid_attributes}
        assigns(:player).should be_a(Player)
        assigns(:player).should be_persisted
      end

      it "redirects to the created player" do
        post :create, {:player => valid_attributes}
        response.should redirect_to(Player)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved player as @player" do
        # Trigger the behavior that occurs when invalid params are submitted
        Player.any_instance.stub(:save).and_return(false)
        post :create, {:player => {:name => "Test"}}
        assigns(:player).should be_a_new(Player)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Player.any_instance.stub(:save).and_return(false)
        post :create, {:player => {:name => "Test"}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested player" do
        # Assuming there are no other players in the database, this
        # specifies that the Player created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Player.any_instance.should_receive(:update_with_password).with({'name' => 'Tester'})
        put :update, {:id => player.to_param, :player => {'name' => 'Tester'}}
      end

      it "assigns the requested player as @player" do
        put :update, {:id => player.to_param, :player => valid_attributes}
        assigns(:player).should eq(controller.current_player)
      end
    end

    describe "with invalid params" do
      it "assigns the player as @player" do
        # Trigger the behavior that occurs when invalid params are submitted
        Player.any_instance.stub(:save).and_return(false)
        put :update, {:id => player.to_param, :player => {:name => "Test"}}
        assigns(:player).should eq(controller.current_player)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Player.any_instance.stub(:save).and_return(false)
        put :update, {:id => player.to_param, :player => {:name => "Test"}}
        response.should render_template("edit")
      end
    end
  end
end
