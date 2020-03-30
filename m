Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIvgQ-0004RM-8K
 for linux-um@lists.infradead.org; Mon, 30 Mar 2020 14:46:35 +0000
Received: by mail-pj1-x1043.google.com with SMTP id kx8so7412707pjb.5
 for <linux-um@lists.infradead.org>; Mon, 30 Mar 2020 07:46:33 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v4 01/25] arch: add __SYSCALL_DEFINE_ARCH
Date: Mon, 30 Mar 2020 23:45:33 +0900
Message-Id: <9b9d47a8be1c38561d0fc3e4478628e4bb6056ef.1585579244.git.thehajime@gmail.com>
In-Reply-To: <cover.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
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
Cc: Octavian Purdila <tavi.purdila@gmail.com>, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Akira Moroo <retrage01@gmail.com>

From: Octavian Purdila <tavi.purdila@gmail.com>

This allows the architecture code to process the system call
definitions. It is used by LKL to create strong typed function
definitions for system calls.

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
Cc: linux-api@vger.kernel.org
---
 include/linux/syscalls.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1815065d52f3..e45815a3ee10 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -203,9 +203,14 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 }
 #endif
 
+#ifndef __SYSCALL_DEFINE_ARCH
+#define __SYSCALL_DEFINE_ARCH(x, sname, ...)
+#endif
+
 #ifndef SYSCALL_DEFINE0
 #define SYSCALL_DEFINE0(sname)					\
 	SYSCALL_METADATA(_##sname, 0);				\
+	__SYSCALL_DEFINE_ARCH(0, _##sname);			\
 	asmlinkage long sys_##sname(void);			\
 	ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);		\
 	asmlinkage long sys_##sname(void)
@@ -222,6 +227,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 
 #define SYSCALL_DEFINEx(x, sname, ...)				\
 	SYSCALL_METADATA(sname, x, __VA_ARGS__)			\
+	__SYSCALL_DEFINE_ARCH(x, sname, __VA_ARGS__)		\
 	__SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
 
 #define __PROTECT(...) asmlinkage_protect(__VA_ARGS__)
-- 
2.21.0 (Apple Git-122.2)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

