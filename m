Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTqx-005UJG-2N
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 15:56:04 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 05/27] um: Make errors to stop ptraced child fatal during
 startup
Date: Wed,  3 Mar 2021 16:55:01 +0100
Message-Id: <20210303155523.124277-6-benjamin@sipsolutions.net>
In-Reply-To: <20210303155523.124277-1-benjamin@sipsolutions.net>
References: <20210303155523.124277-1-benjamin@sipsolutions.net>
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
Cc: Benjamin Berg <benjamin@sipsolutions.net>

For the detection code to check whether SYSEMU_SINGLESTEP works
correctly we needed some error cases while stopping to be non-fatal.
However, at this point stop_ptraced_child must always succeed, and we
can therefore simplify it slightly to exit immediately on error.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/os-Linux/start_up.c | 41 +++++++++++--------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 4f8fbe51fad6..8e6f8c4f3f62 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -112,35 +112,20 @@ static int start_ptraced_child(void)
 	return pid;
 }
 
-/* When testing for SYSEMU support, if it is one of the broken versions, we
- * must just avoid using sysemu, not panic, but only if SYSEMU features are
- * broken.
- * So only for SYSEMU features we test mustpanic, while normal host features
- * must work anyway!
- */
-static int stop_ptraced_child(int pid, int exitcode, int mustexit)
+static void stop_ptraced_child(int pid, int exitcode)
 {
-	int status, n, ret = 0;
+	int status, n;
+
+	if (ptrace(PTRACE_CONT, pid, 0, 0) < 0)
+		fatal_perror("stop_ptraced_child : ptrace failed");
 
-	if (ptrace(PTRACE_CONT, pid, 0, 0) < 0) {
-		perror("stop_ptraced_child : ptrace failed");
-		return -1;
-	}
 	CATCH_EINTR(n = waitpid(pid, &status, 0));
 	if (!WIFEXITED(status) || (WEXITSTATUS(status) != exitcode)) {
 		int exit_with = WEXITSTATUS(status);
-		if (exit_with == 2)
-			non_fatal("check_ptrace : child exited with status 2. "
-				  "\nDisabling SYSEMU support.\n");
-		non_fatal("check_ptrace : child exited with exitcode %d, while "
-			  "expecting %d; status 0x%x\n", exit_with,
-			  exitcode, status);
-		if (mustexit)
-			exit(1);
-		ret = -1;
+		fatal("stop_ptraced_child : child exited with exitcode %d, "
+		      "while expecting %d; status 0x%x\n", exit_with,
+		      exitcode, status);
 	}
-
-	return ret;
 }
 
 static void __init check_sysemu(void)
@@ -185,16 +170,14 @@ static void __init check_sysemu(void)
 			goto fail;
 		}
 	}
-	if (stop_ptraced_child(pid, 0, 0) < 0)
-		goto fail_stopped;
+	stop_ptraced_child(pid, 0);
 
 	os_info("OK\n");
 
 	return;
 
 fail:
-	stop_ptraced_child(pid, 1, 0);
-fail_stopped:
+	stop_ptraced_child(pid, 1);
 	fatal("missing\n");
 }
 
@@ -233,7 +216,7 @@ static void __init check_ptrace(void)
 			break;
 		}
 	}
-	stop_ptraced_child(pid, 0, 1);
+	stop_ptraced_child(pid, 0);
 	os_info("OK\n");
 	check_sysemu();
 }
@@ -280,7 +263,7 @@ void __init os_early_checks(void)
 	pid = start_ptraced_child();
 	if (init_registers(pid))
 		fatal("Failed to initialize default registers");
-	stop_ptraced_child(pid, 1, 1);
+	stop_ptraced_child(pid, 1);
 }
 
 int __init parse_iomem(char *str, int *add)
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

