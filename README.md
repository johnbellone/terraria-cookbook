# Terraria Cookbook
[![Build Status](https://img.shields.io/travis/johnbellone/terraria-cookbook.svg)](https://travis-ci.org/johnbellone/terraria-cookbook)
[![Code Quality](https://img.shields.io/codeclimate/github/johnbellone/terraria-cookbook.svg)](https://codeclimate.com/github/johnbellone/terraria-cookbook)
[![Cookbook Version](https://img.shields.io/cookbook/v/terraria.svg)](https://supermarket.chef.io/cookbooks/terraria)
[![License](https://img.shields.io/badge/license-Apache_2-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)

[Application cookbook][0] which installs and configures a [Terraria server][1].

## Basic Usage
The easiest way to use this cookbook is to simply add this to a run
list of a node. It will install and enable the
[TShock Terraria server][2]. It has been tested on the latest stable
versions of Ubuntu and CentOS.

## Advanced Usage
If you are looking to make a more advanced deployment, take a look at
the included [Policyfile](Policyfile.rb) which adds in some hardening
cookbooks if this node is meant to be deployed to cloud
infrastructure. It would likely help to take a look at the
[contributing guidelines](CONTRIBUTING.md) which illustrate how you
should hack on this cookbook.

[0]: http://blog.vialstudios.com/the-environment-cookbook-pattern#theapplicationcookbook
[1]: https://github.com/NyxStudios/TShock
[2]: https://tshock.co/xf/index.php
