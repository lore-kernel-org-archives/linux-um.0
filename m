Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf5Yn-0001Y7-By
 for linux-um@lists.infradead.org; Thu, 03 Jan 2019 16:09:31 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH] um: Try to avoid kmalloc in signal handling
Date: Thu,  3 Jan 2019 16:09:17 +0000
Message-Id: <20190103160917.10217-1-anton.ivanov@cambridgegreys.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: richard@nod.at, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Signal handling (which maps to interrupt handling in UML) needs
to pass current registers to the relevant handlers and was
allocating a structure for that using kmalloc. It is possible
to avoid this kmalloc by using a small "signal register stack".
A depth of 4 suffices 99%+ of the time. If it is exceeded
further sets of registers are allocated as before via kmalloc.

The end result is >10% performance increase in networking
as measured by iperf.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/os-Linux/signal.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index bf0acb8aad8b..21536581ab57 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -29,14 +29,24 @@ void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
 	[SIGALRM]	= timer_handler
 };
 
+static int reg_depth;
+
+static struct uml_pt_regs reg_file[4];
+#define REG_SWITCH_TO_KMALLOC_DEPTH 3
+
 static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 {
 	struct uml_pt_regs *r;
 	int save_errno = errno;
 
-	r = uml_kmalloc(sizeof(struct uml_pt_regs), UM_GFP_ATOMIC);
-	if (!r)
-		panic("out of memory");
+	if (reg_depth >= REG_SWITCH_TO_KMALLOC_DEPTH) {
+		r = uml_kmalloc(sizeof(struct uml_pt_regs), UM_GFP_ATOMIC);
+		if (!r)
+			panic("out of memory");
+	} else {
+		r = &reg_file[reg_depth];
+	}
+	reg_depth++;
 
 	r->is_user = 0;
 	if (sig == SIGSEGV) {
@@ -53,7 +63,9 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 
 	errno = save_errno;
 
-	free(r);
+	reg_depth--;
+	if (reg_depth >= REG_SWITCH_TO_KMALLOC_DEPTH)
+		free(r);
 }
 
 /*
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

