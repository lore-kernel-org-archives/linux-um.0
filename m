Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GVaz3-0006ZY-0v for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:42:25 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GVaz2-0000Pw-DQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Oct 2006 14:42:25 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Thu, 05 Oct 2006 23:39:20 +0200
Message-Id: <20061005213920.17268.4856.stgit@memento.home.lan>
In-Reply-To: <20061005213212.17268.7409.stgit@memento.home.lan>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
Subject: [uml-devel] [PATCH 14/14] uml: allow finer tuning for host VMSPLIT
	setting
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Now that various memory splits are enabled, add a config option allowing the
user to compile UML for its need - HOST_2G_2G allowed to choose either 3G/1G or
2G/2G, and enabling it reduced the usable virtual memory.

Detecting this at run time should be implemented in the future, but we must make
the stop-gap measure work well enough (this is valid in _many_ cases).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Kconfig.i386 |   49 ++++++++++++++++++++++++++++++++++---------------
 1 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/arch/um/Kconfig.i386 b/arch/um/Kconfig.i386
index f6eb72d..f191a55 100644
--- a/arch/um/Kconfig.i386
+++ b/arch/um/Kconfig.i386
@@ -16,23 +16,42 @@ config SEMAPHORE_SLEEPERS
 	bool
 	default y
 
-config HOST_2G_2G
-	bool "2G/2G host address space split"
-	default n
-	help
-	This is needed when the host on which you run has a 2G/2G memory
-	split, instead of the customary 3G/1G.
-
-	Note that to enable such a host
-	configuration, which makes sense only in some cases, you need special
-	host patches.
-
-	So, if you do not know what to do here, say 'N'.
+choice
+	prompt "Host memory split"
+	default HOST_VMSPLIT_3G
+	---help---
+	   This is needed when the host kernel on which you run has a non-default
+	   (like 2G/2G) memory split, instead of the customary 3G/1G. If you did
+	   not recompile your own kernel but use the default distro's one, you can
+	   safely accept the "Default split" option.
+
+	   It can be enabled on recent (>=2.6.16-rc2) vanilla kernels via
+	   CONFIG_VM_SPLIT_*, or on previous kernels with special patches (-ck
+	   patchset by Con Kolivas, or other ones) - option names match closely the
+	   host CONFIG_VM_SPLIT_* ones.
+
+	   A lower setting (where 1G/3G is lowest and 3G/1G is higher) will
+	   tolerate even more "normal" host kernels, but an higher setting will be
+	   stricter.
+
+	   So, if you do not know what to do here, say 'Default split'.
+
+	config HOST_VMSPLIT_3G
+		bool "Default split (3G/1G user/kernel host split)"
+	config HOST_VMSPLIT_3G_OPT
+		bool "3G/1G user/kernel host split (for full 1G low memory)"
+	config HOST_VMSPLIT_2G
+		bool "2G/2G user/kernel host split"
+	config HOST_VMSPLIT_1G
+		bool "1G/3G user/kernel host split"
+endchoice
 
 config TOP_ADDR
- 	hex
- 	default 0xc0000000 if !HOST_2G_2G
- 	default 0x80000000 if HOST_2G_2G
+	hex
+	default 0xB0000000 if HOST_VMSPLIT_3G_OPT
+	default 0x78000000 if HOST_VMSPLIT_2G
+	default 0x40000000 if HOST_VMSPLIT_1G
+	default 0xC0000000
 
 config 3_LEVEL_PGTABLES
 	bool "Three-level pagetables (EXPERIMENTAL)"
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
