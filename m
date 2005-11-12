Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eazi4-0004gI-Kj for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 10:02:40 -0800
Received: from host20-103.pool873.interbusiness.it ([87.3.103.20]
	helo=zion.home.lan) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eazi3-0001xk-T6 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 10:02:40 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051112180721.20133.32312.stgit@zion.home.lan>
In-Reply-To: <20051112180711.20133.68166.stgit@zion.home.lan>
References: <20051112180711.20133.68166.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 3/9] uml: micro fixups to arch Kconfig
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
Date: Sat, 12 Nov 2005 19:07:24 +0100
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Remove a stone-age comment (UM *does* have a MMU, i.e. the host), and fix a
dependency (introduced in commit 02edeb586ae4cdd17778923674700edb732a4741) to
do what was intended.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 3b5f47c..018f076 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -7,7 +7,6 @@ config UML
 	bool
 	default y
 
-# XXX: does UM have a mmu/swap?
 config MMU
 	bool
 	default y
@@ -209,7 +208,8 @@ config MAGIC_SYSRQ
 config SMP
 	bool "Symmetric multi-processing support (EXPERIMENTAL)"
 	default n
-	depends on (MODE_TT && EXPERIMENTAL && !SMP_BROKEN) || (BROKEN && SMP_BROKEN)
+	#SMP_BROKEN is for x86_64.
+	depends on MODE_TT && EXPERIMENTAL && (!SMP_BROKEN || (BROKEN && SMP_BROKEN))
 	help
 	This option enables UML SMP support.
 	It is NOT related to having a real SMP box. Not directly, at least.



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
