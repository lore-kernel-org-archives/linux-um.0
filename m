Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HZYZx-00031l-Ms for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Apr 2007 13:29:09 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HZYZw-0004o0-6Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Apr 2007 13:29:09 -0700
Date: Thu, 5 Apr 2007 16:24:52 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070405202452.GA8929@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/4] UML - Delete HOST_FRAME_SIZE
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

HOST_FRAME_SIZE isn't used any more.  It has been replaced with MAX_REG_NR.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/sys-i386/user-offsets.c   |    1 -
 arch/um/sys-x86_64/user-offsets.c |    1 -
 2 files changed, 2 deletions(-)

Index: linux-2.6.21-mm/arch/um/sys-i386/user-offsets.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/sys-i386/user-offsets.c	2007-04-05 12:38:56.000000000 -0400
+++ linux-2.6.21-mm/arch/um/sys-i386/user-offsets.c	2007-04-05 12:39:12.000000000 -0400
@@ -47,7 +47,6 @@ void foo(void)
 	OFFSET(HOST_SC_FP_ST, _fpstate, _st);
 	OFFSET(HOST_SC_FXSR_ENV, _fpstate, _fxsr_env);
 
-	DEFINE(HOST_FRAME_SIZE, FRAME_SIZE);
 	DEFINE_LONGS(HOST_FP_SIZE, sizeof(struct user_i387_struct));
 	DEFINE_LONGS(HOST_XFP_SIZE, sizeof(struct user_fxsr_struct));
 
Index: linux-2.6.21-mm/arch/um/sys-x86_64/user-offsets.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/sys-x86_64/user-offsets.c	2007-04-05 12:38:43.000000000 -0400
+++ linux-2.6.21-mm/arch/um/sys-x86_64/user-offsets.c	2007-04-05 12:39:12.000000000 -0400
@@ -57,7 +57,6 @@ void foo(void)
 	OFFSET(HOST_SC_SS, sigcontext, ss);
 #endif
 
-	DEFINE_LONGS(HOST_FRAME_SIZE, FRAME_SIZE);
 	DEFINE(HOST_FP_SIZE, sizeof(struct _fpstate) / sizeof(unsigned long));
 	DEFINE(HOST_XFP_SIZE, 0);
 	DEFINE_LONGS(HOST_RBX, RBX);

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
