<?php

/* vim: set expandtab tabstop=2 shiftwidth=2 softtabstop=2 cc=80; */

/**
 * @package     omeka
 * @subpackage  neatline-Waypoints
 * @copyright   2012 Rector and Board of Visitors, University of Virginia
 * @license     https://www.apache.org/licenses/LICENSE-2.0.html
 */

?>

<script id="waypoints-public-list-template" type="text/templates">
  <ul>
    <% records.each(function(r) { %>
      <a class="title" data-id="<%= r.id %>">
        <%= r.get('title') %>
      </a>
    <% }); %>
  </ul>
</script>
