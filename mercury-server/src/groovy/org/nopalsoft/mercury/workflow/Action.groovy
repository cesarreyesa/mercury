package org.nopalsoft.mercury.workflow

/**
 * User: cesarreyes
 * Date: 14/11/10
 * Time: 09:28
 */
public enum Action {
  OPEN("open"),
  APPROVE("approve"),
  START_PROGRESS("startProgress"),
  STOP_PROGRESS("stopProgress"),
  RESOLVE("resolve"),
  CLOSE("close")

  private final String action
  public Action(String action) {
    this.action = action
  }

}