
/**
 * @package     omeka
 * @subpackage  neatline-Simile
 * @copyright   2012 Rector and Board of Visitors, University of Virginia
 * @license     https://www.apache.org/licenses/LICENSE-2.0.html
 */

Neatline.module('Simile', {
  define: function(Simile) {


    /**
     * Since SIMILE publishes a record filter immediately on start-up, wait
     * until the rest of the modules are running before starting SIMILE.
     */
    Neatline.on('initialize:after', function() {
      Simile.start();
    });


    /**
     * Start the controller, suppress the request to `__history__.html`.
     */
    Simile.addInitializer(function() {
      SimileAjax.History.enabled = false;
      Simile.__controller = new Simile.Controller();
    });


  }
});
