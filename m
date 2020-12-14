Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kosNH-0006Kj-U8
 for linux-um@lists.infradead.org; Mon, 14 Dec 2020 18:15:09 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH v5 1/4] um: Add support for host CPU flags and alignment
Date: Mon, 14 Dec 2020 18:14:56 +0000
Message-Id: <20201214181459.11096-2-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20201214181459.11096-1-anton.ivanov@cambridgegreys.com>
References: <20201214181459.11096-1-anton.ivanov@cambridgegreys.com>
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

1. Reflect host cpu flags into the UML instance so they can
be used to select the correct implementations for xor, crypto, etc.

2. Reflect host cache alignment into UML instance. This is
important when running 32 bit on a 64 bit host as 32 bit by
default aligns to 32 while the actual alignment should be 64.
Ditto for some Xeons which align at 128.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/Kconfig                         |  3 ++
 arch/um/include/asm/processor-generic.h |  8 +++++
 arch/um/include/shared/os.h             |  3 ++
 arch/um/kernel/Makefile                 | 13 +++++--
 arch/um/kernel/um_arch.c                | 48 ++++++++++++++++++++++---
 arch/um/os-Linux/start_up.c             | 32 +++++++++++++++++
 6 files changed, 101 insertions(+), 6 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 4b799fad8b48..6d707122e8d8 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -61,6 +61,9 @@ config NR_CPUS
 	range 1 1
 	default 1
 
+config ARCH_HAS_CACHE_LINE_SIZE
+	def_bool y
+
 source "arch/$(HEADER_ARCH)/um/Kconfig"
 
 config MAY_HAVE_RUNTIME_DEPS
diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index afd9b267cf81..b5cf0ed116d9 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -16,6 +16,8 @@ struct task_struct;
 
 #include <linux/prefetch.h>
 
