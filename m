Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v15 3/9] x86/arch_prctl: Add do_arch_prctl_common
Date: Sat, 11 Mar 2017 11:46:56 -0800
Message-Id: <20170311194702.28754-4-khuey@kylehuey.com>
In-Reply-To: <20170311194702.28754-1-khuey@kylehuey.com>
References: <20170311194702.28754-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Add do_arch_prctl_common() to handle arch_prctls that are not specific to 64
bit mode. Call it from the syscall entry point, but not any of the other
callsites in the kernel, which all want one of the existing 64 bit only
arch_prctls.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 arch/x86/include/asm/proto.h | 3 +++
 arch/x86/kernel/process.c    | 6 ++++++
 arch/x86/kernel/process_64.c | 8 +++++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index f8e9194e100c..99836d9a893a 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -26,9 +26,12 @@ void entry_SYSCALL_compat(void);
 void entry_INT80_compat(void);
 #endif
 
 void x86_configure_nx(void);
 void x86_report_nx(void);
 
 extern int reboot_force;
 
+long do_arch_prctl_common(struct task_struct *task, int code,
+			  unsigned long cpuid_enabled);
+
 #endif /* _ASM_X86_PROTO_H */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 366db7782fc6..25bf542dfcdd 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -540,8 +540,14 @@ unsigned long get_wchan(struct task_struct *p)
 		}
 		fp = READ_ONCE_NOCHECK(*(unsigned long *)fp);
 	} while (count++ < 16 && p->state != TASK_RUNNING);
 
 out:
 	put_task_stack(p);
 	return ret;
 }
+
+long do_arch_prctl_common(struct task_struct *task, int code,
+			  unsigned long cpuid_enabled)
+{
+	return -EINVAL;
+}
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 4c139922c2fb..beec7d70acf2 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -621,15 +621,21 @@ long do_arch_prctl_64(struct task_struct *task, int code, unsigned long arg2)
 		break;
 	}
 
 	return ret;
 }
 
 SYSCALL_DEFINE2(arch_prctl, int, code, unsigned long, arg2)
 {
-	return do_arch_prctl_64(current, code, arg2);
+	long ret;
+
+	ret = do_arch_prctl_64(current, code, arg2);
+	if (ret == -EINVAL)
+		ret = do_arch_prctl_common(current, code, arg2);
+
+	return ret;
 }
 
 unsigned long KSTK_ESP(struct task_struct *task)
 {
 	return task_pt_regs(task)->sp;
 }
-- 
2.11.0


