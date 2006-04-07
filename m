Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRs0i-0003G6-0F for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 07:32:28 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FRs0e-00079m-8h
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 07:32:24 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060407143107.19201.23684.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 08/17] uml: prepare fixing compilation output
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
Date: Fri, 07 Apr 2006 16:31:08 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Move the build of user-offsets to arch/um/Kbuild, this will allow using the
normal user-objs machinery. I had written this to fixup for a Kbuild change, but
another fix was merged. This is still useful however.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Kbuild   |    4 ++++
 arch/um/Makefile |    4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/um/Kbuild b/arch/um/Kbuild
new file mode 100644
index 0000000..ae2a254
--- /dev/null
+++ b/arch/um/Kbuild
@@ -0,0 +1,4 @@
+ARCH_DIR := arch/um
+
+$(ARCH_DIR)/user-offsets.s: $(ARCH_DIR)/sys-$(SUBARCH)/user-offsets.c
+	$(CC) $(USER_CFLAGS) -S -o $@ $<
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 24790be..ef8d71d 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -202,8 +202,8 @@ endef
 $(ARCH_DIR)/include/uml-config.h : include/linux/autoconf.h
 	$(call filechk,umlconfig)
 
-$(ARCH_DIR)/user-offsets.s: $(ARCH_DIR)/sys-$(SUBARCH)/user-offsets.c
-	$(CC) $(USER_CFLAGS) -S -o $@ $<
+$(ARCH_DIR)/user-offsets.s: FORCE
+	$(Q)$(MAKE) $(build)=$(ARCH_DIR) $@
 
 define filechk_gen-asm-offsets
         (set -e; \


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
