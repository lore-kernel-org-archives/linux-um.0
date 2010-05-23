Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sun, 23 May 2010 22:02:10 +0200
Message-Id: <1274644930-26600-26-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1274644930-26600-1-git-send-email-andrea.gelmini@gelma.net>
References: <1274644930-26600-1-git-send-email-andrea.gelmini@gelma.net>
Subject: [uml-devel] [PATCH 183/199] arch/um/os-Linux/drivers/Makefile:
	Checkpatch cleanup
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: andrea.gelmini@gelma.net
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, user-mode-linux-user@lists.sourceforge.net, vtun@office.satix.net, Maxim Krasnyansky <maxk@qualcomm.com>

arch/um/os-Linux/drivers/Makefile:1: ERROR: trailing whitespace
arch/um/os-Linux/drivers/Makefile:9: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/um/os-Linux/drivers/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/drivers/Makefile b/arch/um/os-Linux/drivers/Makefile
index 6c546dc..7106d8f 100644
--- a/arch/um/os-Linux/drivers/Makefile
+++ b/arch/um/os-Linux/drivers/Makefile
@@ -1,4 +1,4 @@
-# 
+#
 # Copyright (C) 2000, 2002 Jeff Dike (jdike@karaya.com)
 # Licensed under the GPL
 #
@@ -6,7 +6,7 @@
 ethertap-objs := ethertap_kern.o ethertap_user.o
 tuntap-objs := tuntap_kern.o tuntap_user.o
 
-obj-y = 
+obj-y =
 obj-$(CONFIG_UML_NET_ETHERTAP) += ethertap.o
 obj-$(CONFIG_UML_NET_TUNTAP) += tuntap.o
 
-- 
1.7.1.251.gf80a2


------------------------------------------------------------------------------

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

