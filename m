Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdvOr-0003sT-8X for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Nov 2005 12:02:57 -0800
Received: from host222-100.pool871.interbusiness.it ([87.1.100.222]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EdvOq-0006pR-TI for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Nov 2005 12:02:57 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051120191021.4189.37355.stgit@zion.home.lan>
In-Reply-To: <20051120191019.4189.22191.stgit@zion.home.lan>
References: <20051120191019.4189.22191.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 2/2] uml: fix dynamic linking on some 64-bit
	distros
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
Date: Sun, 20 Nov 2005 20:10:22 +0100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Rob Landley <rob@landley.net>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The current UML build assumes that on x86-64 systems, /lib is a symlink 
to /lib64, but in some distributions (like PLD and CentOS) they are separate 
directories, so the 64 bit library loader isn't found.  This patch 
inserts /lib64 at the start of the rpath on x86-64 UML builds.

Signed-off-by: Rob Landley <rob@landley.net>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile-x86_64 |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/um/Makefile-x86_64 b/arch/um/Makefile-x86_64
index 4f118d5..38df311 100644
--- a/arch/um/Makefile-x86_64
+++ b/arch/um/Makefile-x86_64
@@ -12,3 +12,7 @@ CHECKFLAGS  += -m64
 
 ELF_ARCH := i386:x86-64
 ELF_FORMAT := elf64-x86-64
+
+# Not on all 64-bit distros /lib is a symlink to /lib64. PLD is an example.
+
+LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
