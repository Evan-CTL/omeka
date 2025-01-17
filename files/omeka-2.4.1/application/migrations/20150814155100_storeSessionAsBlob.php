<?php
/**
 * Omeka
 *
 * @copyright Copyright 2007-2015 Roy Rosenzweig Center for History and New Media
 * @license https://www.gnu.org/licenses/gpl-3.0.txt GNU GPLv3
 */

/**
 * @package Omeka\Db\Migration
 */
class storeSessionAsBlob extends Omeka_Db_Migration_AbstractMigration
{
    public function up()
    {
        $sql = <<<SQL
ALTER TABLE `{$this->db->Session}`
MODIFY `data` BLOB
SQL;
        $this->db->query($sql);
    }
}
