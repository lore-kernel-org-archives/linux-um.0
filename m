Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JaZhZ-0007Pg-A7 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 Mar 2008 09:57:45 -0700
Received: from astoria.ccjclearline.com ([64.235.106.9])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JaZhX-0000Cy-1f
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 15 Mar 2008 09:57:45 -0700
Date: Sat, 15 Mar 2008 12:57:29 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Message-ID: <alpine.LFD.1.00.0803151255530.24311@localhost.localdomain>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH] UML:  Use newer,
	non-deprecated __SPIN_LOCK_UNLOCKED macro.
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@karaya.com>


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  not compile tested, it seems pretty straightforward.


diff --git a/arch/um/include/line.h b/arch/um/include/line.h
index 1223f2c..3791031 100644
--- a/arch/um/include/line.h
+++ b/arch/um/include/line.h
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
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry:
    Have classroom, will lecture.

http://crashcourse.ca                          Waterloo, Ontario, CANADA
========================================================================

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
