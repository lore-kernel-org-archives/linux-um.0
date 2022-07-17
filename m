Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oD1rZ-006QzF-4x
	for linux-um@lists.infradead.org; Sun, 17 Jul 2022 10:51:05 +0000
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v4] um: seed rng using host OS rng
Date: Sun, 17 Jul 2022 12:50:51 +0200
Message-Id: <20220717105051.1539173-1-Jason@zx2c4.com>
In-Reply-To: <20220717084652.1525087-1-Jason@zx2c4.com>
References: <20220717084652.1525087-1-Jason@zx2c4.com>
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
To: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, stable@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

UML generally does not provide access to special CPU instructions like
RDRAND, and execution tends to be rather deterministic, with no real
hardware interrupts, making good randomness really very hard, if not
all together impossible. Not only is this a security eyebrow raiser, but
it's also quite annoying when trying to do various pieces of UML-based
automation that takes a long time to boot, if ever.

Fix this by trivially calling getrandom() in the host and using that
seed as "bootloader randomness", which initializes the rng immediately
at UML boot.

The old behavior can be restored the same way as on any other arch, by
way of CONFIG_TRUST_BOOTLOADER_RANDOMNESS=n or
random.trust_bootloader=0. So seen from that perspective, this just
makes UML act like other archs, which is positive in its own right.

Additionally, wire up arch_get_random_{int,long}() in the same way, so
that reseeds can also make use of the host RNG, controllable by
CONFIG_TRUST_CPU_RANDOMNESS and random.trust_cpu, per usual.

Cc: stable@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Johannes - I need to take this through random.git, because it relies on
some other changes living there. Is that okay with you? -Jason

Changes v3->v4:
- Don't include os.h, per Johannes' suggestion.

 arch/um/include/asm/archrandom.h | 30 ++++++++++++++++++++++++++++++
 arch/um/include/shared/os.h      |  7 +++++++
 arch/um/kernel/um_arch.c         |  8 ++++++++
 arch/um/os-Linux/util.c          |  6 ++++++
 4 files changed, 51 insertions(+)
 create mode 100644 arch/um/include/asm/archrandom.h

diff --git a/arch/um/include/asm/archrandom.h b/arch/um/include/asm/archrandom.h
new file mode 100644
index 000000000000..2f24cb96391d
--- /dev/null
+++ b/arch/um/include/asm/archrandom.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_UM_ARCHRANDOM_H__
+#define __ASM_UM_ARCHRANDOM_H__
+
+#include <linux/types.h>
+
+/* This is from <os.h>, but better not to #include that in a global header here. */
+ssize_t os_getrandom(void *buf, size_t len, unsigned int flags);
+
+static inline bool __must_check arch_get_random_long(unsigned long *v)
+{
+	return os_getrandom(v, sizeof(*v), 0) == sizeof(*v);
+}
+
+static inline bool __must_check arch_get_random_int(unsigned int *v)
+{
+	return os_getrandom(v, sizeof(*v), 0) == sizeof(*v);
+}
+
+static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
+{
+	return false;
+}
+
+static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
+{
+	return false;
+}
+
+#endif
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index fafde1d5416e..0df646c6651e 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -11,6 +11,12 @@
 #include <irq_user.h>
 #include <longjmp.h>
 #include <mm_id.h>
+/* This is to get size_t */
+#ifndef __UM_HOST__
+#include <linux/types.h>
+#else
+#include <sys/types.h>
+#endif
 
 #define CATCH_EINTR(expr) while ((errno = 0, ((expr) < 0)) && (errno == EINTR))
 
@@ -243,6 +249,7 @@ extern void stack_protections(unsigned long address);
 extern int raw(int fd);
 extern void setup_machinename(char *machine_out);
 extern void setup_hostinfo(char *buf, int len);
+extern ssize_t os_getrandom(void *buf, size_t len, unsigned int flags);
 extern void os_dump_core(void) __attribute__ ((noreturn));
 extern void um_early_printk(const char *s, unsigned int n);
 extern void os_fix_helper_signals(void);
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 0760e24f2eba..74f3efd96bd4 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -16,6 +16,7 @@
 #include <linux/sched/task.h>
 #include <linux/kmsg_dump.h>
 #include <linux/suspend.h>
+#include <linux/random.h>
 
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
@@ -406,6 +407,8 @@ int __init __weak read_initrd(void)
 
 void __init setup_arch(char **cmdline_p)
 {
+	u8 rng_seed[32];
+
 	stack_protections((unsigned long) &init_thread_info);
 	setup_physmem(uml_physmem, uml_reserved, physmem_size, highmem);
 	mem_total_pages(physmem_size, iomem_size, highmem);
@@ -416,6 +419,11 @@ void __init setup_arch(char **cmdline_p)
 	strlcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 	setup_hostinfo(host_info, sizeof host_info);
+
+	if (os_getrandom(rng_seed, sizeof(rng_seed), 0) == sizeof(rng_seed)) {
+		add_bootloader_randomness(rng_seed, sizeof(rng_seed));
+		memzero_explicit(rng_seed, sizeof(rng_seed));
+	}
 }
 
 void __init check_bugs(void)
diff --git a/arch/um/os-Linux/util.c b/arch/um/os-Linux/util.c
index 41297ec404bf..fc0f2a9dee5a 100644
--- a/arch/um/os-Linux/util.c
+++ b/arch/um/os-Linux/util.c
@@ -14,6 +14,7 @@
 #include <sys/wait.h>
 #include <sys/mman.h>
 #include <sys/utsname.h>
+#include <sys/random.h>
 #include <init.h>
 #include <os.h>
 
@@ -96,6 +97,11 @@ static inline void __attribute__ ((noreturn)) uml_abort(void)
 			exit(127);
 }
 
+ssize_t os_getrandom(void *buf, size_t len, unsigned int flags)
+{
+	return getrandom(buf, len, flags);
+}
+
 /*
  * UML helper threads must not handle SIGWINCH/INT/TERM
  */
-- 
2.35.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

