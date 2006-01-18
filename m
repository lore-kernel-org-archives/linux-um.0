Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzNDF-0000yK-S2 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 15:59:37 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EzNDF-0002Yn-Du
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 15:59:38 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060118235459.4626.36530.stgit@zion.home.lan>
In-Reply-To: <20060118235132.4626.74049.stgit@zion.home.lan>
References: <20060118235132.4626.74049.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 2/8] uml: comments about libc-conflict guards
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
Date: Thu, 19 Jan 2006 00:55:00 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


While fixing myself the mktime conflict (which someone already merged), I also
improved a few comments. Merge them up.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/Makefile |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 45435ff..936fd72 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -47,13 +47,16 @@ ARCH_INCLUDE	+= -I$(srctree)/$(ARCH_DIR)
 endif
 SYS_DIR		:= $(ARCH_DIR)/include/sysdep-$(SUBARCH)
 
-# -Dvmap=kernel_vmap affects everything, and prevents anything from
-# referencing the libpcap.o symbol so named.
+# -Dvmap=kernel_vmap prevents anything from referencing the libpcap.o symbol so
+# named - it's a common symbol in libpcap, so we get a binary which crashes.
 #
-# Same things for in6addr_loopback - found in libc.
+# Same things for in6addr_loopback and mktime - found in libc. For these two we
+# only get link-time error, luckily.
+#
+# These apply to USER_CFLAGS to.
 
-CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSUBARCH=\"$(SUBARCH)\" \
-	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap \
+CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSUBARCH=\"$(SUBARCH)\"	\
+	$(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap	\
 	-Din6addr_loopback=kernel_in6addr_loopback
 
 AFLAGS += $(ARCH_INCLUDE)
@@ -66,6 +69,7 @@ USER_CFLAGS := $(patsubst -D__KERNEL__,,
 # kernel_errno to separate them from the libc errno.  This allows -fno-common
 # in CFLAGS.  Otherwise, it would cause ld to complain about the two different
 # errnos.
+# These apply to kernelspace only.
 
 CFLAGS += -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask \
 	-Dmktime=kernel_mktime



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
