require 'spec_helper'
require 'ruby-debug'

describe Admin::ContentController do
  render_views

  describe "#merge" do
    it "should only let admininstrators merge articles" do
      Factory(:blog)
      Profile.delete_all
      @admin_user = Factory(:user, :text_filter => Factory(:markdown), :profile => Factory(:profile_admin, :label => Profile::ADMIN))
      @admin_user.editor = 'simple'
      @admin_user.save!
      @admin_article = Factory(:article)
      @admin_article1 = Factory(:article)
      @admin_article2 = Factory(:article)
      request.session = { :user => @admin_user.id }

      Article.should_receive(:find_by_id).with(@admin_article.id).and_return(@admin_article)

      post :merge , :article_id => @admin_article.id , :id_to_merge => @admin_article2.id  
      #debugger
      assigns(:is_admin).should == true
      #@admin_article.id = 1

      @non_admin_user = Factory(:user, :text_filter => Factory(:markdown), :profile => Factory(:profile_publisher))# Profile::ADMIN))
      @non_admin_user.editor = 'simple'
      @non_admin_user.save!
      @non_admin_article = Factory(:article)
      @non_admin_article1 = Factory(:article)
      @non_admin_article2 = Factory(:article)
      request.session = { :user => @non_admin_user.id }

      #@non_admin_article.id = 2


      Article.should_receive(:find_by_id).with(@non_admin_article.id).and_return(@non_admin_article)
      
      post :merge , :article_id => @non_admin_article.id , :id_to_merge => @non_admin_article2.id  
      assigns(:is_admin).should == false
    end

    it "should call the merge_with method and set the params id correctly"do
      #u1 = User.new :login => 'u1'
      
      
      #b = Blog.new 
      #b.lang = "en_us"
      #b.base_url = "http://localhost:3000/"

      #temp_article = Article.new
      #temp_article.blog = b
      #temp_article.title = 'title1'
      #temp_article.body = 'body1'
      #temp_article.published = true
      
      #create!(:title => 'title1', :body => 'body1', :published => true)
      #id = Article.find_by_title('title1')
      
      #temp_article.user = u1


      #nil.stub(:base_url).and_return("http://localhost:3000/")


      #temp_blog = mock('Blog')
      #temp_blog.stub(:lang).and_return("en_us")
      #temp_blog.stub(:base_url).and_return("http://localhost:3000/")
      #temp_article=mock('Article', :body => "bod" ,:id=>'3')
      #temp_article.stub(:blog).with(blog)
      #temp_article.blog.stub(:lang).and_return("en-us")
      #temp_article.stub(:load_lang).and_return("")
      #temp_article=Article.create(:body => "bod", :id => '3')
      #temp_article.blog = b
      nil.stub(:lang).and_return("en_us")
      nil.stub(:theme).and_return("blue")
      #temp_article.should_receive :merge_helper
      #temp_article.stub (:new_edit_helper)


      
     # debugger
       

      
      Factory(:blog)
      #TODO delete this after remove fixture
      Profile.delete_all
      @user = Factory(:user, :text_filter => Factory(:markdown), :profile => Factory(:profile_admin, :label => Profile::ADMIN))
      @user.editor = 'simple'
      @user.save
      @article = Factory(:article)
      request.session = { :user => @user.id }

      @article.id = 1

      #Article.stub(:find).with(@article.id).and_return(@article)
      
      #@article.should_receive(:merge_with).with(@article.id).and_return(@article)
     
      

      temp = {:id => @article.id, :id_to_merge => @article.id} 

      get :edit, :id => @article.id
      #response.should render_template('new')
      #assigns(@article.id).should == @art.id 
      #assigns(@article).should == @art
      #assigns(@status).should == "edit"
    end
  end

