Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] arch/um: compile with modern headers
Date: Thu, 14 Dec 2017 03:23:37 +0100
Message-Id: <20171214022337.29183-1-Jason@zx2c4.com>
In-Reply-To: <3173108.m2qnmkuYxR@blindfold>
References: <3173108.m2qnmkuYxR@blindfold>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at, user-mode-linux-devel@lists.sourceforge.net
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, stable@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Recent libcs have gotten a bit more strict, so we actually need to
include the right headers and use the right types. This enables UML to
compile again.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: stable@vger.kernel.org
---
Rebased on linux-next, by request.

 arch/um/os-Linux/file.c   | 1 +
 arch/um/os-Linux/signal.c | 1 +
 arch/x86/um/stub_segv.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index 2db18cbbb0ea..c0197097c86e 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -12,6 +12,7 @@
 #include <sys/mount.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
+#include <sys/sysmacros.h>
 #include <sys/un.h>
 #include <sys/types.h>
 #include <os.h>
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index a5c0c909c48b..bf0acb8aad8b 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -16,6 +16,7 @@
 #include <os.h>
 #include <sysdep/mcontext.h>
 #include <um_malloc.h>
+#include <sys/ucontext.h>
 
 void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
 	[SIGTRAP]	= relay_signal,
diff --git a/arch/x86/um/stub_segv.c b/arch/x86/um/stub_segv.c
index fd6825537b97..27361cbb7ca9 100644
--- a/arch/x86/um/stub_segv.c
+++ b/arch/x86/um/stub_segv.c
@@ -6,6 +6,7 @@
 #include <sysdep/stub.h>
 #include <sysdep/faultinfo.h>
 #include <sysdep/mcontext.h>
+#include <sys/ucontext.h>
 
 void __attribute__ ((__section__ (".__syscall_stub")))
 stub_segv_handler(int sig, siginfo_t *info, void *p)
-- 
2.15.1


