Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A6wws-00026X-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 07 Oct 2003 11:52:42 -0700
Received: from fed1mtao06.cox.net ([68.6.19.125])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A6wws-0004MV-73
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 07 Oct 2003 11:52:42 -0700
Message-ID: <3F830C2C.8010308@easyco.com>
From: Doug Dumitru <doug@easyco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Patch for buffer overrun in serial/console device logic
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 07 Oct 2003 11:55:40 -0700
To: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

I have been having trouble with buffer overruns when talking to pty 
devices.  My boot config directs serial device with syntax like:

   ... ssl0=tty:/dev/pty/pty1009 ...

This sets up a serial line to talk with a pty device.  We don't use the 
ptmx interface so that we can definitavely know which device to talk to 
from the outside.

The problem we are seeing is that outbound data gets overrun.  If you 
send 100K out the stream, you tend to see the first 28K or so followed 
by a big gap followed by the last 3K or so of the stream.  We have 
tested this with the ptmx syntax/logic and the problem still seems to be 
there.  Also, if you test this with a very fast consumer (such as a 
local cat from the device), the problem does not manifest itself.  UML 
must be able to produce data faster than the outside world can consume it.

After a lot of looking, it appears that the line_write routine in line.c 
does not check to see if the buffer has enough room.  The 
buffer_data(...) routine does not appear to check for available space at 
all and just overwrites old data.

Here is the patch that appears to correct the issue:




--- ../linux-2.4.22/arch/um/drivers/line.c      Tue Oct  7 10:25:20 2003
+++ arch/um/drivers/line.c      Tue Oct  7 10:27:06 2003
@@ -97,6 +97,7 @@
         char *new;
         unsigned long flags;
         int n, err, i;
+       int room;

         if(tty->stopped) return 0;

@@ -115,6 +116,10 @@
         i = minor(tty->device) - tty->driver.minor_start;
         line = &lines[i];

+       room = line_write_room(tty);
+       if ( !room ) return -EAGAIN;
+       if ( room < len ) len = room;
+
         down(&line->sem);
         if(line->head != line->tail){
                 local_irq_save(flags);




We have this running in our 2.4.22 build, but would like to see it (or 
something equivelent) in the release so that we can take patches cleanly.

We also have a much messier, in-house patch that we apply to hostfs.c so 
that root mounts will correctly honor ownerships and rights.  Is anyone 
else working on this.  The 2.4.20-5um release appears to have a lot of 
missing stuff in this area, but if someone else is re-working this, I 
will put my patch down for a while and wait.  Otherwise, I will clean it 
up and submit it.

--------------------------------------------------------------------
Doug Dumitru     800-470-2756     (610-237-2000)
EasyCo LLC       doug@easyco.com  http://easyco.com
--------------------------------------------------------------------
D3, U2, jBase Virtual Servers.    Off-site backup over the internet.
Develop/test/deploy from $20/mo.  Fast, secure, cheaper than tape.
http://mirroredservers.com        http://mirroredbackup.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
