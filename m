Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 14 Jul 2022 09:49:15 +0200
From: Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH v2][RESEND] x86/entry: build thunk_$(BITS) only if
 CONFIG_PREEMPTION=y
Message-ID: <Ys/Ke7EWjcX+ZlXO@arighi-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Thadeu Lima de Souza Cascardo <cascardo@canonical.com>, x86@kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

With CONFIG_PREEMPTION disabled, arch/x86/entry/thunk_$(BITS).o becomes
an empty object file.

With some old versions of binutils (i.e., 2.35.90.20210113-1ubuntu1) the
GNU assembler doesn't generate a symbol table for empty object files and
objtool fails with the following error when a valid symbol table cannot
be found:

  arch/x86/entry/thunk_64.o: warning: objtool: missing symbol table

To prevent this from happening, build thunk_$(BITS).o only if
CONFIG_PREEMPTION is enabled.

BugLink: https://bugs.launchpad.net/bugs/1911359
Fixes: 320100a5ffe5 ("x86/entry: Remove the TRACE_IRQS cruft")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 arch/x86/entry/Makefile   | 3 ++-
 arch/x86/entry/thunk_32.S | 2 --
 arch/x86/entry/thunk_64.S | 4 ----
 arch/x86/um/Makefile      | 3 ++-
 4 files changed, 4 insertions(+), 8 deletions(-)

ChangeLog (v1 -> v2):
 - rebased to the latest kernel
 - do not break UML build

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index eeadbd7d92cc..ca2fe186994b 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -11,12 +11,13 @@ CFLAGS_REMOVE_common.o		= $(CC_FLAGS_FTRACE)
 
 CFLAGS_common.o			+= -fno-stack-protector
 
-obj-y				:= entry.o entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
+obj-y				:= entry.o entry_$(BITS).o syscall_$(BITS).o
 obj-y				+= common.o
 
 obj-y				+= vdso/
 obj-y				+= vsyscall/
 
+obj-$(CONFIG_PREEMPTION)	+= thunk_$(BITS).o
 obj-$(CONFIG_IA32_EMULATION)	+= entry_64_compat.o syscall_32.o
 obj-$(CONFIG_X86_X32_ABI)	+= syscall_x32.o
 
diff --git a/arch/x86/entry/thunk_32.S b/arch/x86/entry/thunk_32.S
index 7591bab060f7..ff6e7003da97 100644
--- a/arch/x86/entry/thunk_32.S
+++ b/arch/x86/entry/thunk_32.S
@@ -29,10 +29,8 @@ SYM_CODE_START_NOALIGN(\name)
 SYM_CODE_END(\name)
 	.endm
 
-#ifdef CONFIG_PREEMPTION
 	THUNK preempt_schedule_thunk, preempt_schedule
 	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
 	EXPORT_SYMBOL(preempt_schedule_thunk)
 	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
-#endif
 
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index 505b488fcc65..f38b07d2768b 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -31,14 +31,11 @@ SYM_FUNC_END(\name)
 	_ASM_NOKPROBE(\name)
 	.endm
 
-#ifdef CONFIG_PREEMPTION
 	THUNK preempt_schedule_thunk, preempt_schedule
 	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
 	EXPORT_SYMBOL(preempt_schedule_thunk)
 	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
-#endif
 
-#ifdef CONFIG_PREEMPTION
 SYM_CODE_START_LOCAL_NOALIGN(__thunk_restore)
 	popq %r11
 	popq %r10
@@ -53,4 +50,3 @@ SYM_CODE_START_LOCAL_NOALIGN(__thunk_restore)
 	RET
 	_ASM_NOKPROBE(__thunk_restore)
 SYM_CODE_END(__thunk_restore)
-#endif
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index ba5789c35809..a8cde4e8ab11 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -28,7 +28,8 @@ else
 
 obj-y += syscalls_64.o vdso/
 
-subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o
+subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o
+subarch-$(CONFIG_PREEMPTION) += ../entry/thunk_64.o
 
 endif
 
-- 
2.34.1


