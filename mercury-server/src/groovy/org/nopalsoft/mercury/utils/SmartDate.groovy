package org.nopalsoft.mercury.utils

import groovy.time.*
import org.apache.commons.lang.time.DateUtils

/**
 * User: cesarreyes
 * Date: 09/08/11
 * Time: 23:09
 */
public class SmartDate {

   public Date fromSmartDate(String dateS){
      if(!dateS)
         return null

      boolean isPast = dateS.startsWith("-")
      if(dateS.contains("w")){
         if(isPast){
            use( [groovy.time.TimeCategory] ){
               def substring = dateS.substring(1, dateS.length() - 1)
               int numberOfWeeks = substring as int
               def now = DateUtils.truncate(new Date(), Calendar.DATE)
               //def weeksAgo = new Date(0, 0, 7 * numberOfWeeks)
               return now - numberOfWeeks.weeks
            }
         }
      }
   }
}
