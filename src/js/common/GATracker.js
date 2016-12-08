import ua from 'universal-analytics';

/**
 * GoogleAnalyticsのトラッカークラスです。
 */
export default class GATracker {

  /**
   * コンストラクター
   * @constructor
   */
  constructor() {
    this._visitor = ua('UA-88593825-1');
  }

  /**
   * トップページのトラッキングをします。
   */
  sendPage() {
    let path = window.location.pathname;
    let host = window.location.hostname;
    let title = document.title;
    this._visitor.pageview(
      path,
      host,
      title
    ).send();
  }
}
