FactoryGirl.define do
  factory :user do
    # name     "Michael Hartl"
    # email    "michael@example.com"
    # password "foobar"
    # password_confirmation "foobar"
    
    # ブロック変数nはインクリメントされる
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"


    # 一部だけ上書きした:adminを定義
    factory :admin do
      admin true
    end
  end
end
