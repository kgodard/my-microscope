@Posts = new Mongo.Collection('posts')

Meteor.methods
  postInsert: (postAttributes) =>
    check Meteor.userId(), String
    check postAttributes,
      title: String
      url: String

    postWithSameLink = Posts.findOne { url: postAttributes.url }

    if postWithSameLink
      postExists: true
      _id: postWithSameLink._id
    else
      user = Meteor.user()
      post = _.extend postAttributes,
        userId: user._id
        author: user.username
        submitted: new Date()

      postId = Posts.insert(post)

      { _id: postId }
