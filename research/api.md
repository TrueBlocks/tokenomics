- https://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm
- http://roy.gbiv.com/untangled/2008/rest-apis-must-be-hypertext-driven
- https://martinfowler.com/articles/richardsonMaturityModel.html
- http://blog.steveklabnik.com/posts/2012-02-27-hypermedia-api-reading-list
- http://morepath.readthedocs.io/en/latest/rest.html
- https://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api
- https://medium.com/studioarmix/learn-restful-api-design-ideals-c5ec915a430f

## books
- http://restfulwebapis.org/
- https://www.amazon.com/Building-Hypermedia-APIs-HTML5-Node/dp/1449306578
- http://www.designinghypermediaapis.com/

## videos
- [Hypermedia APIs - John Moore](https://vimeo.com/20781278) -- talks about Hypermedia as the engine of application state (HATEOAS) and why many APIs aren't adhering to Uniform interface constraint of Fielding's dissertation. Particularly, independent evolution and decoupled implementation. He then goes into his api with XHTML media type. This video is from 2010 and I noticed some things that seem outdated. Other resources may be better.
- [Everything You Know About REST IS Wrong - Steve Klabnik](https://vimeo.com/30764565) - author of Restful Web APIs. Resources, Representations (presentation of resource e.g. json / xml), Hypermedia (interconnectedness between representation of resources). How RESTful is your REST api? Do we need REST, or just json rpc? Info on HATEOAS. Real REST is about hypermedia and browsing APIs like we browse the web (with connections). Ultimately, decides to call true REST APIs "Hypermedia APIs," while letting RESTish APIs remain "RESTful".


## related
- [cors on nginx](https://enable-cors.org/server_nginx.html)



- Reverse proxy steps at bottom: https://www.digitalocean.com/community/tutorials/how-to-set-up-a-node-js-application-for-production-on-ubuntu-16-04
- Postman & route defs: https://scotch.io/tutorials/build-a-restful-api-using-node-and-express-4
- Load testing with siege: https://www.codementor.io/codeforgeek/node-js-mysql-8b5nh45r9
- Persist program with `systemd`: https://blog.codeship.com/running-node-js-linux-systemd/
  - alternatives: https://stackoverflow.com/questions/4018154/how-do-i-run-a-node-js-app-as-a-background-service
- Logging with morgan and winston: [here](http://tostring.it/2014/06/23/advanced-logging-with-nodejs/) and [stackoverflow](https://stackoverflow.com/questions/27906551/node-js-logging-use-morgan-and-winston)

Partially helpful node-express-mysql articles:
- https://jinalshahblog.wordpress.com/2016/10/06/rest-api-using-node-js-and-mysql/
- https://www.terlici.com/2015/08/13/mysql-node-express.html

[mysqljs repo](https://github.com/mysqljs/mysql)
[express api documentation](http://expressjs.com/en/api.html)
