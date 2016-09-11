/**
 * ナビゲーションクラスです。
 */
export default class Nav {

  /**
   * コンストラクター
   * @constructor
   */
  constructor() {
    // エレメント
    this._el = document.getElementById('nav');
  }

  /**
   * 隠します。
   */
  hide() {
    this._el.style.display = 'none';
  }

  /**
   * 隠します。
   */
  show() {
    this._el.style.display = 'block';
  }
}
