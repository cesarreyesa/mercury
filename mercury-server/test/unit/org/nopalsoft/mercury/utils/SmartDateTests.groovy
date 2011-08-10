package org.nopalsoft.mercury.utils

import junit.framework.TestCase
import groovy.time.*
import org.apache.commons.lang.time.DateUtils

/**
 * User: cesarreyes
 * Date: 09/08/11
 * Time: 23:23
 */
class SmartDateTests extends TestCase {


   public void testWeekAgo(){
      use( [groovy.time.TimeCategory] ){
         SmartDate sm = new SmartDate()
         Date now = DateUtils.truncate(new Date(), Calendar.DATE)
         def date = Calendar.getInstance()
         date.set(Calendar.YEAR, 2011)
         date.set(Calendar.MONTH, Calendar.AUGUST)
         date.set(Calendar.DAY_OF_MONTH, 2)
         date.set(Calendar.HOUR_OF_DAY, 0)
         date.set(Calendar.MINUTE, 0)
         date.set(Calendar.SECOND, 0)
         date.set(Calendar.MILLISECOND, 0)

         Date actual = sm.fromSmartDate("-1w")

         assertEquals(now - 7.days, actual)
      }
   }
}
