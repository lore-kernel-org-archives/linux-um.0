Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcRZ3-000219-EW
 for linux-um@lists.infradead.org; Tue, 10 Nov 2020 11:11:54 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH] um: Fetch registers only for signals which need them
Date: Tue, 10 Nov 2020 11:11:37 +0000
Message-Id: <20201110111137.16117-1-anton.ivanov@cambridgegreys.com>
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

UML userspace fetches siginfo and passes it to signal handlers
in UML. This is needed only for some of the signals, because
key handlers like SIGIO make no use of this variable.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/os-Linux/skas/process.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 4fb877b99dde..8123b1c6b1b5 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -400,7 +400,16 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 		if (WIFSTOPPED(status)) {
 			int sig = WSTOPSIG(status);
 
-			ptrace(PTRACE_GETSIGINFO, pid, 0, (struct siginfo *)&si);
+			switch (sig) {
+			case SIGSEGV:
+			case SIGTRAP:
+			case SIGILL:
+			case SIGBUS:
+			case SIGFPE:
+			case SIGWINCH:
+				ptrace(PTRACE_GETSIGINFO, pid, 0, (struct siginfo *)&si);
+				break;
+			}
 
 			switch (sig) {
 			case SIGSEGV:
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

