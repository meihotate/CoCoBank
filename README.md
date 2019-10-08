# Name

CoCoBank

CoCoBank is a chat application for Children who have been worried about human relationships.
They can create friendships each other and chat in this app.
They also can chat with counselors.

# DEMO

<img width="1440" alt="CoCoBank_top" src="https://user-images.githubusercontent.com/51254127/66360960-eadab700-e9b7-11e9-99a5-1f0dca29a8f8.png">
<img width="1435" alt="CoCoBank_mypage2" src="https://user-images.githubusercontent.com/51254127/66361286-39d51c00-e9b9-11e9-8022-b1a90940c1e8.png">

# Features

This app have
* login, logout, editing user profile information
* withdrawal from a group
* Real time chat (using Action Cable)
* Real time login notification (using Action Cable)
* Personality diagnosis (using Watson Personality Insights)
* Registration approval by the admin and approval notification to a counselor by action mailer.

# Requirement

* ruby '2.5.5'
* rails '5.2.3'
* mysql2
* nginX
* puma

# Gem

* devise
* bootstrap-sass -v 3.3.6
* jquery-rails
* refile, refile-mini_magick
* enum_help
* rails-i18n
* chart-js-rails
* gon
* paranoia

# AWS

* EC2
* RDS
* EIP
* Route53