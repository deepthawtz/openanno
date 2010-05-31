
                                       _____   _______   _______  _______
        ____ ______    ____    ____   /  _  \  \      \  \      \ |      \
       /  _ \\____ \ _/ __ \  /    \ /  /_\  \ /   |   \ /   |   \   []   \
      (  <_> )  |_> >\  ___/ |   |  |    |    |    |    |    |    |        \
       \____/|   __/  \___  >|___|  |____|__  |____|__  |____|__  |________/
             |__|         \/      \/        \/        \/        \/



Twitter Hackfest Project
========================
Built in 24-hours at the Twitter Hackfest 2010

How It Works
------------

Sign up for an API key and:

    curl -i -X POST -d '[{"example_type":{"awesome_factor":"10"}}]' \
          http://openanno.com/api/some_object?api_key=your_api_key

Congratulations! You have just posted an annotation.

Now this should be no problem:

    curl http://openanno.com/api/some_object

As you can see we are annotating the object with an array of a hash of hashes.
We use exactly the same data model that Twitter annotations use.

Facebook Tunnel
---------------
While logged into Facebook, point your browser to [http://graph.facebook.com/me](http://graph.facebook.com/me).
Take note of the "id" field in the returned JSON.

    # GET
    curl http://openanno.com/fb/{your_id}

    # and POST
    curl -i -X POST -d '[{"example_type":{"awesome_factor":"10"}}]' http://openanno.com/api/fb_{your_id}

This posts an annotation to your Facebook profile. Note the fb_ prefix in the id.
This is our convention to identify facebook ids.

Now: `curl http://openanno.com/fb/{your_id}` will contain the annotations you added.


Authors
-------

* [Carlos Cardona](http://twitter.com/cgcardona)
* [Dylan Clendenin](http://twitter.com/deepthawtz)
* [Jonas Huckestein](http://twitter.com/deepthawtz)
* [Zak Kaplan](http://twitter.com/zakkap)
* [Michael Owens](http://twitter.com/michaelowens)

