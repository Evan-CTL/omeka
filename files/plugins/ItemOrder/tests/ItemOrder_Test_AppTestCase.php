<?php
/**
 * ItemOrder_Test_AppTestCase - represents the base class for ItemOrder tests.
 *
 * @copyright Copyright 2007-2013 Roy Rosenzweig Center for History and New Media
 * @license https://www.gnu.org/licenses/gpl-3.0.txt GNU GPLv3
 * @package ItemOrder
 */
class ItemOrder_Test_AppTestCase extends Omeka_Test_AppTestCase
{
    const PLUGIN_NAME = 'ItemOrder';
    
    public function setUp()
    {
        parent::setUp();
        
        // Authenticate and set the current user 
        $this->user = $this->db->getTable('User')->find(1);
        $this->_authenticateUser($this->user);
        
        $pluginHelper = new Omeka_Test_Helper_Plugin;
        $pluginHelper->setUp(self::PLUGIN_NAME);
        Omeka_Test_Resource_Db::$runInstaller = true;
    }
    
    public function assertPreConditions()
    {
        $itemOrders = $this->db->getTable('ItemOrder_ItemOrder')->findAll();
        $this->assertEquals(0, count($itemOrders), 'There should be no item orders.');
    }
    
    protected function _deleteAllImports()
    {
        $itemOrders = $this->db->getTable('ItemOrder_ItemOrder')->findAll();
        foreach($itemOrders as $itemOrder) {
            $itemOrder->delete();
        }
        $itemOrders = $this->db->getTable('ItemOrder_ItemOrder')->findAll();
        $this->assertEquals(0, count($itemOrders), 'There should be no item orders.');
    }
}