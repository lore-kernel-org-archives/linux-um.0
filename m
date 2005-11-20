Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdvOq-0003sO-Ht for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Nov 2005 12:02:56 -0800
Received: from host222-100.pool871.interbusiness.it ([87.1.100.222]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EdvOq-0006pV-3M for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Nov 2005 12:02:56 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051120191019.4189.22191.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 1/2] uml: arch/um/scripts/Makefile.rules - remove
	duplicated code
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
Date: Sun, 20 Nov 2005 20:10:19 +0100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Duplicated code - the patch adding it was probably applied twice without enough
care.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/scripts/Makefile.rules |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/um/scripts/Makefile.rules b/arch/um/scripts/Makefile.rules
index b3fbf12..2e41cab 100644
--- a/arch/um/scripts/Makefile.rules
+++ b/arch/um/scripts/Makefile.rules
@@ -21,11 +21,6 @@ define unprofile
 endef
 
 
-# The stubs and unmap.o can't try to call mcount or update basic block data
-define unprofile
-	$(patsubst -pg,,$(patsubst -fprofile-arcs -ftest-coverage,,$(1)))
-endef
-
 # cmd_make_link checks to see if the $(foo-dir) variable starts with a /.  If
 # so, it's considered to be a path relative to $(srcdir) rather than
 # $(srcdir)/arch/$(SUBARCH).  This is because x86_64 wants to get ldt.c from



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
