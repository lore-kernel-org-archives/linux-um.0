Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUWvD-0004hy-0E	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 15:05:31 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EUWvA-0003tA-BS
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 15:05:31 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20051025220302.20010.67493.stgit@zion.home.lan>
In-Reply-To: <20051025220053.20010.56979.stgit@zion.home.lan>
References: <20051025220053.20010.56979.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 11/11] uml: micro fixups to arch Kconfig
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
Date: Wed, 26 Oct 2005 00:03:03 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Remove a stone-age comment (UM *does* have a MMU, i.e. the host), and fix a
dependency (introduced in commit 02edeb586ae4cdd17778923674700edb732a4741) to
do what was intended.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -7,7 +7,6 @@ config UML
 	bool
 	default y
 
-# XXX: does UM have a mmu/swap?
 config MMU
 	bool
 	default y
@@ -196,7 +195,8 @@ config HOST_2G_2G
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
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
