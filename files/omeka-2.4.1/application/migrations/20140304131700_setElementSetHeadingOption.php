<?php
/**
 * Omeka
 * 
 * @copyright Copyright 2007-2012 Roy Rosenzweig Center for History and New Media
 * @license https://www.gnu.org/licenses/gpl-3.0.txt GNU GPLv3
 */

/**
 * @package Omeka\Db\Migration
 */
class setElementSetHeadingOption extends Omeka_Db_Migration_AbstractMigration
{
    public function up()
    {
        set_option('show_element_set_headings', '1');
    }
}
