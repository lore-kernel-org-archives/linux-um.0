Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DGiHy-00016D-S6 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Mar 2005 10:51:38 -0800
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DGiHe-0002a4-T3 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Mar 2005 10:51:38 -0800
From: blaisorblade@yahoo.it
Message-Id: <20050330173407.169FFEFF2A@zion>
Subject: [uml-devel] [patch 8/8] Fix the console stuttering [for 2.6.12]
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
Date: Wed, 30 Mar 2005 19:34:06 +0200
To: torvalds@osdl.org
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, rob@landley.net


From: Rob Landley <rob@landley.net>

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
Acked-by: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/drivers/chan_kern.c |    5 +----
 linux-2.6.11-paolo/arch/um/drivers/line.c      |    2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff -puN arch/um/drivers/chan_kern.c~uml-fix-console-stuttering arch/um/drivers/chan_kern.c
--- linux-2.6.11/arch/um/drivers/chan_kern.c~uml-fix-console-stuttering	2005-03-29 17:03:18.000000000 +0200
+++ linux-2.6.11-paolo/arch/um/drivers/chan_kern.c	2005-03-29 17:03:19.000000000 +0200
@@ -248,11 +248,8 @@ int write_chan(struct list_head *chans, 
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
diff -puN arch/um/drivers/line.c~uml-fix-console-stuttering arch/um/drivers/line.c
--- linux-2.6.11/arch/um/drivers/line.c~uml-fix-console-stuttering	2005-03-29 17:03:19.000000000 +0200
+++ linux-2.6.11-paolo/arch/um/drivers/line.c	2005-03-29 17:03:19.000000000 +0200
@@ -128,7 +128,7 @@ int line_write(struct tty_struct *tty, c
 		ret = buffer_data(line, buf, len);
 		err = flush_buffer(line);
 		local_irq_restore(flags);
-		if(err <= 0)
+		if(err <= 0 && (err != -EAGAIN || !ret))
 			ret = err;
 	}
 	else {
_


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/info/Sentarus/hamr30
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
