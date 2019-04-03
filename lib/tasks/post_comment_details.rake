namespace :post_comment_details do
  desc "TODO"
  task seed_data: :environment do
    posts = [{title: 'The Usual Suspects', description: 'A sole survivor tells of the twisty events leading up to a horrific gun battle on a boat, which began when five criminals met at a seemingly random police lineup.'},
      {title: 'Oldboy', description: 'After being kidnapped and imprisoned for fifteen years, Oh Dae-Su is released, only to find that he must find his captor in five days.'},
      {title: 'The Machinist', description: "An industrial worker who hasn't slept in a year begins to doubt his own sanity."},
      {title: 'Donnie Darko', description: 'A troubled teenager is plagued by visions of a man in a large rabbit suit who manipulates him to commit a series of crimes, after he narrowly escapes a bizarre accident.'},
      {title: 'Chinatown', description: 'A private detective hired to expose an adulterer finds himself caught up in a web of deceit, corruption, and murder.'},
      {title: 'Adaptation.', description: 'A lovelorn screenwriter becomes desperate as he tries and fails to adapt The Orchid Thief by Susan Orlean for the screen.'},
      {title: 'Fight Club', description: 'An insomniac office worker and a devil-may-care soapmaker form an underground fight club that evolves into something much, much more.' },
      {title: 'Seven Pounds' , description: 'A man with a fateful secret embarks on an extraordinary journey of redemption by forever changing the lives of seven strangers.'},
      {title: 'Star Wars: Episode V - The Empire Strikes Back', description: 'After the rebels are brutally overpowered by the Empire on the ice planet Hoth, Luke Skywalker begins Jedi training with Yoda, while his friends are pursued by Darth Vader.'},
    ]


    users = [{email: 'sansat1387@gmail.com', password: 'test123'}, {email: 'satkar@gmail.com', password: 'test123'}, {email: 'abhi@gmail.com', password: 'test123'}, {email: 'john@gmail.com', password: 'test123'}]

    comments = [{message: "A series of thirteen webisodes known as Vikings: Athelstan's Journal was released by the History Channel. Each webisode serves as a journal entry for the Vikings character Athelstan"},
      {message: 'Star Wars: Episode V - The Empire Strikes Back'}]

    puts "==================================Creating Users========================================="
    users = User.create(users)

    puts "==================================Creating Posts========================================="
    posts = Post.create(posts)

    puts "==================================Adding Comments========================================="
    posts.each do |post|

      comments.each do |comment|
        com = post.comments.create(comment.merge({user: users[rand(2)]}))
      end
    end

    puts "================================Data seeding is complete======================================="

  end

end
