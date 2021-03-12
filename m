Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKjWX-00BkwE-HP
 for linux-um@lists.infradead.org; Fri, 12 Mar 2021 15:16:23 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH v7 1/3] um: Add support for host CPU flags and alignment
Date: Fri, 12 Mar 2021 15:16:07 +0000
Message-Id: <20210312151609.24745-2-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20210312151609.24745-1-anton.ivanov@cambridgegreys.com>
References: <20210312151609.24745-1-anton.ivanov@cambridgegreys.com>
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
 arch/um/Kconfig                         |   3 +
 arch/um/include/asm/cpufeature.h        | 157 ++++++++++++++++++++++++
 arch/um/include/asm/processor-generic.h |   8 ++
 arch/um/include/shared/os.h             |   3 +
 arch/um/kernel/Makefile                 |  13 +-
 arch/um/kernel/um_arch.c                |  48 +++++++-
 arch/um/os-Linux/start_up.c             |  32 +++++
 7 files changed, 258 insertions(+), 6 deletions(-)
 create mode 100644 arch/um/include/asm/cpufeature.h

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index c3030db3325f..2c044cfe8130 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -60,6 +60,9 @@ config NR_CPUS
 	range 1 1
 	default 1
 
+config ARCH_HAS_CACHE_LINE_SIZE
+	def_bool y
+
 source "arch/$(HEADER_ARCH)/um/Kconfig"
 
 config MAY_HAVE_RUNTIME_DEPS
