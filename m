Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpCz9-0001aj-Ed for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 13:58:31 -0800
Received: from www.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CpCz8-0001Uh-AF for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 13:58:31 -0800
From: blaisorblade_spam@yahoo.it
Message-Id: <20050113210056.465BEBAB5@zion>
Subject: [uml-devel] [patch 04/11] uml: refuse to run without skas if no tt
	mode in
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 13 Jan 2005 22:00:56 +0100
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>

Return an early error message when no TT support is compiled in and no SKAS
support is detected.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/process.c |   35 ++++++++++++++++++++--------
 linux-2.6.11-paolo/arch/um/kernel/um_arch.c |   10 +++++++-
 2 files changed, 35 insertions(+), 10 deletions(-)

diff -puN arch/um/kernel/um_arch.c~uml-refuse-to-run-without-skas-if-no-tt-mode-in arch/um/kernel/um_arch.c
--- linux-2.6.11/arch/um/kernel/um_arch.c~uml-refuse-to-run-without-skas-if-no-tt-mode-in	2005-01-13 21:25:17.601847632 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/um_arch.c	2005-01-13 21:25:17.605847024 +0100
@@ -198,7 +198,7 @@ __uml_setup("ncpus=", uml_ncpus_setup,
 );
 #endif
 
-int force_tt = 0;
+static int force_tt = 0;
 
 #if defined(CONFIG_MODE_TT) && defined(CONFIG_MODE_SKAS)
 #define DEFAULT_TT 0
@@ -319,6 +319,14 @@ int linux_main(int argc, char **argv)
 	if(have_root == 0) add_arg(saved_command_line, DEFAULT_COMMAND_LINE);
 
 	mode_tt = force_tt ? 1 : !can_do_skas();
+#ifndef CONFIG_MODE_TT
+	if (mode_tt) {
+		/*Since CONFIG_MODE_TT is #undef'ed, force_tt cannot be 1. So,
+		 * can_do_skas() returned 0, and the message is correct. */
+		printf("Support for TT mode is disabled, and no SKAS support is present on the host.\n");
+		exit(1);
+	}
+#endif
 	uml_start = CHOOSE_MODE_PROC(set_task_sizes_tt, set_task_sizes_skas, 0,
 				     &host_task_size, &task_size);
 
diff -puN arch/um/kernel/process.c~uml-refuse-to-run-without-skas-if-no-tt-mode-in arch/um/kernel/process.c
--- linux-2.6.11/arch/um/kernel/process.c~uml-refuse-to-run-without-skas-if-no-tt-mode-in	2005-01-13 21:25:17.602847480 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/process.c	2005-01-13 21:25:17.605847024 +0100
@@ -375,9 +375,9 @@ void forward_pending_sigio(int target)
 		kill(target, SIGIO);
 }
 
-int can_do_skas(void)
-{
 #ifdef UML_CONFIG_MODE_SKAS
+static inline int check_skas3_ptrace_support(void)
+{
 	struct ptrace_faultinfo fi;
 	void *stack;
 	int pid, n, ret = 1;
@@ -386,29 +386,46 @@ int can_do_skas(void)
 	pid = start_ptraced_child(&stack);
 
 	n = ptrace(PTRACE_FAULTINFO, pid, 0, &fi);
-	if(n < 0){
+	if (n < 0) {
 		if(errno == EIO)
 			printf("not found\n");
-		else printf("No (unexpected errno - %d)\n", errno);
+		else {
+			perror("not found");
+		}
 		ret = 0;
+	} else {
+		printf("found\n");
 	}
-	else printf("found\n");
 
 	init_registers(pid);
 	stop_ptraced_child(pid, stack, 1, 1);
 
+	return(ret);
+}
+
+int can_do_skas(void)
+{
+	int ret = 1;
+
 	printf("Checking for /proc/mm...");
-	if(os_access("/proc/mm", OS_ACC_W_OK) < 0){
+	if (os_access("/proc/mm", OS_ACC_W_OK) < 0) {
 		printf("not found\n");
 		ret = 0;
+		goto out;
+	} else {
+		printf("found\n");
 	}
-	else printf("found\n");
 
-	return(ret);
+	ret = check_skas3_ptrace_support();
+out:
+	return ret;
+}
 #else
+int can_do_skas(void)
+{
 	return(0);
-#endif
 }
+#endif
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
_


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
