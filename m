Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1Ybmin-0006yt-On
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Mar 2015 09:08:01 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ybmim-0004jh-43
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Mar 2015 09:08:01 +0000
Received: from [217.255.200.183] (helo=localhost.localdomain)
	by www17.your-server.de with esmtpsa
	(TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (Exim 4.80.1)
	(envelope-from <thomas@m3y3r.de>) id 1Ybmif-000533-C0
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Mar 2015 10:07:53 +0100
Message-ID: <1427533657.3940.25.camel@m3y3r.de>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sat, 28 Mar 2015 10:07:37 +0100
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
Subject: [uml-devel] [PATCH v4 2/2] um: add a kmsg_dumper
To: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>


Add a kmsg_dumper, that dumps the kmsg buffer to stdout, when no console
is available. This an enables the printing of early panic() calls
triggered in uml_postsetup().
When a panic() call happens so early in the UML kernel no
earlyprintk/console is available yet, but with a kmsg_dumper in place
the kernel message buffer will be outputted to the user, to give a
better hint, of what the failure was.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 arch/um/kernel/Makefile    |  2 +-
 arch/um/kernel/kmsg_dump.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 arch/um/kernel/um_arch.c   |  2 ++
 3 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 arch/um/kernel/kmsg_dump.c

diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 2d840a0..3345e71 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -13,7 +13,7 @@ clean-files :=
 obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	physmem.o process.o ptrace.o reboot.o sigio.o \
 	signal.o smp.o syscall.o sysrq.o time.o tlb.o trap.o \
-	um_arch.o umid.o maccess.o skas/
+	um_arch.o umid.o maccess.o kmsg_dump.o skas/
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
new file mode 100644
index 0000000..407d492
--- /dev/null
+++ b/arch/um/kernel/kmsg_dump.c
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
+__uml_postsetup(kmsg_dumper_stdout_init);
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index ea92aa1..f1efeee 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -11,6 +11,7 @@
 #include <linux/string.h>
 #include <linux/utsname.h>
 #include <linux/sched.h>
+#include <linux/kmsg_dump.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/sections.h>
@@ -234,6 +235,7 @@ static void __init uml_postsetup(void)
 static int panic_exit(struct notifier_block *self, unsigned long unused1,
 		      void *unused2)
 {
+	kmsg_dump(KMSG_DUMP_PANIC);
 	bust_spinlocks(1);
 	bust_spinlocks(0);
 	uml_exitcode = 1;
-- 
2.1.0





------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

