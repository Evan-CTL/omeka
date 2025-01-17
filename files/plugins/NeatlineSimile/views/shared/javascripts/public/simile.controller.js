
/**
 * @package     omeka
 * @subpackage  neatline-Simile
 * @copyright   2012 Rector and Board of Visitors, University of Virginia
 * @license     https://www.apache.org/licenses/LICENSE-2.0.html
 */

Neatline.module('Simile', {
  define: function(Simile) {


    Simile.Controller = Neatline.Shared.Controller.extend({


      slug: 'SIMILE',

      events:[
        { 'refresh': 'load' },
        { 'MAP:ingest': 'ingest' },
        'select'
      ],

      commands: [
        'restart'
      ],


      /**
       * Create the view and load starting events.
       */
      init: function() {
        this.view = new Simile.View({ slug: this.slug });
        this.load();
      },


      /**
       * Load timeline events.
       */
      load: function() {
        this.view.load();
      },


      /**
       * Focus by model, unless the event was triggered by the timeline.
       *
       * @param {Object} args: Event arguments.
       */
      select: function(args) {
        if (args.source !== this.slug) this.view.focusByModel(args.model);
      },


      /**
       * Restart the timeline and re-render the current collection.
       *
       * @param {Object} exhibit: The exhibit model.
       */
      restart: function(exhibit) {
        this.view.start(exhibit);
        this.view.ingest(this.view.records);
      },


      /**
       * Apply the time filter when a batch of records is loaded.
       *
       * @param {Array} records: The records being loaded.
       */
      ingest: function(records) {
        this.view.ingest(this.view.records);
      }


    });


  }
});
