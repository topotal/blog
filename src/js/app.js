import Nav from './Nav';

/**
 * メインクラス
 */
class Main {

  /**
   * コンストラクター
   * @constructor
   */
  constructor() {

    this._isTop = true;

    // ナビゲーション
    this._nav = new Nav();

    // スクロールを監視
    this._onScroll = this._onScroll.bind(this);
    window.addEventListener('scroll', this._onScroll);

    // 更新
    this._tick = this._tick.bind(this);
    this._tick();
  }

  /**
   * スクロール時のハンドラーです。
   */
  _onScroll() {
    if(window.pageYOffset <= 0) {
      this._isTop = true;
    } else {
      this._isTop = false;
    }
  }

  /**
   * フレーム毎に更新します。
   */
  _tick() {
    requestAnimationFrame(this._tick);

    // if(this._isTop) {
    //   this._nav.hide();
    // }
    // else {
    //   this._nav.show();
    // }
  }

}

window.onload = () => {
  new Main();
};
