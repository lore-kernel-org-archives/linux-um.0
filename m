Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu81m-0000Gm-7r
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:13:19 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu81l-0000Pv-Di
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:13:18 +0000
Date: Thu, 18 Aug 2011 20:13:10 +0100
MIME-Version: 1.0
Message-Id: <E1Qu81e-000887-1l@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Subject: [PATCH 85/91] um: switch to generic-y
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


kill wrapper headers

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/asm/Kbuild              |    2 ++
 arch/um/include/asm/bug.h               |    6 ------
 arch/um/include/asm/cputime.h           |    6 ------
 arch/um/include/asm/device.h            |    7 -------
 arch/um/include/asm/emergency-restart.h |    6 ------
 arch/um/include/asm/futex.h             |    6 ------
 arch/um/include/asm/hardirq.h           |    1 -
 arch/um/include/asm/irq_regs.h          |    1 -
 arch/um/include/asm/kdebug.h            |    1 -
 arch/um/include/asm/percpu.h            |    6 ------
 arch/um/include/asm/sections.h          |    7 -------
 arch/um/include/asm/topology.h          |    6 ------
 arch/um/include/asm/xor.h               |    6 ------
 13 files changed, 2 insertions(+), 59 deletions(-)
 create mode 100644 arch/um/include/asm/Kbuild
 delete mode 100644 arch/um/include/asm/bug.h
 delete mode 100644 arch/um/include/asm/cputime.h
 delete mode 100644 arch/um/include/asm/device.h
 delete mode 100644 arch/um/include/asm/emergency-restart.h
 delete mode 100644 arch/um/include/asm/futex.h
 delete mode 100644 arch/um/include/asm/hardirq.h
 delete mode 100644 arch/um/include/asm/irq_regs.h
 delete mode 100644 arch/um/include/asm/kdebug.h
 delete mode 100644 arch/um/include/asm/percpu.h
 delete mode 100644 arch/um/include/asm/sections.h
 delete mode 100644 arch/um/include/asm/topology.h
 delete mode 100644 arch/um/include/asm/xor.h

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
new file mode 100644
index 0000000..e16895d
--- /dev/null
+++ b/arch/um/include/asm/Kbuild
@@ -0,0 +1,2 @@
+generic-y += bug.h cputime.h device.h emergency-restart.h futex.h hardirq.h
+generic-y += irq_regs.h kdebug.h percpu.h sections.h topology.h xor.h
diff --git a/arch/um/include/asm/bug.h b/arch/um/include/asm/bug.h
deleted file mode 100644
index 9e33b86..0000000
--- a/arch/um/include/asm/bug.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __UM_BUG_H
-#define __UM_BUG_H
-
-#include <asm-generic/bug.h>
-
-#endif
diff --git a/arch/um/include/asm/cputime.h b/arch/um/include/asm/cputime.h
deleted file mode 100644
index c84acba..0000000
--- a/arch/um/include/asm/cputime.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __UM_CPUTIME_H
-#define __UM_CPUTIME_H
-
-#include <asm-generic/cputime.h>
-
-#endif /* __UM_CPUTIME_H */
diff --git a/arch/um/include/asm/device.h b/arch/um/include/asm/device.h
deleted file mode 100644
index d8f9872..0000000
--- a/arch/um/include/asm/device.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/*
- * Arch specific extensions to struct device
- *
- * This file is released under the GPLv2
- */
-#include <asm-generic/device.h>
-
diff --git a/arch/um/include/asm/emergency-restart.h b/arch/um/include/asm/emergency-restart.h
deleted file mode 100644
index 108d8c4..0000000
--- a/arch/um/include/asm/emergency-restart.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_EMERGENCY_RESTART_H
-#define _ASM_EMERGENCY_RESTART_H
-
-#include <asm-generic/emergency-restart.h>
-
-#endif /* _ASM_EMERGENCY_RESTART_H */
diff --git a/arch/um/include/asm/futex.h b/arch/um/include/asm/futex.h
deleted file mode 100644
index 6a332a9..0000000
--- a/arch/um/include/asm/futex.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_FUTEX_H
-#define _ASM_FUTEX_H
-
-#include <asm-generic/futex.h>
-
-#endif
diff --git a/arch/um/include/asm/hardirq.h b/arch/um/include/asm/hardirq.h
deleted file mode 100644
index fb3c05a..0000000
--- a/arch/um/include/asm/hardirq.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/hardirq.h>
diff --git a/arch/um/include/asm/irq_regs.h b/arch/um/include/asm/irq_regs.h
deleted file mode 100644
index 3dd9c0b..0000000
--- a/arch/um/include/asm/irq_regs.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/irq_regs.h>
diff --git a/arch/um/include/asm/kdebug.h b/arch/um/include/asm/kdebug.h
deleted file mode 100644
index 6ece1b0..0000000
--- a/arch/um/include/asm/kdebug.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/kdebug.h>
diff --git a/arch/um/include/asm/percpu.h b/arch/um/include/asm/percpu.h
deleted file mode 100644
index efe7508..0000000
--- a/arch/um/include/asm/percpu.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __UM_PERCPU_H
-#define __UM_PERCPU_H
-
-#include <asm-generic/percpu.h>
-
-#endif /* __UM_PERCPU_H */
diff --git a/arch/um/include/asm/sections.h b/arch/um/include/asm/sections.h
deleted file mode 100644
index 6b0231e..0000000
--- a/arch/um/include/asm/sections.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef _UM_SECTIONS_H
-#define _UM_SECTIONS_H
-
-/* nothing to see, move along */
-#include <asm-generic/sections.h>
-
-#endif
diff --git a/arch/um/include/asm/topology.h b/arch/um/include/asm/topology.h
deleted file mode 100644
index 0905e4f..0000000
--- a/arch/um/include/asm/topology.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_UM_TOPOLOGY_H
-#define _ASM_UM_TOPOLOGY_H
-
-#include <asm-generic/topology.h>
-
-#endif
diff --git a/arch/um/include/asm/xor.h b/arch/um/include/asm/xor.h
deleted file mode 100644
index a19db3e..0000000
--- a/arch/um/include/asm/xor.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __UM_XOR_H
-#define __UM_XOR_H
-
-#include "asm-generic/xor.h"
-
-#endif
-- 
1.7.2.5



------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