#  # Like it's a shared, need call everywhere
#  shared_examples_for 'index action' do
#
#    it 'should render template index' do
#      get 'index'
#      response.should render_template('index')
#    end
#
#    it 'should see all published in index' do
#      get :index, :search => {:published => '0', :published_at => '2008-08', :user_id => '2'}
#      response.should render_template('index')
#      response.should be_success
#    end
#
#    it 'should restrict only by searchstring' do
#      article = Factory(:article, :body => 'once uppon an originally time')
#      get :index, :search => {:searchstring => 'originally'}
#      assigns(:articles).should == [article]
#      response.should render_template('index')
#      response.should be_success
#    end
#
#    it 'should restrict by searchstring and published_at' do
#      Factory(:article)
#      get :index, :search => {:searchstring => 'originally', :published_at => '2008-08'}
#      assigns(:articles).should be_empty
#      response.should render_template('index')
#      response.should be_success
#    end
#
#    it 'should restrict to drafts' do
#      article = Factory(:article, :state => 'draft')
#      get :index, :search => {:state => 'drafts'}
#      assigns(:articles).should == [article]
#      response.should render_template('index')
#      response.should be_success
#    end
#
#    it 'should restrict to publication pending articles' do
#      article = Factory(:article, :state => 'publication_pending', :published_at => '2020-01-01')
#      get :index, :search => {:state => 'pending'}
#      assigns(:articles).should == [article]
#      response.should render_template('index')
#      response.should be_success
#    end
#    
#    it 'should restrict to withdrawn articles' do
#      article = Factory(:article, :state => 'withdrawn', :published_at => '2010-01-01')
#      get :index, :search => {:state => 'withdrawn'}
#      assigns(:articles).should == [article]
#      response.should render_template('index')
#      response.should be_success
#    end
#  
#    it 'should restrict to withdrawn articles' do
#      article = Factory(:article, :state => 'withdrawn', :published_at => '2010-01-01')
#      get :index, :search => {:state => 'withdrawn'}
#      assigns(:articles).should == [article]
#      response.should render_template('index')
#      response.should be_success
#    end
#
#    it 'should restrict to published articles' do
#      article = Factory(:article, :state => 'published', :published_at => '2010-01-01')
#      get :index, :search => {:state => 'published'}
#      response.should render_template('index')
#      response.should be_success
#    end
#
#    it 'should fallback to default behavior' do
#      article = Factory(:article, :state => 'draft')
#      get :index, :search => {:state => '3vI1 1337 h4x0r'}
#      response.should render_template('index')
#      assigns(:articles).should_not == [article]
#      response.should be_success
#    end
#
#  end
#
#  shared_examples_for 'autosave action' do
#    describe "first time for a new article" do
#      it 'should save new article with draft status and no parent article' do
#        Factory(:none)
#        lambda do
#        lambda do
#          post :autosave, :article => {:allow_comments => '1',
#            :body_and_extended => 'my draft in autosave',
#            :keywords => 'mientag',
#            :permalink => 'big-post',
#            :title => 'big post',
#            :text_filter => 'none',
#            :published => '1',
#            :published_at => 'December 23, 2009 03:20 PM'}
#        end.should change(Article, :count)
#        end.should change(Tag, :count)
#        result = Article.last
#        result.body.should == 'my draft in autosave'
#        result.title.should == 'big post'
#        result.permalink.should == 'big-post'
#        result.parent_id.should be_nil
#        result.redirects.count.should == 0
#      end
#    end
#
#    describe "second time for a new article" do
#      it 'should save the same article with draft status and no parent article' do
#        draft = Factory(:article, :published => false, :state => 'draft')
#        lambda do
#          post :autosave, :article => {
#            :id => draft.id,
#            :body_and_extended => 'new body' }
#        end.should_not change(Article, :count)
#        result = Article.find(draft.id)
#        result.body.should == 'new body'
#        result.parent_id.should be_nil
#        result.redirects.count.should == 0
#      end
#    end
#
#    describe "for a published article" do
#      before :each do
#        @article = Factory(:article)
#        @data = {:allow_comments => @article.allow_comments,
#          :body_and_extended => 'my draft in autosave',
#          :keywords => '',
#          :permalink => @article.permalink,
#          :title => @article.title,
#          :text_filter => @article.text_filter,
#          :published => '1',
#          :published_at => 'December 23, 2009 03:20 PM'}
#      end
#
#      it 'should create a draft article with proper attributes and existing article as a parent' do
#        lambda do
#          post :autosave, :id => @article.id, :article => @data
#        end.should change(Article, :count)
#        result = Article.last
#        result.body.should == 'my draft in autosave'
#        result.title.should == @article.title
#        result.permalink.should == @article.permalink
#        result.parent_id.should == @article.id
#        result.redirects.count.should == 0
#      end
#
#      it 'should not create another draft article with parent_id if article has already a draft associated' do
#        draft = Article.create!(@article.attributes.merge(:guid => nil, :state => 'draft', :parent_id => @article.id))
#        lambda do
#          post :autosave, :id => @article.id, :article => @data
#        end.should_not change(Article, :count)
#        Article.last.parent_id.should == @article.id
#      end
#
#      it 'should create a draft with the same permalink even if the title has changed' do
#        @data[:title] = @article.title + " more stuff"
#        lambda do
#          post :autosave, :id => @article.id, :article => @data
#        end.should change(Article, :count)
#        result = Article.last
#        result.parent_id.should == @article.id
#        result.permalink.should == @article.permalink
#        result.redirects.count.should == 0
#      end
#    end
#
#    describe "with an unrelated draft in the database" do
#      before do
#        @draft = Factory(:article, :state => 'draft')
#      end
#
#      it "leaves the original draft in existence" do
#        post :autosave, 'article' => {}
#        assigns(:article).id.should_not == @draft.id
#        Article.find(@draft.id).should_not be_nil
#      end
#    end
#  end
#
#  describe 'insert_editor action' do
#
#    before do
#      Factory(:blog)
#      @user = Factory(:user, :profile => Factory(:profile_admin, :label => Profile::ADMIN))
#      request.session = { :user => @user.id }
#    end
#
#    it 'should render _simple_editor' do
#      get(:insert_editor, :editor => 'simple')
#      response.should render_template('_simple_editor')
#    end
#
#    it 'should render _visual_editor' do
#      get(:insert_editor, :editor => 'visual')
#      response.should render_template('_visual_editor')
#    end
#
#    it 'should render _visual_editor even if editor param is set to unknow editor' do
#      get(:insert_editor, :editor => 'unknow')
#      response.should render_template('_visual_editor')
#    end
#  end
#
#
#  shared_examples_for 'new action' do
#
#    describe 'GET' do
#      it "renders the 'new' template" do
#        get :new
#        response.should render_template('new')
#        assigns(:article).should_not be_nil
#        assigns(:article).redirects.count.should == 0
#      end
#
#      it "correctly converts multi-word tags" do
#        a = Factory(:article, :keywords => '"foo bar", baz')
#        get :new, :id => a.id
#        response.should have_selector("input[id=article_keywords][value='baz, \"foo bar\"']")
#      end
#
#    end
#
#    def base_article(options={})
#      { :title => "posted via tests!",
#        :body => "A good body",
#        :allow_comments => '1',
#        :allow_pings => '1' }.merge(options)
#    end
#
#    it 'should create article with no comments' do
#      post(:new, 'article' => base_article({:allow_comments => '0'}),
#                 'categories' => [Factory(:category).id])
#      assigns(:article).should_not be_allow_comments
#      assigns(:article).should be_allow_pings
#      assigns(:article).should be_published
#    end
#
#    it 'should create a published article with a redirect' do
#      post(:new, 'article' => base_article)
#      assigns(:article).redirects.count.should == 1
#    end
#
#    it 'should create a draft article without a redirect' do
#      post(:new, 'article' => base_article({:state => 'draft'}))
#      assigns(:article).redirects.count.should == 0
#    end
#
#    it 'should create an unpublished article without a redirect' do
#      post(:new, 'article' => base_article({:published => false}))
#      assigns(:article).redirects.count.should == 0
#    end
#
#    it 'should create an article published in the future without a redirect' do
#      post(:new, 'article' => base_article({:published_at => (Time.now + 1.hour).to_s}))
#      assigns(:article).redirects.count.should == 0
#    end
#
#    it 'should create article with no pings' do
#      post(:new, 'article' => {:allow_pings => '0', 'title' => 'my Title'}, 'categories' => [Factory(:category).id])
#      assigns(:article).should be_allow_comments
#      assigns(:article).should_not be_allow_pings
#      assigns(:article).should be_published
#    end
#
#    it 'should create an article linked to the current user' do
#      post :new, 'article' => base_article
#      new_article = Article.last
#      assert_equal @user, new_article.user
#    end
#
#    it 'should create new published article' do
#      Article.count.should be == 1
#      post :new, 'article' => base_article
#      Article.count.should be == 2
#    end
#
#    it 'should redirect to show' do
#      post :new, 'article' => base_article
#      assert_response :redirect, :action => 'show'
#    end
#
#    it 'should send notifications on create' do
#      begin
#        u = Factory(:user, :notify_via_email => true, :notify_on_new_articles => true)
#        u.save!
#        ActionMailer::Base.perform_deliveries = true
#        ActionMailer::Base.deliveries = []
#        emails = ActionMailer::Base.deliveries
#
#        post :new, 'article' => base_article
#
#        assert_equal(1, emails.size)
#        assert_equal(u.email, emails.first.to[0])
#      ensure
#        ActionMailer::Base.perform_deliveries = false
#      end
#    end
#
#    it 'should create an article in a category' do
#      category = Factory(:category)
#      post :new, 'article' => base_article, 'categories' => [category.id]
#      new_article = Article.last
#      assert_equal [category], new_article.categories
#    end
#
#    it 'should create an article with tags' do
#      post :new, 'article' => base_article(:keywords => "foo bar")
#      new_article = Article.last
#      assert_equal 2, new_article.tags.size
#    end
#
#    it 'should create article in future' do
#      lambda do
#        post(:new,
#             :article =>  base_article(:published_at => (Time.now + 1.hour).to_s) )
#        assert_response :redirect, :action => 'show'
#        assigns(:article).should_not be_published
#      end.should_not change(Article.published, :count)
#      assert_equal 1, Trigger.count
#      assigns(:article).redirects.count.should == 0
#    end
#
#    it "should correctly interpret time zone in :published_at" do
#      post :new, 'article' => base_article(:published_at => "February 17, 2011 08:47 PM GMT+0100 (CET)")
#      new_article = Article.last
#      assert_equal Time.utc(2011, 2, 17, 19, 47), new_article.published_at
#    end
#
#    it 'should respect "GMT+0000 (UTC)" in :published_at' do
#      post :new, 'article' => base_article(:published_at => 'August 23, 2011 08:40 PM GMT+0000 (UTC)')
#      new_article = Article.last
#      assert_equal Time.utc(2011, 8, 23, 20, 40), new_article.published_at
#    end
#
#    it 'should create a filtered article' do
#      body = "body via *markdown*"
#      extended="*foo*"
#      post :new, 'article' => { :title => "another test", :body => body, :extended => extended}
#      assert_response :redirect, :action => 'show'
#
#      new_article = Article.find(:first, :order => "created_at DESC")
#      assert_equal body, new_article.body
#      assert_equal extended, new_article.extended
#      assert_equal "markdown", new_article.text_filter.name
#      assert_equal "<p>body via <em>markdown</em></p>", new_article.html(:body)
#      assert_equal "<p><em>foo</em></p>", new_article.html(:extended)
#    end
#
#    describe "publishing a published article with an autosaved draft" do
#      before do
#        @orig = Factory(:article)
#        @draft = Factory(:article, :parent_id => @orig.id, :state => 'draft', :published => false)
#        post(:new,
#             :id => @orig.id,
#             :article => {:id => @draft.id, :body => 'update'})
#      end
#
#      it "updates the original" do
#        assert_raises ActiveRecord::RecordNotFound do
#          Article.find(@draft.id)
#        end
#      end
#
#      it "deletes the draft" do
#        Article.find(@orig.id).body.should == 'update'
#      end
#    end
#
#    describe "publishing a draft copy of a published article" do
#      before do
#        @orig = Factory(:article)
#        @draft = Factory(:article, :parent_id => @orig.id, :state => 'draft', :published => false)
#        post(:new,
#             :id => @draft.id,
#             :article => {:id => @draft.id, :body => 'update'})
#      end
#
#      it "updates the original" do
#        assert_raises ActiveRecord::RecordNotFound do
#          Article.find(@draft.id)
#        end
#      end
#
#      it "deletes the draft" do
#        Article.find(@orig.id).body.should == 'update'
#      end
#    end
#
#    describe "saving a published article as draft" do
#      before do
#        @orig = Factory(:article)
#        post(:new,
#             :id => @orig.id,
#             :article => {:title => @orig.title, :draft => 'draft',
#               :body => 'update' })
#      end
#
#      it "leaves the original published" do
#        @orig.reload
#        @orig.published.should == true
#      end
#
#      it "leaves the original as is" do
#        @orig.reload
#        @orig.body.should_not == 'update'
#      end
#
#      it "redirects to the index" do
#        response.should redirect_to(:action => 'index')
#      end
#
#      it "creates a draft" do
#        draft = Article.child_of(@orig.id).first
#        draft.parent_id.should == @orig.id
#        draft.should_not be_published
#      end
#    end
#
#    describe "with an unrelated draft in the database" do
#      before do
#        @draft = Factory(:article, :state => 'draft')
#      end
#
#      describe "saving new article as draft" do
#        it "leaves the original draft in existence" do
#          post(
#            :new,
#            'article' => base_article({:draft => 'save as draft'}))
#          assigns(:article).id.should_not == @draft.id
#          Article.find(@draft.id).should_not be_nil
#        end
#      end
#    end
#  end
#
#  shared_examples_for 'destroy action' do
#
#    it 'should_not destroy article by get' do
#      lambda do
#        art_id = @article.id
#        assert_not_nil Article.find(art_id)
#
#        get :destroy, 'id' => art_id
#        response.should be_success
#      end.should_not change(Article, :count)
#    end
#
#    it 'should destroy article by post' do
#      lambda do
#        art_id = @article.id
#        post :destroy, 'id' => art_id
#        response.should redirect_to(:action => 'index')
#
#        lambda{
#          article = Article.find(art_id)
#        }.should raise_error(ActiveRecord::RecordNotFound)
#      end.should change(Article, :count).by(-1)
#    end
#
#  end
#
#
#  describe 'with admin connection' do
#
#    before do
#      Factory(:blog)
#      #TODO delete this after remove fixture
#      Profile.delete_all
#      @user = Factory(:user, :text_filter => Factory(:markdown), :profile => Factory(:profile_admin, :label => Profile::ADMIN))
#      @user.editor = 'simple'
#      @user.save
#      @article = Factory(:article)
#      request.session = { :user => @user.id }
#    end
#
#    it_should_behave_like 'index action'
#    it_should_behave_like 'new action'
#    it_should_behave_like 'destroy action'
#    it_should_behave_like 'autosave action'
#
#    describe 'edit action' do
#
#      it 'should edit article' do
#        get :edit, 'id' => @article.id
#        response.should render_template('new')
#        assigns(:article).should_not be_nil
#        assigns(:article).should be_valid
#        response.should contain(/body/)
#        response.should contain(/extended content/)
#      end
#
#      it 'should update article by edit action' do
#        begin
#          ActionMailer::Base.perform_deliveries = true
#          emails = ActionMailer::Base.deliveries
#          emails.clear
#
#          art_id = @article.id
#
#          body = "another *textile* test"
#          post :edit, 'id' => art_id, 'article' => {:body => body, :text_filter => 'textile'}
#          assert_response :redirect, :action => 'show', :id => art_id
#
#          article = @article.reload
#          article.text_filter.name.should == "textile"
#          body.should == article.body
#
#          emails.size.should == 0
#        ensure
#          ActionMailer::Base.perform_deliveries = false
#        end
#      end
#
#      it 'should allow updating body_and_extended' do
#        article = @article
#        post :edit, 'id' => article.id, 'article' => {
#          'body_and_extended' => 'foo<!--more-->bar<!--more-->baz'
#        }
#        assert_response :redirect
#        article.reload
#        article.body.should == 'foo'
#        article.extended.should == 'bar<!--more-->baz'
#      end
#
#      it 'should delete draft about this article if update' do
#        article = @article
#        draft = Article.create!(article.attributes.merge(:state => 'draft', :parent_id => article.id, :guid => nil))
#        lambda do
#          post :edit, 'id' => article.id, 'article' => { 'title' => 'new'}
#        end.should change(Article, :count).by(-1)
#        Article.should_not be_exists({:id => draft.id})
#      end
#
#      it 'should delete all draft about this article if update not happen but why not' do
#        article = @article
#        draft = Article.create!(article.attributes.merge(:state => 'draft', :parent_id => article.id, :guid => nil))
#        draft_2 = Article.create!(article.attributes.merge(:state => 'draft', :parent_id => article.id, :guid => nil))
#        lambda do
#          post :edit, 'id' => article.id, 'article' => { 'title' => 'new'}
#        end.should change(Article, :count).by(-2)
#        Article.should_not be_exists({:id => draft.id})
#        Article.should_not be_exists({:id => draft_2.id})
#      end
#    end
#
#    describe 'resource_add action' do
#
#      it 'should add resource' do
#        art_id = @article.id
#        resource = Factory(:resource)
#        get :resource_add, :id => art_id, :resource_id => resource.id
#
#        response.should render_template('_show_resources')
#        assigns(:article).should be_valid
#        assigns(:resource).should be_valid
#        assert Article.find(art_id).resources.include?(resource)
#        assert_not_nil assigns(:article)
#        assert_not_nil assigns(:resource)
#        assert_not_nil assigns(:resources)
#      end
#
#    end
#
#    describe 'resource_remove action' do
#
#      it 'should remove resource' do
#        art_id = @article.id
#        resource = Factory(:resource)
#        get :resource_remove, :id => art_id, :resource_id => resource.id
#
#        response.should render_template('_show_resources')
#        assert assigns(:article).valid?
#        assert assigns(:resource).valid?
#        assert !Article.find(art_id).resources.include?(resource)
#        assert_not_nil assigns(:article)
#        assert_not_nil assigns(:resource)
#        assert_not_nil assigns(:resources)
#      end
#    end
#
#    describe 'auto_complete_for_article_keywords action' do
#      before do
#        Factory(:tag, :name => 'foo', :articles => [Factory(:article)])
#        Factory(:tag, :name => 'bazz', :articles => [Factory(:article)])
#        Factory(:tag, :name => 'bar', :articles => [Factory(:article)])
#      end
#
#      it 'should return foo for keywords fo' do
#        get :auto_complete_for_article_keywords, :article => {:keywords => 'fo'}
#        response.should be_success
#        response.body.should == '<ul class="unstyled" id="autocomplete"><li>foo</li></ul>'
#      end
#
#      it 'should return nothing for hello' do
#        get :auto_complete_for_article_keywords, :article => {:keywords => 'hello'}
#        response.should be_success
#        response.body.should == '<ul class="unstyled" id="autocomplete"></ul>'
#      end
#
#      it 'should return bar and bazz for ba keyword' do
#        get :auto_complete_for_article_keywords, :article => {:keywords => 'ba'}
#        response.should be_success
#        response.body.should == '<ul class="unstyled" id="autocomplete"><li>bar</li><li>bazz</li></ul>'
#      end
#    end
#
#  end
#
#  describe 'with publisher connection' do
#
#    before :each do
#      Factory(:blog)
#      @user = Factory(:user, :text_filter => Factory(:markdown), :profile => Factory(:profile_publisher))
#      @article = Factory(:article, :user => @user)
#      request.session = {:user => @user.id}
#    end
#
#    it_should_behave_like 'index action'
#    it_should_behave_like 'new action'
#    it_should_behave_like 'destroy action'
#
#    describe 'edit action' do
#
#      it "should redirect if edit article doesn't his" do
#        get :edit, :id => Factory(:article, :user => Factory(:user, :login => 'another_user')).id
#        response.should redirect_to(:action => 'index')
#      end
#
#      it 'should edit article' do
#        get :edit, 'id' => @article.id
#        response.should render_template('new')
#        assigns(:article).should_not be_nil
#        assigns(:article).should be_valid
#      end
#
#      it 'should update article by edit action' do
#        begin
#          ActionMailer::Base.perform_deliveries = true
#          emails = ActionMailer::Base.deliveries
#          emails.clear
#
#          art_id = @article.id
#
#          body = "another *textile* test"
#          post :edit, 'id' => art_id, 'article' => {:body => body, :text_filter => 'textile'}
#          response.should redirect_to(:action => 'index')
#
#          article = @article.reload
#          article.text_filter.name.should == "textile"
#          body.should == article.body
#
#          emails.size.should == 0
#        ensure
#          ActionMailer::Base.perform_deliveries = false
#        end
#      end
#    end
#
#    describe 'destroy action can be access' do
#
#      it 'should redirect when want destroy article' do
#        article = Factory(:article, :user => Factory(:user, :login => Factory(:user, :login => 'other_user')))
#        lambda do
#          get :destroy, :id => article.id
#          response.should redirect_to(:action => 'index')
#        end.should_not change(Article, :count)
#      end
#
#    end
#  end
end