diff --git a/arch/um/include/asm/cpufeature.h b/arch/um/include/asm/cpufeature.h
new file mode 100644
index 000000000000..19cd7ed6ec3c
--- /dev/null
+++ b/arch/um/include/asm/cpufeature.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_UM_CPUFEATURE_H
+#define _ASM_UM_CPUFEATURE_H
+
+#include <asm/processor.h>
+
+#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
+
+#include <asm/asm.h>
+#include <linux/bitops.h>
+
+extern const char * const x86_cap_flags[NCAPINTS*32];
+extern const char * const x86_power_flags[32];
+#define X86_CAP_FMT "%s"
+#define x86_cap_flag(flag) x86_cap_flags[flag]
+
+/*
+ * In order to save room, we index into this array by doing
+ * X86_BUG_<name> - NCAPINTS*32.
+ */
+extern const char * const x86_bug_flags[NBUGINTS*32];
+
+#define test_cpu_cap(c, bit)						\
+	 test_bit(bit, (unsigned long *)((c)->x86_capability))
+
+/*
+ * There are 32 bits/features in each mask word.  The high bits
+ * (selected with (bit>>5) give us the word number and the low 5
+ * bits give us the bit/feature number inside the word.
+ * (1UL<<((bit)&31) gives us a mask for the feature_bit so we can
+ * see if it is set in the mask word.
+ */
+#define CHECK_BIT_IN_MASK_WORD(maskname, word, bit)	\
+	(((bit)>>5)==(word) && (1UL<<((bit)&31) & maskname##word ))
+
+#define cpu_has(c, bit)							\
+	 test_cpu_cap(c, bit)
+
+#define this_cpu_has(bit)						\
+	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
+	 x86_this_cpu_test_bit(bit,					\
+		(unsigned long __percpu *)&cpu_info.x86_capability))
+
+/*
+ * This macro is for detection of features which need kernel
+ * infrastructure to be used.  It may *not* directly test the CPU
+ * itself.  Use the cpu_has() family if you want true runtime
+ * testing of CPU features, like in hypervisor code where you are
+ * supporting a possible guest feature where host support for it
+ * is not relevant.
+ */
+#define cpu_feature_enabled(bit)	\
+	(__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0 : static_cpu_has(bit))
+
+#define boot_cpu_has(bit)	cpu_has(&boot_cpu_data, bit)
+
+#define set_cpu_cap(c, bit)	set_bit(bit, (unsigned long *)((c)->x86_capability))
+
+extern void setup_clear_cpu_cap(unsigned int bit);
+
+#define setup_force_cpu_cap(bit) do { \
+	set_cpu_cap(&boot_cpu_data, bit);	\
+	set_bit(bit, (unsigned long *)cpu_caps_set);	\
+} while (0)
+
+#define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
+
+#if defined(__clang__) && !defined(CONFIG_CC_HAS_ASM_GOTO)
+
+/*
+ * Workaround for the sake of BPF compilation which utilizes kernel
+ * headers, but clang does not support ASM GOTO and fails the build.
+ */
+#ifndef __BPF_TRACING__
+#warning "Compiler lacks ASM_GOTO support. Add -D __BPF_TRACING__ to your compiler arguments"
+#endif
+
+#define static_cpu_has(bit)            boot_cpu_has(bit)
+
+#else
+
+/*
+ * Static testing of CPU features. Used the same as boot_cpu_has(). It
+ * statically patches the target code for additional performance. Use
+ * static_cpu_has() only in fast paths, where every cycle counts. Which
+ * means that the boot_cpu_has() variant is already fast enough for the
+ * majority of cases and you should stick to using it as it is generally
+ * only two instructions: a RIP-relative MOV and a TEST.
+ */
+static __always_inline bool _static_cpu_has(u16 bit)
+{
+	asm_volatile_goto("1: jmp 6f\n"
+		 "2:\n"
+		 ".skip -(((5f-4f) - (2b-1b)) > 0) * "
+			 "((5f-4f) - (2b-1b)),0x90\n"
+		 "3:\n"
+		 ".section .altinstructions,\"a\"\n"
+		 " .long 1b - .\n"		/* src offset */
+		 " .long 4f - .\n"		/* repl offset */
+		 " .word %P[always]\n"		/* always replace */
+		 " .byte 3b - 1b\n"		/* src len */
+		 " .byte 5f - 4f\n"		/* repl len */
+		 " .byte 3b - 2b\n"		/* pad len */
+		 ".previous\n"
+		 ".section .altinstr_replacement,\"ax\"\n"
+		 "4: jmp %l[t_no]\n"
+		 "5:\n"
+		 ".previous\n"
+		 ".section .altinstructions,\"a\"\n"
+		 " .long 1b - .\n"		/* src offset */
+		 " .long 0\n"			/* no replacement */
+		 " .word %P[feature]\n"		/* feature bit */
+		 " .byte 3b - 1b\n"		/* src len */
+		 " .byte 0\n"			/* repl len */
+		 " .byte 0\n"			/* pad len */
+		 ".previous\n"
+		 ".section .altinstr_aux,\"ax\"\n"
+		 "6:\n"
+		 " testb %[bitnum],%[cap_byte]\n"
+		 " jnz %l[t_yes]\n"
+		 " jmp %l[t_no]\n"
+		 ".previous\n"
+		 : : [feature]  "i" (bit),
+		     [always]   "i" (X86_FEATURE_ALWAYS),
+		     [bitnum]   "i" (1 << (bit & 7)),
+		     [cap_byte] "m" (((const char *)boot_cpu_data.x86_capability)[bit >> 3])
+		 : : t_yes, t_no);
+t_yes:
+	return true;
+t_no:
+	return false;
+}
+
+#define static_cpu_has(bit)					\
+(								\
+	__builtin_constant_p(boot_cpu_has(bit)) ?		\
+		boot_cpu_has(bit) :				\
+		_static_cpu_has(bit)				\
+)
+#endif
+
+#define cpu_has_bug(c, bit)		cpu_has(c, (bit))
+#define set_cpu_bug(c, bit)		set_cpu_cap(c, (bit))
+
+#define static_cpu_has_bug(bit)		static_cpu_has((bit))
+#define boot_cpu_has_bug(bit)		cpu_has_bug(&boot_cpu_data, (bit))
+#define boot_cpu_set_bug(bit)		set_cpu_cap(&boot_cpu_data, (bit))
+
+#define MAX_CPU_FEATURES		(NCAPINTS * 32)
+#define cpu_have_feature		boot_cpu_has
+
+#define CPU_FEATURE_TYPEFMT		"x86,ven%04Xfam%04Xmod%04X"
+#define CPU_FEATURE_TYPEVAL		boot_cpu_data.x86_vendor, boot_cpu_data.x86, \
+					boot_cpu_data.x86_model
+
+#endif /* defined(__KERNEL__) && !defined(__ASSEMBLY__) */
+#endif /* _ASM_UM_CPUFEATURE_H */
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
index 13d86f94cf0f..ab5f1859feda 100644
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
index 74e07e748a9b..20cce10bde51 100644
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
@@ -16,6 +17,7 @@
 #include <linux/suspend.h>
 
 #include <asm/processor.h>
+#include <asm/cpufeature.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <as-layout.h>
@@ -50,9 +52,13 @@ static void __init add_arg(char *arg)
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
@@ -62,17 +68,25 @@ static char host_info[(__NEW_UTS_LEN + 1) * 5];
 
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
 
@@ -261,6 +275,30 @@ EXPORT_SYMBOL(end_iomem);
 
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
@@ -297,6 +335,8 @@ int __init linux_main(int argc, char **argv)
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

