Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v10 1/7] x86/arch_prctl/64: Use SYSCALL_DEFINE2 to define sys_arch_prctl
Date: Tue,  8 Nov 2016 10:39:50 -0800
Message-Id: <20161108183956.4521-2-khuey@kylehuey.com>
In-Reply-To: <20161108183956.4521-1-khuey@kylehuey.com>
References: <20161108183956.4521-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 arch/x86/kernel/process_64.c | 3 ++-
 arch/x86/um/syscalls_64.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index b3760b3..2718cf9 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -30,16 +30,17 @@
 #include <linux/ptrace.h>
 #include <linux/notifier.h>
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
 #include <linux/prctl.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/ftrace.h>
+#include <linux/syscalls.h>
 
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/fpu/internal.h>
 #include <asm/mmu_context.h>
 #include <asm/prctl.h>
 #include <asm/desc.h>
 #include <asm/proto.h>
@@ -607,17 +608,17 @@ long do_arch_prctl(struct task_struct *task, int code, unsigned long addr)
 	default:
 		ret = -EINVAL;
 		break;
 	}
 
 	return ret;
 }
 
-long sys_arch_prctl(int code, unsigned long addr)
+SYSCALL_DEFINE2(arch_prctl, int, code, unsigned long, addr)
 {
 	return do_arch_prctl(current, code, addr);
 }
 
 unsigned long KSTK_ESP(struct task_struct *task)
 {
 	return task_pt_regs(task)->sp;
 }
diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
index e655227..ab3f7f4 100644
--- a/arch/x86/um/syscalls_64.c
+++ b/arch/x86/um/syscalls_64.c
@@ -1,16 +1,17 @@
 /*
  * Copyright (C) 2003 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Copyright 2003 PathScale, Inc.
  *
  * Licensed under the GPL
  */
 
 #include <linux/sched.h>
+#include <linux/syscalls.h>
 #include <linux/uaccess.h>
 #include <asm/prctl.h> /* XXX This should get the constants from libc */
 #include <os.h>
 
 long arch_prctl(struct task_struct *task, int code, unsigned long __user *addr)
 {
 	unsigned long *ptr = addr, tmp;
 	long ret;
@@ -67,17 +68,17 @@ long arch_prctl(struct task_struct *task, int code, unsigned long __user *addr)
 	case ARCH_GET_GS:
 		ret = put_user(tmp, addr);
 		break;
 	}
 
 	return ret;
 }
 
-long sys_arch_prctl(int code, unsigned long addr)
+SYSCALL_DEFINE2(arch_prctl, int, code, unsigned long, addr)
 {
 	return arch_prctl(current, code, (unsigned long __user *) addr);
 }
 
 void arch_switch_to(struct task_struct *to)
 {
 	if ((to->thread.arch.fs == 0) || (to->mm == NULL))
 		return;

base-commit: e3a00f68e426df24a5fb98956a1bd1b23943aa1e
-- 
2.10.2


