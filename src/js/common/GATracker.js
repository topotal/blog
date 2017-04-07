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
    this._visitor = ua('UA-97002788-1', {https: true});
  }

  /**
   * トップページのトラッキングをします。
   */
  sendPageView() {
    let path = document.location.pathname;
    let host = document.location.toString();
    let title = document.title;

    this._visitor.pageview(path, host, title).send();
  }
}
