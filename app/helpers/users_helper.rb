module UsersHelper
  def render_users_home
    @client = client_new
    @user = current_user
    @user_tw_account = @client.user(current_user.twid.to_i)
    @user.refresh_wordcaches(@client)
    @user.words_reset(@client)
    @words = @user.words.all
    @tweets = @client.home_timeline(count: 20)
    render 'users/home'
  end

  def get_twpic_uri(useracc)
    useracc.profile_image_url.to_s.sub(/http/, "https").sub(/(.*)_normal/){$1}
  end

  private
  #時間切れクエストを削除、更新
    def quest_reset
      #履歴削除
      @quests.each do |quest|
        if quest.created_at.tomorrow < Time.zone.now
          quest.destroy
        end
      end

      #新規生成
      (4 - @quests.count).downto(0) do |n|
        Quest.generate_new(current_user, @client)
        #@quests更新
        @quests = @user.quests.all if n==0
      end
    end


end
