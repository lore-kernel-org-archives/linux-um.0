Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu7xK-0007s8-31
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:08:42 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu7xE-0000GW-No
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:08:42 +0000
Date: Thu, 18 Aug 2011 20:08:29 +0100
MIME-Version: 1.0
Message-Id: <E1Qu7x7-0007rw-PD@ZenIV.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 57/91] um: take chan_*.h and line.h to
 arch/um/drivers
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 .../{include/shared/chan_kern.h => drivers/chan.h} |    6 +++---
 arch/um/drivers/chan_kern.c                        |    2 +-
 arch/um/{include/shared => drivers}/chan_user.h    |    0
 arch/um/drivers/line.c                             |    2 +-
 arch/um/{include/shared => drivers}/line.h         |    0
 arch/um/drivers/ssl.c                              |    3 +--
 arch/um/drivers/stdio_console.c                    |    3 +--
 arch/um/os-Linux/skas/process.c                    |    2 +-
 8 files changed, 8 insertions(+), 10 deletions(-)
 rename arch/um/{include/shared/chan_kern.h => drivers/chan.h} (95%)
 rename arch/um/{include/shared => drivers}/chan_user.h (100%)
 rename arch/um/{include/shared => drivers}/line.h (100%)

diff --git a/arch/um/include/shared/chan_kern.h b/arch/um/drivers/chan.h
similarity index 95%
rename from arch/um/include/shared/chan_kern.h
rename to arch/um/drivers/chan.h
index 1e65145..8df0fd9 100644
--- a/arch/um/include/shared/chan_kern.h
+++ b/arch/um/drivers/chan.h
@@ -6,9 +6,9 @@
 #ifndef __CHAN_KERN_H__
 #define __CHAN_KERN_H__
 
-#include "linux/tty.h"
-#include "linux/list.h"
-#include "linux/console.h"
+#include <linux/tty.h>
+#include <linux/list.h>
+#include <linux/console.h>
 #include "chan_user.h"
 #include "line.h"
 
diff --git a/arch/um/drivers/chan_kern.c b/arch/um/drivers/chan_kern.c
index d4191fe..e040683 100644
--- a/arch/um/drivers/chan_kern.c
+++ b/arch/um/drivers/chan_kern.c
@@ -6,7 +6,7 @@
 #include <linux/slab.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
-#include "chan_kern.h"
+#include "chan.h"
 #include "os.h"
 
 #ifdef CONFIG_NOCONFIG_CHAN
diff --git a/arch/um/include/shared/chan_user.h b/arch/um/drivers/chan_user.h
similarity index 100%
rename from arch/um/include/shared/chan_user.h
rename to arch/um/drivers/chan_user.h
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 364c8a1..c1cf220 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -7,7 +7,7 @@
 #include "linux/kd.h"
 #include "linux/sched.h"
 #include "linux/slab.h"
-#include "chan_kern.h"
+#include "chan.h"
 #include "irq_kern.h"
 #include "irq_user.h"
 #include "kern_util.h"
diff --git a/arch/um/include/shared/line.h b/arch/um/drivers/line.h
similarity index 100%
rename from arch/um/include/shared/line.h
rename to arch/um/drivers/line.h
diff --git a/arch/um/drivers/ssl.c b/arch/um/drivers/ssl.c
index 678e205..9d8c20a 100644
--- a/arch/um/drivers/ssl.c
+++ b/arch/um/drivers/ssl.c
@@ -12,9 +12,8 @@
 #include "linux/console.h"
 #include "asm/termbits.h"
 #include "asm/irq.h"
-#include "line.h"
 #include "ssl.h"
-#include "chan_kern.h"
+#include "chan.h"
 #include "init.h"
 #include "irq_user.h"
 #include "mconsole_kern.h"
diff --git a/arch/um/drivers/stdio_console.c b/arch/um/drivers/stdio_console.c
index 49266f6..088776f 100644
--- a/arch/um/drivers/stdio_console.c
+++ b/arch/um/drivers/stdio_console.c
@@ -20,8 +20,7 @@
 #include "asm/current.h"
 #include "asm/irq.h"
 #include "stdio_console.h"
-#include "line.h"
-#include "chan_kern.h"
+#include "chan.h"
 #include "irq_user.h"
 #include "mconsole_kern.h"
 #include "init.h"
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 3fdac54..ce26053 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -13,7 +13,7 @@
 #include <sys/wait.h>
 #include <asm/unistd.h>
 #include "as-layout.h"
-#include "chan_user.h"
+#include "init.h"
 #include "kern_util.h"
 #include "mem.h"
 #include "os.h"
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

