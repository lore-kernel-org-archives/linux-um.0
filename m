Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AVDei-0003ZV-BH
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 13 Dec 2003 09:34:16 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AVDeh-0005bZ-Rg
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 13 Dec 2003 09:34:16 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_X602/bhhsCVUoyU"
Message-Id: <200312131838.32002.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] [PATCH] 2.6: mrproper and clean still broken
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 13 Dec 2003 18:38:31 +0100
To: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_X602/bhhsCVUoyU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

PROBLEM:
make mrproper has problems with the SIZE var:
SIZE = (($(CONFIG_NEST_LEVEL) + $(CONFIG_KERNEL_HALF_GIGS)) * 0x20000000)
since .config is not included when doing *make clean* or *make mrproper*.
SOLUTION:
I've attached the patch to fix this. Actually someone(i.e. J.Cone) already 
sent this, but the form in which it was applied didn't fix the problem(or 
maybe it wasn't applied); the applied patch simply provided default config 
values.
I've attached also the other part of that patch, i.e. adding -g to USER_CFLAGS 
when needed.

Bye
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN

--Boundary-00=_X602/bhhsCVUoyU
Content-Type: text/x-diff;
  charset="us-ascii";
  name="Fix_clean_mrproper.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="Fix_clean_mrproper.patch"

--- ./arch/um/Makefile.cleanfix	2003-12-02 17:20:42.000000000 +0100
+++ ./arch/um/Makefile	2003-12-13 18:36:36.000000000 +0100
@@ -61,7 +61,11 @@
 
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 
-SIZE = (($(CONFIG_NEST_LEVEL) + $(CONFIG_KERNEL_HALF_GIGS)) * 0x20000000)
+#This is needed for clean and mrproper, since in that case .config is not
+#included; but the values here are meaningless
+CONFIG_NEST_LEVEL ?= 0
+CONFIG_KERNEL_HALF_GIGS ?= 0
+SIZE := (($(CONFIG_NEST_LEVEL) + $(CONFIG_KERNEL_HALF_GIGS)) * 0x20000000)
 
 ifeq ($(CONFIG_MODE_SKAS), y)
 $(SYS_HEADERS) : $(TOPDIR)/$(ARCH_DIR)/include/skas_ptregs.h
@@ -128,6 +132,11 @@
 # To get a definition of F_SETSIG
 USER_CFLAGS += -D_GNU_SOURCE
 
+ifdef CONFIG_DEBUG_INFO
+USER_CFLAGS += -g
+endif
+
+
 CLEAN_FILES += linux x.i gmon.out $(ARCH_DIR)/uml.lds.s \
 	$(ARCH_DIR)/dyn_link.ld.s $(ARCH_DIR)/include/uml-config.h \
 	$(GEN_HEADERS)

--Boundary-00=_X602/bhhsCVUoyU--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
