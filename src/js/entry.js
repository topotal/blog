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
    // ページのトラッキング
    this._tracker = new GATracker();
    this._tracker.sendPageView();
  }
}

window.addEventListener('load', () => {
  new Entry();
});
