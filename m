Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cp6wF-0005aQ-EM for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 07:31:07 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Cp6wC-0007lk-Fk for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 07:31:07 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20050113051325.63FB163245@zion>
Subject: [uml-devel] [patch 1/8] uml: avoid NULL dereference in line.c
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
Date: Thu, 13 Jan 2005 06:13:24 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it, frank@tuxrocks.com


From: Frank Sorenson <frank@tuxrocks.com>

This patch reorders two lines to check a variable for NULL before using 
the variable.

Signed-off-by: Frank Sorenson <frank@tuxrocks.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/drivers/line.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/drivers/line.c~uml-reorder_null_check arch/um/drivers/line.c
--- linux-2.6.11/arch/um/drivers/line.c~uml-reorder_null_check	2005-01-13 01:54:17.163057872 +0100
+++ linux-2.6.11-paolo/arch/um/drivers/line.c	2005-01-13 01:54:17.166057416 +0100
@@ -593,8 +593,8 @@ irqreturn_t winch_interrupt(int irq, voi
 		}
 	}
 	tty  = winch->tty;
-	line = tty->driver_data;
 	if (tty != NULL) {
+		line = tty->driver_data;
 		chan_window_size(&line->chan_list,
 				 &tty->winsize.ws_row, 
 				 &tty->winsize.ws_col);
_


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
