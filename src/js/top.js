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
    this._tracker = new GATracker();
    this._tracker.sendPage();
  }
}

window.addEventListener('load', () => {
  new Main();
});
