import GATracker from './common/GATracker';

/**
 * トップページクラスです。
 */
class Entry {

  /**
   * コンストラクター
   * @constructor
   */
  constructor() {
    this._tracker = new GATracker();
    this._tracker.sendPage();
  }
}

window.addEventListener('load', () => {
  new Entry();
});

