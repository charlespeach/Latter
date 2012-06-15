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

describe GamesController do
  login_player

  # This should return the minimal set of attributes required to create a valid
  # Game. As you add validations to Game, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { :challenged_id => FactoryGirl.create(:player).id }
  end

  describe "GET index" do
    it "assigns all games as @games" do
      game = FactoryGirl.create :game
      get :index, {}
      assigns(:games).should eq([game])
    end
  end


  describe "GET new" do
    it "assigns a new game as @game" do
      get :new, {}
      assigns(:game).should be_a_new(Game)
    end

    it "renders the new game template" do
      get :new, {}
      response.should render_template 'new'
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Game" do
        expect {
          post :create, {:game => valid_attributes}
        }.to change(Game, :count).by(1)
      end

      it "assigns a newly created game as @game" do
        post :create, {:game => valid_attributes}
        assigns(:game).should be_a(Game)
        assigns(:game).should be_persisted
      end

      it "redirects to the players page" do
        post :create, {:game => valid_attributes}
        response.should redirect_to(Player)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved game as @game" do
        # Trigger the behavior that occurs when invalid params are submitted
        Game.any_instance.stub(:save).and_return(false)
        post :create, {:game => {}}
        assigns(:game).should be_a_new(Game)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Game.any_instance.stub(:save).and_return(false)
        post :create, {:game => {}}
        response.should render_template("new")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested game" do
      game = FactoryGirl.create :game
      expect {
        delete :destroy, {:id => game.to_param}
      }.to change(Game, :count).by(-1)
    end

    it "redirects to the games list" do
      game = FactoryGirl.create(:game)
      delete :destroy, {:id => game.to_param}
      response.should redirect_to(games_url)
    end
  end

end
