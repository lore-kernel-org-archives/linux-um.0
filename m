Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v16 05/10] x86/arch_prctl: Add do_arch_prctl_common
Date: Mon, 20 Mar 2017 01:16:23 -0700
Message-Id: <20170320081628.18952-6-khuey@kylehuey.com>
In-Reply-To: <20170320081628.18952-1-khuey@kylehuey.com>
References: <20170320081628.18952-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
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
index 4e276f6cb1c1..8d3964fc5f91 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -31,4 +31,7 @@ void x86_report_nx(void);
 
 extern int reboot_force;
 
+long do_arch_prctl_common(struct task_struct *task, int option,
+			  unsigned long cpuid_enabled);
+
 #endif /* _ASM_X86_PROTO_H */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 366db7782fc6..b12e95eceb83 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -545,3 +545,9 @@ unsigned long get_wchan(struct task_struct *p)
 	put_task_stack(p);
 	return ret;
 }
+
+long do_arch_prctl_common(struct task_struct *task, int option,
+			  unsigned long cpuid_enabled)
+{
+	return -EINVAL;
+}
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index e37f764c11cc..d81b0a60a45c 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -626,7 +626,13 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 
 SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 {
-	return do_arch_prctl_64(current, option, arg2);
+	long ret;
+
+	ret = do_arch_prctl_64(current, option, arg2);
+	if (ret == -EINVAL)
+		ret = do_arch_prctl_common(current, option, arg2);
+
+	return ret;
 }
 
 unsigned long KSTK_ESP(struct task_struct *task)
-- 
2.11.0


