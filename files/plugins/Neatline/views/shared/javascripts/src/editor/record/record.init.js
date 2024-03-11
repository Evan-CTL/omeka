
/**
 * @package     omeka
 * @subpackage  neatline
 * @copyright   2014 Rector and Board of Visitors, University of Virginia
 * @license     https://www.apache.org/licenses/LICENSE-2.0.html
 */

Neatline.module('Editor.Record', function(Record) {


  Record.addInitializer(function() {
    Record.__controller = new Record.Controller();
  });


});
