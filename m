Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BepCO-0001XO-0y for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Jun 2004 23:01:00 -0700
Received: from fed1rmmtao12.cox.net ([68.230.241.27])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BepCN-0006G0-IZ for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Jun 2004 23:00:59 -0700
Message-ID: <40DFB54D.5040109@easyco.com>
From: Doug Dumitru <doug@easyco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Patch for arch/um/drivers/line.c to fix buffer error
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 27 Jun 2004 23:06:05 -0700
To: user-mode-linux-devel@lists.sourceforge.net

All,

I have been fighting a buffering error when sending large amounts of 
data out pty devices from UML.  I have tried a couple of patches that 
did not really fix the problem (and were rightly rejected by the group), 
but have finally found the real bug.

In /arch/um/drivers/line.c there is a function "buffer_data" that is 
responsible for storing data into the lines ring buffer.  The function 
is "supposed" to return the number of characters actually buffered. 
Unfortunately, in the case where the buffer wraps, the "len" variable is 
decremented by "end" before it is used as the return parameter.

Here is a patch that fixes this.

--- linux-2.4.26-um/arch/um/drivers/line.c      2004-06-28 
01:46:21.000000000 -0400
+++ linux-2.4.23-um/arch/um/drivers/line.c      2004-06-28 
01:45:35.000000000 -0400
@@ -72,9 +72,9 @@
         else {
                 memcpy(line->tail, buf, end);
                 buf += end;
-               len -= end;
-               memcpy(line->buffer, buf, len);
-               line->tail = line->buffer + len;
+               //len -= end;
+               memcpy(line->buffer, buf, len - end );
+               line->tail = line->buffer + len - end;
         }

         return(len);

There is actually another bug in this area, but I am still working on a 
"good" fix for this.  The scenario is this:

   o An application opens an output device (ie /dev/serial/13)
   o It pushes stuff do the device
   o It closes the device

This would be like:

   cat /etc/termcap > /dev/serial/13

The problem is that the device will close while there is still data 
buffered in the ring buffer (and the ring-buffered data will not be 
transfered to the device).  This is a pretty complicated scenario to 
handle completely, so I have not tried to put together a patch for this 
(plus it does not directly impact my customers at this point).  In 
theory, handling all of these situations might require changes to how 
the ring-buffering is implemented (or maybe can the ring-buffer be 
eliminated all together).  Suggestions on how to implement this would be 
appreciated.

--------------------------------------------------------------------
Doug Dumitru     800-470-2756     (610-237-2000)
EasyCo LLC       doug@easyco.com  http://easyco.com
--------------------------------------------------------------------



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
