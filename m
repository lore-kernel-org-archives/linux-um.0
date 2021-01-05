Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from www17.your-server.de ([213.133.104.17])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwl2y-0001Nm-3W
 for linux-um@lists.infradead.org; Tue, 05 Jan 2021 12:02:45 +0000
From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH] um: stdio_console: Make preferred console
Date: Tue,  5 Jan 2021 13:01:28 +0100
Message-Id: <20210105120128.10854-1-thomas@m3y3r.de>
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
To: richard@nod.at
Cc: linux-um@lists.infradead.org, Thomas Meyer <thomas@m3y3r.de>

The addition of the "ttynull" console driver did break the ordering of the
UML stdio console driver.
The UML stdio console driver is added in late_initcall (7), whereby the
ttynull driver is added in device_initcall (6), which always does make the
ttynull driver the default console.

Fix it by explicitly adding the UML stdio console as the preferred console,
in case no 'console=' command line option was specified.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 arch/um/kernel/um_arch.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 31d356b1ffd8..80e2660782a0 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -26,7 +26,8 @@
 #include <mem_user.h>
 #include <os.h>
 
-#define DEFAULT_COMMAND_LINE "root=98:0"
+#define DEFAULT_COMMAND_LINE_ROOT "root=98:0"
+#define DEFAULT_COMMAND_LINE_CONSOLE "console=tty"
 
 /* Changed in add_arg and setup_arch, which run before SMP is started */
 static char __initdata command_line[COMMAND_LINE_SIZE] = { 0 };
@@ -109,7 +110,8 @@ unsigned long end_vm;
 int ncpus = 1;
 
 /* Set in early boot */
-static int have_root __initdata = 0;
+static int have_root __initdata;
+static int have_console __initdata;
 
 /* Set in uml_mem_setup and modified in linux_main */
 long long physmem_size = 32 * 1024 * 1024;
@@ -161,6 +163,17 @@ __uml_setup("debug", no_skas_debug_setup,
 "    this flag is not needed to run gdb on UML in skas mode\n\n"
 );
 
+static int __init uml_console_setup(char *line, int *add)
+{
+	have_console = 1;
+	return 0;
+}
+
+__uml_setup("console=", uml_console_setup,
+"console=<preferred console>\n"
+"    Specify the preferred console output driver\n\n"
+);
+
 static int __init Usage(char *line, int *add)
 {
 	const char **p;
@@ -264,7 +277,10 @@ int __init linux_main(int argc, char **argv)
 			add_arg(argv[i]);
 	}
 	if (have_root == 0)
-		add_arg(DEFAULT_COMMAND_LINE);
+		add_arg(DEFAULT_COMMAND_LINE_ROOT);
+
+	if (have_console == 0)
+		add_arg(DEFAULT_COMMAND_LINE_CONSOLE);
 
 	host_task_size = os_get_top_address();
 	/*
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

