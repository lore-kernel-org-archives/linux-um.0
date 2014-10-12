Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1XdITP-00006N-ER
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Oct 2014 12:42:07 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XdITM-0001Km-8j
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Oct 2014 12:42:07 +0000
Received: from [217.255.208.138] (helo=[192.168.2.106])
	by www17.your-server.de with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80.1) (envelope-from <thomas@m3y3r.de>) id 1XdITF-0007u6-Fl
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Oct 2014 14:41:57 +0200
Message-ID: <1413117596.13916.7.camel@localhost.localdomain>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sun, 12 Oct 2014 14:39:57 +0200
Mime-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH v2 2/2] um: add a kmsg_dumper
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>


Add a kmsg_dumper, that dumps the kmsg buffer to stdout, when no
console is available.
This an enables the printing of early panic() calls triggered in
uml_postsetup().

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 arch/um/drivers/ubd_kern.c  |  5 +++--
 arch/um/include/shared/os.h |  1 +
 arch/um/kernel/Makefile     |  2 +-
 arch/um/kernel/kmsg_dump.c  | 44 ++++++++++++++++++++++++++++++++++++++++++++
 arch/um/kernel/um_arch.c    |  2 ++
 arch/um/os-Linux/util.c     | 12 ++++++++++++
 6 files changed, 63 insertions(+), 3 deletions(-)
 create mode 100644 arch/um/kernel/kmsg_dump.c

diff -r ee0ba83fd81e arch/um/kernel/Makefile
--- a/arch/um/kernel/Makefile	Sat Oct 11 18:55:17 2014 +0200
+++ b/arch/um/kernel/Makefile	Sun Oct 12 14:24:54 2014 +0200
@@ -13,7 +13,7 @@
 obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	physmem.o process.o ptrace.o reboot.o sigio.o \
 	signal.o smp.o syscall.o sysrq.o time.o tlb.o trap.o \
-	um_arch.o umid.o maccess.o skas/
+	um_arch.o umid.o maccess.o kmsg_dump.o skas/
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
diff -r ee0ba83fd81e arch/um/kernel/kmsg_dump.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/arch/um/kernel/kmsg_dump.c	Sun Oct 12 14:24:54 2014 +0200
@@ -0,0 +1,43 @@
+#include <linux/kmsg_dump.h>
+#include <linux/console.h>
+#include <shared/init.h>
+#include <shared/kern.h>
+#include <os.h>
+
+static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
+				enum kmsg_dump_reason reason)
+{
+	static char line[1024];
+
+	size_t len = 0;
+	bool con_available = false;
+
+	/* only dump kmsg when no console is available */
+	if (!console_trylock())
+		return;
+
+	if (console_drivers != NULL)
+		con_available = true;
+
+	console_unlock();
+
+	if (con_available == true)
+		return;
+
+	printf("kmsg_dump:\n");
+	while (kmsg_dump_get_line(dumper, true, line, sizeof(line), &len)) {
+		line[len] = '\0';
+		printf("%s", line);
+	}
+}
+
+static struct kmsg_dumper kmsg_dumper = {
+	.dump = kmsg_dumper_stdout
+};
+
+int __init kmsg_dumper_stdout_init(void)
+{
+	return kmsg_dump_register(&kmsg_dumper);
+}
+
+__uml_initcall(kmsg_dumper_stdout_init);
diff -r ee0ba83fd81e arch/um/kernel/um_arch.c
--- a/arch/um/kernel/um_arch.c	Sat Oct 11 18:55:17 2014 +0200
+++ b/arch/um/kernel/um_arch.c	Sun Oct 12 14:24:54 2014 +0200
@@ -11,6 +11,7 @@
 #include <linux/string.h>
 #include <linux/utsname.h>
 #include <linux/sched.h>
+#include <linux/kmsg_dump.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/sections.h>
@@ -234,6 +235,7 @@
 static int panic_exit(struct notifier_block *self, unsigned long unused1,
 		      void *unused2)
 {
+	kmsg_dump(KMSG_DUMP_PANIC);
 	bust_spinlocks(1);
 	bust_spinlocks(0);
 	uml_exitcode = 1;




------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://p.sf.net/sfu/Zoho
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

