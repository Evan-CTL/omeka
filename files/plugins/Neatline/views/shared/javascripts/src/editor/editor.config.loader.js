
/**
 * @package     omeka
 * @subpackage  neatline
 * @copyright   2014 Rector and Board of Visitors, University of Virginia
 * @license     https://www.apache.org/licenses/LICENSE-2.0.html
 */


/**
 * Show load spinner during ajax requests.
 */
$(function() {

  var loader = $('#loader');

  $(document).
    ajaxStart(function() {
      loader.show();
    }).
    ajaxStop(function() {
      loader.hide();
    })
  ;

});
