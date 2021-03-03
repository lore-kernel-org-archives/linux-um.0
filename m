Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTw1-005VUi-5d
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 16:01:17 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 21/27] um: Add UML_SECCOMP configuration option
Date: Wed,  3 Mar 2021 16:55:17 +0100
Message-Id: <20210303155523.124277-22-benjamin@sipsolutions.net>
In-Reply-To: <20210303155523.124277-1-benjamin@sipsolutions.net>
References: <20210303155523.124277-1-benjamin@sipsolutions.net>
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
Cc: Benjamin Berg <benjamin@sipsolutions.net>

Add the UML_SECCOMP configuration options. The next commits will add the
support itself in smaller chunks.

Only x86_64 will be supported for now.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/Kconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index c3030db3325f..769bc770c5fa 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -188,6 +188,25 @@ config UML_TIME_TRAVEL_SUPPORT
 
 	  It is safe to say Y, but you probably don't need this.
 
+config UML_SECCOMP
+	bool "seccomp based process tracing"
+	default n
+	depends on 64BIT
+	help
+	  Enable this option will enable seccomp based tracing of processes.
+
+	  UML must call syscalls from within the userspace processes when
+	  mapping physical memory in response to page faults. Using seccomp
+	  based tracing permits delaying these host syscalls until userspace
+	  processes are resumed in order to run a task, thereby avoiding
+	  overhead for the host by saving context switches.
+
+	  This feature speeds up e.g. fork() heavy workloads considerably.
+	  However, the current implementation is not safe as userspace
+	  processes can trigger any syscall to the host OS.
+
+	  If in doubt say N, as the feature has security implications.
+
 endmenu
 
 source "arch/um/drivers/Kconfig"
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

