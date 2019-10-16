Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iKk3F-0007kL-12
 for linux-um@lists.infradead.org; Wed, 16 Oct 2019 14:13:22 +0000
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH] um: Add back support for extra userspace libraries
Date: Wed, 16 Oct 2019 15:13:12 +0100
Message-Id: <20191016141312.15684-1-anton.ivanov@cambridgegreys.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: richard@nod.at, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 938962@bugs.debian.org

PCAP and VDE network transports require linking with userspace
libraries. The current build system has no means of passing these
as arguments.

This patch adds a script to expand the library list for linking
for these transports as well as any future driver that needs to
rely on additional libraries on the userspace side.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/scripts/extra-libs.sh | 10 ++++++++++
 scripts/link-vmlinux.sh       |  4 +++-
 2 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 arch/um/scripts/extra-libs.sh

diff --git a/arch/um/scripts/extra-libs.sh b/arch/um/scripts/extra-libs.sh
new file mode 100644
index 000000000000..0592485e0675
--- /dev/null
+++ b/arch/um/scripts/extra-libs.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+# This file should be included from link-vmlinux, not executed!!!
+
+if [ "${CONFIG_UML_NET_VDE}" = "y" ] ; then
+	UML_EXTRA_LIBS="$UML_EXTRA_LIBS -lvde -lvdeplug"
+fi
+if [ "${CONFIG_UML_NET_PCAP}" = "y" ] ; then
+	UML_EXTRA_LIBS="$UML_EXTRA_LIBS -lpcap"
+fi
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 06495379fcd8..15f9e5096da0 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -90,11 +90,13 @@ vmlinux_link()
 			-Wl,--end-group				\
 			${@}"
 
+		. arch/um/scripts/extra-libs.sh
+
 		${CC} ${CFLAGS_vmlinux}				\
 			-o ${output}				\
 			-Wl,-T,${lds}				\
 			${objects}				\
-			-lutil -lrt -lpthread
+			-lutil -lrt -lpthread ${UML_EXTRA_LIBS}
 		rm -f linux
 	fi
 }
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

