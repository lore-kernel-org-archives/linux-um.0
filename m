Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPjXM-0008Qg-01
 for linux-um@lists.infradead.org; Tue, 06 Oct 2020 09:45:36 +0000
Received: by mail-pf1-x444.google.com with SMTP id 144so8703091pfb.4
 for <linux-um@lists.infradead.org>; Tue, 06 Oct 2020 02:45:35 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v7 09/21] um: nommu: host interface
Date: Tue,  6 Oct 2020 18:44:18 +0900
Message-Id: <9494c2558406a8fd2938fef0c470dd640b7835ed.1601960644.git.thehajime@gmail.com>
In-Reply-To: <cover.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
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
To: linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: tavi.purdila@gmail.com, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, Hajime Tazaki <thehajime@gmail.com>, retrage01@gmail.com

This patch introduces the host operations that define the interface
between the LKL and the host. These operations must be provided either
by a host library or by the application itself.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/include/asm/host_ops.h            |  9 ++++++++
 arch/um/nommu/include/uapi/asm/host_ops.h | 25 +++++++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 arch/um/include/asm/host_ops.h
 create mode 100644 arch/um/nommu/include/uapi/asm/host_ops.h

diff --git a/arch/um/include/asm/host_ops.h b/arch/um/include/asm/host_ops.h
new file mode 100644
index 000000000000..f52423cc4ced
--- /dev/null
+++ b/arch/um/include/asm/host_ops.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LKL_HOST_OPS_H
+#define _ASM_LKL_HOST_OPS_H
+
+#include <uapi/asm/host_ops.h>
+
+extern struct lkl_host_operations *lkl_ops;
+
+#endif
diff --git a/arch/um/nommu/include/uapi/asm/host_ops.h b/arch/um/nommu/include/uapi/asm/host_ops.h
new file mode 100644
index 000000000000..d3dad11b459e
--- /dev/null
+++ b/arch/um/nommu/include/uapi/asm/host_ops.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __UM_NOMMU_UAPI_HOST_OPS_H
+#define __UM_NOMMU_UAPI_HOST_OPS_H
+
+/* Defined in {posix,nt}-host.c */
+struct lkl_mutex;
+struct lkl_sem;
+typedef unsigned long lkl_thread_t;
+struct lkl_jmp_buf {
+	unsigned long buf[128];
+};
+
+/**
+ * lkl_host_operations - host operations used by the Linux kernel
+ *
+ * These operations must be provided by a host library or by the application
+ * itself.
+ *
+ */
+struct lkl_host_operations {
+};
+
+void lkl_bug(const char *fmt, ...);
+
+#endif
-- 
2.21.0 (Apple Git-122.2)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