+#include <asm/cpufeatures.h>
+
 struct mm_struct;
 
 struct thread_struct {
@@ -90,12 +92,18 @@ extern void start_thread(struct pt_regs *regs, unsigned long entry,
 struct cpuinfo_um {
 	unsigned long loops_per_jiffy;
 	int ipi_pipe[2];
+	int cache_alignment;
+	union {
+		__u32		x86_capability[NCAPINTS + NBUGINTS];
+		unsigned long	x86_capability_alignment;
+	};
 };
 
 extern struct cpuinfo_um boot_cpu_data;
 
 #define cpu_data (&boot_cpu_data)
 #define current_cpu_data boot_cpu_data
+#define cache_line_size()	(boot_cpu_data.cache_alignment)
 
 #define KSTK_REG(tsk, reg) get_thread_reg(reg, &tsk->thread.switch_buf)
 extern unsigned long get_wchan(struct task_struct *p);
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index f467d28fc0b4..c73be207fbe5 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -187,6 +187,9 @@ int os_poll(unsigned int n, const int *fds);
 extern void os_early_checks(void);
 extern void os_check_bugs(void);
 extern void check_host_supports_tls(int *supports_tls, int *tls_min);
+extern void get_host_cpu_features(
+	void (*flags_helper_func)(char *line),
+	void (*cache_helper_func)(char *line));
 
 /* mem.c */
 extern int create_mem_file(unsigned long long len);
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 5aa882011e04..64f82652db2e 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -17,7 +17,7 @@ extra-y := vmlinux.lds
 obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	physmem.o process.o ptrace.o reboot.o sigio.o \
 	signal.o syscall.o sysrq.o time.o tlb.o trap.o \
-	um_arch.o umid.o maccess.o kmsg_dump.o skas/
+	um_arch.o umid.o maccess.o kmsg_dump.o capflags.o skas/
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
@@ -29,7 +29,7 @@ USER_OBJS := config.o
 
 include arch/um/scripts/Makefile.rules
 
-targets := config.c config.tmp
+targets := config.c config.tmp capflags.c
 
 # Be careful with the below Sed code - sed is pitfall-rich!
 # We use sed to lower build requirements, for "embedded" builders for instance.
@@ -44,6 +44,15 @@ quiet_cmd_quote1 = QUOTE   $@
 $(obj)/config.c: $(src)/config.c.in $(obj)/config.tmp FORCE
 	$(call if_changed,quote2)
 
+quiet_cmd_mkcapflags = MKCAP   $@
+      cmd_mkcapflags = $(CONFIG_SHELL) $(srctree)/$(src)/../../x86/kernel/cpu/mkcapflags.sh $@ $^
+
+cpufeature = $(src)/../../x86/include/asm/cpufeatures.h
+vmxfeature = $(src)/../../x86/include/asm/vmxfeatures.h
+
+$(obj)/capflags.c: $(cpufeature) $(vmxfeature) $(src)/../../x86/kernel/cpu/mkcapflags.sh FORCE
+	$(call if_changed,mkcapflags)
+
 quiet_cmd_quote2 = QUOTE   $@
       cmd_quote2 = sed -e '/CONFIG/{'          \
 		  -e 's/"CONFIG"//'            \
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 76b37297b7d4..d6bcaa01633d 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/mm.h>
+#include <linux/ctype.h>
 #include <linux/module.h>
 #include <linux/seq_file.h>
 #include <linux/string.h>
@@ -15,6 +16,7 @@
 #include <linux/kmsg_dump.h>
 
 #include <asm/processor.h>
+#include <asm/cpufeature.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <as-layout.h>
@@ -48,9 +50,13 @@ static void __init add_arg(char *arg)
  */
 struct cpuinfo_um boot_cpu_data = {
 	.loops_per_jiffy	= 0,
-	.ipi_pipe		= { -1, -1 }
+	.ipi_pipe		= { -1, -1 },
+	.cache_alignment	= L1_CACHE_BYTES,
+	.x86_capability		= { 0 }
 };
 
+EXPORT_SYMBOL(boot_cpu_data);
+
 union thread_union cpu0_irqstack
 	__section(".data..init_irqstack") =
 		{ .thread_info = INIT_THREAD_INFO(init_task) };
@@ -60,17 +66,25 @@ static char host_info[(__NEW_UTS_LEN + 1) * 5];
 
 static int show_cpuinfo(struct seq_file *m, void *v)
 {
-	int index = 0;
+	int i = 0;
 
-	seq_printf(m, "processor\t: %d\n", index);
+	seq_printf(m, "processor\t: %d\n", i);
 	seq_printf(m, "vendor_id\t: User Mode Linux\n");
 	seq_printf(m, "model name\t: UML\n");
 	seq_printf(m, "mode\t\t: skas\n");
 	seq_printf(m, "host\t\t: %s\n", host_info);
-	seq_printf(m, "bogomips\t: %lu.%02lu\n\n",
+	seq_printf(m, "fpu\t\t: %s\n", cpu_has(&boot_cpu_data, X86_FEATURE_FPU) ? "yes" : "no");
+	seq_printf(m, "flags\t\t:");
+	for (i = 0; i < 32*NCAPINTS; i++)
+		if (cpu_has(&boot_cpu_data, i) && (x86_cap_flags[i] != NULL))
+			seq_printf(m, " %s", x86_cap_flags[i]);
+	seq_printf(m, "\n");
+	seq_printf(m, "cache_alignment\t: %d\n", boot_cpu_data.cache_alignment);
+	seq_printf(m, "bogomips\t: %lu.%02lu\n",
 		   loops_per_jiffy/(500000/HZ),
 		   (loops_per_jiffy/(5000/HZ)) % 100);
 
+
 	return 0;
 }
 
@@ -246,6 +260,30 @@ EXPORT_SYMBOL(end_iomem);
 
 #define MIN_VMALLOC (32 * 1024 * 1024)
 
+static void parse_host_cpu_flags(char *line)
+{
+	int i;
+	for (i = 0; i < 32*NCAPINTS; i++) {
+		if ((x86_cap_flags[i] != NULL) && strstr(line, x86_cap_flags[i]))
+			set_cpu_cap(&boot_cpu_data, i);;
+	}
+}
+static void parse_cache_line(char *line)
+{
+	long res;
+	char *to_parse = strstr(line, ":");
+	if (to_parse) {
+		to_parse++;
+		while (*to_parse != 0 && isspace(*to_parse)) {
+			to_parse++;
+		}
+		if (kstrtoul(to_parse, 10, &res) == 0 && is_power_of_2(res))
+			boot_cpu_data.cache_alignment = res;
+		else
+			boot_cpu_data.cache_alignment = L1_CACHE_BYTES;
+	}
+}
+
 int __init linux_main(int argc, char **argv)
 {
 	unsigned long avail, diff;
@@ -275,6 +313,8 @@ int __init linux_main(int argc, char **argv)
 	/* OS sanity checks that need to happen before the kernel runs */
 	os_early_checks();
 
+	get_host_cpu_features(parse_host_cpu_flags, parse_cache_line);
+
 	brk_start = (unsigned long) sbrk(0);
 
 	/*
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index f79dc338279e..8a72c99994eb 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -321,6 +321,38 @@ static void __init check_coredump_limit(void)
 		os_info("%llu\n", (unsigned long long)lim.rlim_max);
 }
 
+void  __init get_host_cpu_features(
+		void (*flags_helper_func)(char *line),
+		void (*cache_helper_func)(char *line))
+{
+	FILE *cpuinfo;
+	char *line = NULL;
+	size_t len = 0;
+	int done_parsing = 0;
+
+	cpuinfo = fopen("/proc/cpuinfo", "r");
+	if (cpuinfo == NULL) {
+		os_info("Failed to get host CPU features\n");
+	} else {
+		while ((getline(&line, &len, cpuinfo)) != -1) {
+			if (strstr(line, "flags")) {
+				flags_helper_func(line);
+				done_parsing++;
+			}
+			if (strstr(line, "cache_alignment")) {
+				cache_helper_func(line);
+				done_parsing++;
+			}
+			free(line);
+			line = NULL;
+			if (done_parsing > 1)
+				break;
+		}
+		fclose(cpuinfo);
+	}
+}
+
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

