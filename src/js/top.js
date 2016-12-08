import GATracker from './common/GATracker';

/**
 * トップページクラスです。
 */
class Main {

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
  new Main();
});
