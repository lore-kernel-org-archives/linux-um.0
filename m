Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAjLa-0007JA-B9 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Mar 2005 22:46:38 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DAjLY-0005i7-OB
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Mar 2005 22:46:38 -0800
Received: from knoppix (grelber.thyrsus.com [192.168.1.31])
	by grelber.thyrsus.com (8.13.1/8.13.1) with ESMTP id j2E7xqfP032161
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 14 Mar 2005 02:59:53 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200503140043.50163.rob@landley.net>
Subject: [uml-devel] [patch] Fixing the stdio console stuttering.
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
Date: Mon, 14 Mar 2005 00:43:49 -0500
To: user-mode-linux-devel@lists.sourceforge.net

I spent far too much of the weekend tracking this sucker down through the guts
of the tty code.  The problem turns out to be that drivers/char/n_tty.c has a
write_chan that does buffering and retransmitting data, and
arch/um/drivers/chan_kern.c ALSO has a write_chan that buffers and retransmits
data, and the first calls the second but the second doesn't always return
correct status information for the -EAGAIN case.

When they get confused, both of them try to buffer and retransmit data, hence
the stuttering.

The first fix is that if chan_kern's write_chan gets an -EAGAIN, it should NOT
gratuitously change that to a 0 before returning.  I don't know why that code
is in there, but deleting those two lines makes 90% the stuttering go away. 
But not quite all of it.

The second half of the fix is arch/um/drivers/line.c has a buffer_data()
function that adds data to the buffer, tries to flush the buffer out to disk,
gets -EAGAIN, and then returns -EAGAIN even though it successfully buffered
all the data it was sent.  So the upper layer resubmits the last chunk of data
it sent when the console unblocks, even though the lower layer buffered it and
sent it on by that point.

With this patch, I can't get the UML console to stutter anymore by suspending
the process it's writing to.  (Add tee to the mix and you can still make it
hang by suspending its xterm for a second or two, but I think that tee
is hanging, not UML.  Hangs with RHEL4 tee, but not busybox tee...)

Signed-off-by: Rob Landley <rob@landley.net>

diff -ru linux-2.6.11.2/arch/um/drivers/chan_kern.c linux-2.6.11-umlfix/arch/um/drivers/chan_kern.c
--- linux-2.6.11.2/arch/um/drivers/chan_kern.c	2005-03-02 01:38:33.000000000 -0600
+++ linux-2.6.11-umlfix/arch/um/drivers/chan_kern.c	2005-03-13 08:31:34.000000000 -0600
@@ -250,11 +250,8 @@
 		n = chan->ops->write(chan->fd, buf, len, chan->data);
 		if (chan->primary) {
 			ret = n;
-			if ((ret == -EAGAIN) || ((ret >= 0) && (ret < len))){
+			if ((ret == -EAGAIN) || ((ret >= 0) && (ret < len)))
 				reactivate_fd(chan->fd, write_irq);
-				if (ret == -EAGAIN)
-					ret = 0;
-			}
 		}
 	}
 	return(ret);
diff -ru linux-2.6.11.2/arch/um/drivers/line.c linux-2.6.11-umlfix/arch/um/drivers/line.c
--- linux-2.6.11.2/arch/um/drivers/line.c	2005-03-02 01:38:25.000000000 -0600
+++ linux-2.6.11-umlfix/arch/um/drivers/line.c	2005-03-13 12:28:50.000000000 -0600
@@ -128,7 +128,7 @@
 		ret = buffer_data(line, buf, len);
 		err = flush_buffer(line);
 		local_irq_restore(flags);
-		if(err <= 0)
+		if(err <= 0 && (err != -EAGAIN || !ret))
 			ret = err;
 	}
 	else {


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
