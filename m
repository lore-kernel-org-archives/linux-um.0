Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/3] um: Drop own definition of PTRACE_SYSEMU/_SINGLESTEP
Date: Fri, 15 Jun 2018 16:42:54 +0200
Message-Id: <20180615144256.13343-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>, stable@vger.kernel.org, Ritesh Raj Sarraf <rrs@researchut.com>
List-ID: <linux-um.lists.infradead.org>

32bit UML used to define PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP
own its own because many years ago not all libcs had these request codes
in their UAPI.
These days PTRACE_SYSEMU/_SINGLESTEP is well known and part of glibc
and our own define becomes problematic.

With change c48831d0eebf ("linux/x86: sync sys/ptrace.h with Linux 4.14
[BZ #22433]") glibc turned PTRACE_SYSEMU/_SINGLESTEP into a enum and
UML failed to build.

Let's drop our define and rely on the fact that every libc has
PTRACE_SYSEMU/_SINGLESTEP.

Cc: <stable@vger.kernel.org>
Cc: Ritesh Raj Sarraf <rrs@researchut.com>
Reported-and-tested-by: Ritesh Raj Sarraf <rrs@researchut.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/x86/um/shared/sysdep/ptrace_32.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/x86/um/shared/sysdep/ptrace_32.h b/arch/x86/um/shared/sysdep/ptrace_32.h
index b94a108de1dc..ae00d22bce02 100644
--- a/arch/x86/um/shared/sysdep/ptrace_32.h
+++ b/arch/x86/um/shared/sysdep/ptrace_32.h
@@ -10,20 +10,10 @@
 
 static inline void update_debugregs(int seq) {}
 
-/* syscall emulation path in ptrace */
-
-#ifndef PTRACE_SYSEMU
-#define PTRACE_SYSEMU 31
-#endif
-
 void set_using_sysemu(int value);
 int get_using_sysemu(void);
 extern int sysemu_supported;
 
-#ifndef PTRACE_SYSEMU_SINGLESTEP
-#define PTRACE_SYSEMU_SINGLESTEP 32
-#endif
-
 #define UPT_SYSCALL_ARG1(r) UPT_BX(r)
 #define UPT_SYSCALL_ARG2(r) UPT_CX(r)
 #define UPT_SYSCALL_ARG3(r) UPT_DX(r)
-- 
2.13.6


