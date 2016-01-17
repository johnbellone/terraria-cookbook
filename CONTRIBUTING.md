# Contributing

## Hacking
If you are looking to make and test some changes to this cookbook it
is best if you first install the [Chef Development Kit][0]. After that
you should install the latest compatible version of [Vagrant][1] and
[VirtualBox][2]. At this point you should be ready to hack on the
cookbook!

Using test-kitchen is simple and straight-forward. The included
[Policyfile](Policyfile.rb) and [Kitchen configuration](.kitchen.yml) are
configured to allow for local testing using [VirtualBox][2].

To create an instance of the server you simply need to converge using
`kitchen converge ubuntu-1404`. After a few moments you'll have a
working Terraria server built with the cookbook. To actually run the
tests you should run `kitchen test ubuntu-1404` (and so on, for the
rest of the platforms).

[0]: https://chef.io
[1]: http://vagrantup.com
[2]: http://virtualbox.org
