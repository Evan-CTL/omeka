
/**
 * @package     omeka
 * @subpackage  neatline
 * @copyright   2014 Rector and Board of Visitors, University of Virginia
 * @license     https://www.apache.org/licenses/LICENSE-2.0.html
 */

Neatline.module('Map.Layers.Stamen', function(Stamen) {


  Stamen.addInitializer(function() {
    Stamen.__controller = new Stamen.Controller();
  });


});
