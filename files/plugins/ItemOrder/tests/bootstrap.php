<?php
/**
 * ItemOrder bootstrap
 *
 * @copyright Copyright 2007-2012 Roy Rosenzweig Center for History and New Media
 * @license https://www.gnu.org/licenses/gpl-3.0.txt GNU GPLv3
 * @package ItemOrder
 */

define('ITEMORDER_BASE', realpath(dirname(__FILE__) . '/../')); 
set_include_path(get_include_path() . PATH_SEPARATOR . ITEMORDER_BASE);

require_once dirname(dirname(dirname(dirname(__FILE__)))) . '/application/tests/bootstrap.php';
require_once 'ItemOrder_Test_AppTestCase.php';
