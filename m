Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knmUn-0008Fi-8x
 for linux-um@lists.infradead.org; Fri, 11 Dec 2020 17:46:22 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH v4 2/7] um: enable the use of optimized xor routines in UML
Date: Fri, 11 Dec 2020 17:45:54 +0000
Message-Id: <20201211174559.26010-3-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20201211174559.26010-1-anton.ivanov@cambridgegreys.com>
References: <20201211174559.26010-1-anton.ivanov@cambridgegreys.com>
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
Cc: richard@nod.at, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

This patch enable the use of optimized xor routines from the x86
tree as well as supply the necessary macros for them to be used in
UML.

The macros supply several "fake" flags and definitions to allow
using the x86 files "as is".

This patchset implements only the flags needed for the optimized
strings.h, xor.h and checksum.h implementations instead of
trying to copy the entire x86 flags environment.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/include/asm/cpufeature.h        | 17 +++++++++++++
 arch/um/include/asm/cpufeatures.h       | 15 ++++++++++++
 arch/um/include/asm/fpu/api.h           | 14 +++++++++++
 arch/um/include/asm/processor-generic.h |  3 +++
 arch/um/include/asm/xor-x86.h           |  1 +
 arch/um/include/asm/xor.h               | 17 ++++++++++++-
 arch/um/include/asm/xor_32.h            |  1 +
 arch/um/include/asm/xor_64.h            |  1 +
 arch/um/include/asm/xor_avx.h           |  1 +
 arch/um/include/shared/os.h             |  1 +
 arch/um/kernel/um_arch.c                | 17 +++++++++++--
 arch/um/os-Linux/start_up.c             | 32 +++++++++++++++++++++++++
 12 files changed, 117 insertions(+), 3 deletions(-)
 create mode 100644 arch/um/include/asm/cpufeature.h
 create mode 100644 arch/um/include/asm/cpufeatures.h
 create mode 100644 arch/um/include/asm/fpu/api.h
 create mode 120000 arch/um/include/asm/xor-x86.h
 create mode 120000 arch/um/include/asm/xor_32.h
 create mode 120000 arch/um/include/asm/xor_64.h
 create mode 120000 arch/um/include/asm/xor_avx.h

diff --git a/arch/um/include/asm/cpufeature.h b/arch/um/include/asm/cpufeature.h
new file mode 100644
index 000000000000..19a2394d03a4
--- /dev/null
+++ b/arch/um/include/asm/cpufeature.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_UM_CPUFEATURE_H
+#define _ASM_UM_CPUFEATURE_H
+
+#include <asm/asm.h>
+#include <linux/bitops.h>
+#include <asm/processor-generic.h>
+#include <asm/cpufeatures.h>
+
+
+const char *host_cpu_feature_names[] = {"mmx", "xmm", "avx", "osxsave", "rep_good", "erms", "xmm2"};
+#define MAX_UM_CPU_FEATURES ARRAY_SIZE(host_cpu_feature_names)
+
+
+#define boot_cpu_has(bit)	(boot_cpu_data.host_features & bit)
+
+#endif /* _ASM_UM_CPUFEATURE_H */
diff --git a/arch/um/include/asm/cpufeatures.h b/arch/um/include/asm/cpufeatures.h
new file mode 100644
index 000000000000..d02da39b039d
--- /dev/null
+++ b/arch/um/include/asm/cpufeatures.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_UM_CPUFEATURES_H
+#define _ASM_UM_CPUFEATURES_H
+
+/* Fake x86 Features of actual interest to UML */
+
+#define X86_FEATURE_MMX (1 << 0)
+#define X86_FEATURE_XMM (1 << 1)
+#define X86_FEATURE_AVX (1 << 2)
+#define X86_FEATURE_OSXSAVE (1 << 3)
+#define X86_FEATURE_REP_GOOD (1 << 4)
+#define X86_FEATURE_ERMS (1 << 5)
+#define X86_FEATURE_XMM2 (1 << 6)
+
+#endif /* _ASM_UM_CPUFEATURES_H */
diff --git a/arch/um/include/asm/fpu/api.h b/arch/um/include/asm/fpu/api.h
new file mode 100644
index 000000000000..2873a6f0105d
--- /dev/null
+++ b/arch/um/include/asm/fpu/api.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _ASM_UM_FPU_API_H
+#define _ASM_UM_FPU_API_H
+
+/* Copyright (c) 2020 Cambridge Greys Ltd
+ * Copyright (c) 2020 Red Hat Inc.
+ * A set of "dummy" defines to allow the direct inclusion
+ * of x86 optimized copy, xor, etc routines into the
+ * UML code tree. */
+
+#define kernel_fpu_begin() (void)0
+#define kernel_fpu_end() (void)0
+
+#endif
diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index afd9b267cf81..b8bcddbb1898 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -90,6 +90,9 @@ extern void start_thread(struct pt_regs *regs, unsigned long entry,
 struct cpuinfo_um {
 	unsigned long loops_per_jiffy;
 	int ipi_pipe[2];
+	/* There is only a small set of x86 features we are interested
+	 * in for now */
+	unsigned long host_features;
 };
 
 extern struct cpuinfo_um boot_cpu_data;
diff --git a/arch/um/include/asm/xor-x86.h b/arch/um/include/asm/xor-x86.h
new file mode 120000
index 000000000000..beff7de6890d
--- /dev/null
+++ b/arch/um/include/asm/xor-x86.h
@@ -0,0 +1 @@
+../../../x86/include/asm/xor.h
\ No newline at end of file
diff --git a/arch/um/include/asm/xor.h b/arch/um/include/asm/xor.h
index 36b33d62a35d..18bcb5b6189d 100644
--- a/arch/um/include/asm/xor.h
+++ b/arch/um/include/asm/xor.h
@@ -1,7 +1,22 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#include <asm-generic/xor.h>
+#ifndef _ASM_UM_XOR_H
+#define _ASM_UM_XOR_H
+
+#ifdef CONFIG_64BIT
+#undef CONFIG_X86_32
+#else
+#define CONFIG_X86_32 1
+#endif
+
+#include <asm/cpufeature.h>
+#include <asm/xor-x86.h>
 #include <linux/time-internal.h>
 
+#ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
+#undef XOR_SELECT_TEMPLATE
 /* pick an arbitrary one - measuring isn't possible with inf-cpu */
 #define XOR_SELECT_TEMPLATE(x)	\
 	(time_travel_mode == TT_MODE_INFCPU ? &xor_block_8regs : NULL)
+#endif
+
+#endif
diff --git a/arch/um/include/asm/xor_32.h b/arch/um/include/asm/xor_32.h
new file mode 120000
index 000000000000..8a0894e996d7
--- /dev/null
+++ b/arch/um/include/asm/xor_32.h
@@ -0,0 +1 @@
+../../../x86/include/asm/xor_32.h
\ No newline at end of file
diff --git a/arch/um/include/asm/xor_64.h b/arch/um/include/asm/xor_64.h
new file mode 120000
index 000000000000..b8d346c516bf
--- /dev/null
+++ b/arch/um/include/asm/xor_64.h
@@ -0,0 +1 @@
+../../../x86/include/asm/xor_64.h
\ No newline at end of file
diff --git a/arch/um/include/asm/xor_avx.h b/arch/um/include/asm/xor_avx.h
new file mode 120000
index 000000000000..370ded122095
--- /dev/null
+++ b/arch/um/include/asm/xor_avx.h
@@ -0,0 +1 @@
+../../../x86/include/asm/xor_avx.h
\ No newline at end of file
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index f467d28fc0b4..c2ff855af603 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -187,6 +187,7 @@ int os_poll(unsigned int n, const int *fds);
 extern void os_early_checks(void);
 extern void os_check_bugs(void);
 extern void check_host_supports_tls(int *supports_tls, int *tls_min);
+extern unsigned long check_host_cpu_features(const char **feature_names, int n);
 
 /* mem.c */
 extern int create_mem_file(unsigned long long len);
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 76b37297b7d4..b7dfc4fcc130 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -15,6 +15,7 @@
 #include <linux/kmsg_dump.h>
 
 #include <asm/processor.h>
+#include <asm/cpufeature.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <as-layout.h>
@@ -48,9 +49,12 @@ static void __init add_arg(char *arg)
  */
 struct cpuinfo_um boot_cpu_data = {
 	.loops_per_jiffy	= 0,
-	.ipi_pipe		= { -1, -1 }
+	.ipi_pipe		= { -1, -1 },
+	.host_features		= 0
 };
 
+EXPORT_SYMBOL(boot_cpu_data);
+
 union thread_union cpu0_irqstack
 	__section(".data..init_irqstack") =
 		{ .thread_info = INIT_THREAD_INFO(init_task) };
@@ -67,9 +71,15 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, "model name\t: UML\n");
 	seq_printf(m, "mode\t\t: skas\n");
 	seq_printf(m, "host\t\t: %s\n", host_info);
