Webapp Cookbook
===============
This cookbook is a set of best practices for deploying web applications. Currently this is mainly focused around Ruby on Rails, but with limited support in the works for Node. We assume that code will be deployed and managed with Capistrano.

Part of the Amoeba Deploy Tools, this cookbook is used to rapidly build out a Ruby on Rails deployment in minutes. See Amoeba Deploy Tools for more information: http://github.com/AmoebaConsulting/amoeba-deploy-tools


Requirements
------------
Currently this is tested and works on Ubuntu 12.04 Server.

You must add the following to your Cookbooks manager. For Librarian Chef you can add the following
to your `Cheffile`:

```
cookbook 'rvm',     github: 'fnichol/chef-rvm'
cookbook 'monit',   github: 'phlipper/chef-monit'
cookbook 'nginx',   github: ''
```


Attributes
----------
TODO: List you cookbook attributes here.

e.g.
#### webapp::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['webapp']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### webapp::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `webapp` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[webapp]"
  ]
}
```

Contributing
------------
We welcome contributions to the repo. Please follow a Github friendly process:

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors:
 * Daniel Jabbour [Amoeba Labs](http://amoe.ba)