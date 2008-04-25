Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JpSAG-0003lT-VL for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 10:56:53 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JpSA1-0005Ta-7c
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 10:56:39 -0700
Date: Fri, 25 Apr 2008 13:56:15 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080425175615.GA11200@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 15/19] UML - use __SPIN_LOCK_UNLOCKED
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>

From: Robert P. J. Day <rpjday@crashcourse.ca>

Use newer, non-deprecated __SPIN_LOCK_UNLOCKED macro.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/include/line.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.22/arch/um/include/line.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/line.h	2007-07-08 19:32:17.000000000 -0400
+++ linux-2.6.22/arch/um/include/line.h	2008-03-17 13:42:36.000000000 -0400
@@ -58,11 +58,11 @@ struct line {
 };
 
 #define LINE_INIT(str, d) \
-	{ .count_lock =	SPIN_LOCK_UNLOCKED, \
+	{ .count_lock =	__SPIN_LOCK_UNLOCKED((str).count_lock), \
 	  .init_str =	str,	\
 	  .init_pri =	INIT_STATIC, \
 	  .valid =	1, \
-	  .lock =	SPIN_LOCK_UNLOCKED, \
+	  .lock =	__SPIN_LOCK_UNLOCKED((str).lock), \
 	  .driver =	d }
 
 extern void line_close(struct tty_struct *tty, struct file * filp);

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
