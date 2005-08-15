Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E4oWG-0004Ru-4S	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Aug 2005 16:37:28 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E4oWF-0005Ie-Ot
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Aug 2005 16:37:28 -0700
Message-Id: <200508152325.j7FNP2sn008999@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/4] UML - Fix signal frame copy_user
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
Date: Mon, 15 Aug 2005 19:25:02 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

From Al Viro:

The copy_user stuff in the signal frame code was broke.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-rc6/arch/um/sys-i386/signal.c
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/sys-i386/signal.c	2005-08-15 12:03:10.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/sys-i386/signal.c	2005-08-15 12:04:08.000000000 -0400
@@ -122,9 +122,9 @@
 	int err;
 
 	to_fp = to->fpstate;
-	from_fp = from->fpstate;
 	sigs = to->oldmask;
 	err = copy_from_user(to, from, sizeof(*to));
+	from_fp = to->fpstate;
 	to->oldmask = sigs;
 	to->fpstate = to_fp;
 	if(to_fp != NULL)
Index: linux-2.6.13-rc6/arch/um/sys-x86_64/signal.c
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/sys-x86_64/signal.c	2005-08-15 12:03:10.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/sys-x86_64/signal.c	2005-08-15 12:04:08.000000000 -0400
@@ -104,28 +104,35 @@
 int copy_sc_from_user_tt(struct sigcontext *to, struct sigcontext *from,
                         int fpsize)
 {
-       struct _fpstate *to_fp, *from_fp;
-       unsigned long sigs;
-       int err;
-
-       to_fp = to->fpstate;
-       from_fp = from->fpstate;
-       sigs = to->oldmask;
-       err = copy_from_user(to, from, sizeof(*to));
-       to->oldmask = sigs;
-       return(err);
+	struct _fpstate *to_fp, *from_fp;
+	unsigned long sigs;
+	int err;
+
+	to_fp = to->fpstate;
+	sigs = to->oldmask;
+	err = copy_from_user(to, from, sizeof(*to));
+	from_fp = to->fpstate;
+	to->fpstate = to_fp;
+	to->oldmask = sigs;
+	if(to_fp != NULL)
+		err |= copy_from_user(to_fp, from_fp, fpsize);
+	return(err);
 }
 
 int copy_sc_to_user_tt(struct sigcontext *to, struct _fpstate *fp,
                       struct sigcontext *from, int fpsize)
 {
-       struct _fpstate *to_fp, *from_fp;
-       int err;
+	struct _fpstate *to_fp, *from_fp;
+	int err;
 
-       to_fp = (fp ? fp : (struct _fpstate *) (to + 1));
-       from_fp = from->fpstate;
-       err = copy_to_user(to, from, sizeof(*to));
-       return(err);
+	to_fp = (fp ? fp : (struct _fpstate *) (to + 1));
+	from_fp = from->fpstate;
+	err = copy_to_user(to, from, sizeof(*to));
+	if(from_fp != NULL){
+		err |= copy_to_user(&to->fpstate, &to_fp, sizeof(to->fpstate));
+		err |= copy_to_user(to_fp, from_fp, fpsize);
+	}
+	return(err);
 }
 
 #endif



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