-	seq_printf(m, "bogomips\t: %lu.%02lu\n\n",
+	seq_printf(m, "bogomips\t: %lu.%02lu\n",
 		   loops_per_jiffy/(500000/HZ),
 		   (loops_per_jiffy/(5000/HZ)) % 100);
+	seq_printf(m, "flags\t\t:");
+	for (index = 0; index < MAX_UM_CPU_FEATURES; index++) {
+		if (boot_cpu_data.host_features & (1 << index))
+			seq_printf(m, " %s", host_cpu_feature_names[index]);
+	}
+	seq_printf(m, "\n\n");
 
 	return 0;
 }
@@ -275,6 +285,9 @@ int __init linux_main(int argc, char **argv)
 	/* OS sanity checks that need to happen before the kernel runs */
 	os_early_checks();
 
+	boot_cpu_data.host_features =
+		check_host_cpu_features(host_cpu_feature_names, MAX_UM_CPU_FEATURES);
+
 	brk_start = (unsigned long) sbrk(0);
 
 	/*
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index f79dc338279e..be884ed86b30 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -321,6 +321,38 @@ static void __init check_coredump_limit(void)
 		os_info("%llu\n", (unsigned long long)lim.rlim_max);
 }
 
+unsigned long  __init check_host_cpu_features(const char **feature_names, int n)
+{
+	FILE *cpuinfo;
+	char *line = NULL;
+	size_t len = 0;
+	int i;
+	bool done_parsing = false;
+	unsigned long result = 0;
+
+	cpuinfo = fopen("/proc/cpuinfo", "r");
+	if (cpuinfo == NULL) {
+		os_info("Failed to get host CPU features\n");
+	} else {
+		while ((getline(&line, &len, cpuinfo)) != -1) {
+			if (strstr(line, "flags")) {
+				for (i = 0; i < n; i++) {
+					if (strstr(line, feature_names[i])) {
+						result |= (1 << i);
+					}
+				}
+				done_parsing = true;
+			}
+			free(line);
+			line = NULL;
+			if (done_parsing)
+				break;
+		}
+		fclose(cpuinfo);
+	}
+	return result;
+}
+
 void __init os_early_checks(void)
 {
 	int pid;
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

