Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNFdy-007SO7-H6
	for linux-um@lists.infradead.org; Sun, 14 Aug 2022 15:35:16 +0000
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 21/31] um: add "noreboot" command line option for PANIC_TIMEOUT=-1 setups
Date: Sun, 14 Aug 2022 11:34:21 -0400
Message-Id: <20220814153431.2379231-21-sashal@kernel.org>
In-Reply-To: <20220814153431.2379231-1-sashal@kernel.org>
References: <20220814153431.2379231-1-sashal@kernel.org>
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
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, Richard Weinberger <richard@nod.at>, Sasha Levin <sashal@kernel.org>, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, linux@roeck-us.net, linux-um@lists.infradead.org

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

[ Upstream commit dda520d07b95072a0b63f6c52a8eb566d08ea897 ]

QEMU has a -no-reboot option, which halts instead of reboots when the
guest asks to reboot. This is invaluable when used with
CONFIG_PANIC_TIMEOUT=-1 (and panic_on_warn), because it allows panics
and warnings to be caught immediately in CI. Implement this in UML too,
by way of a basic setup param.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/os-Linux/skas/process.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 94a7c4125ebc..eecde73b2e78 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -5,6 +5,7 @@
  */
 
 #include <stdlib.h>
+#include <stdbool.h>
 #include <unistd.h>
 #include <sched.h>
 #include <errno.h>
@@ -644,10 +645,24 @@ void halt_skas(void)
 	UML_LONGJMP(&initial_jmpbuf, INIT_JMP_HALT);
 }
 
+static bool noreboot;
+
+static int __init noreboot_cmd_param(char *str, int *add)
+{
+	noreboot = true;
+	return 0;
+}
+
+__uml_setup("noreboot", noreboot_cmd_param,
+"noreboot\n"
+"    Rather than rebooting, exit always, akin to QEMU's -no-reboot option.\n"
+"    This is useful if you're using CONFIG_PANIC_TIMEOUT in order to catch\n"
+"    crashes in CI\n");
+
 void reboot_skas(void)
 {
 	block_signals_trace();
-	UML_LONGJMP(&initial_jmpbuf, INIT_JMP_REBOOT);
+	UML_LONGJMP(&initial_jmpbuf, noreboot ? INIT_JMP_HALT : INIT_JMP_REBOOT);
 }
 
 void __switch_mm(struct mm_id *mm_idp)
-- 
2.35.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

