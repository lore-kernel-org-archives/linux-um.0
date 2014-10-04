Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Message-ID: <542FF203.50907@gmail.com>
Date: Sat, 04 Oct 2014 21:11:31 +0800
From: Chen Gang <gang.chen.5i5j@gmail.com>
MIME-Version: 1.0
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
Subject: [uml-devel] [PATCH] um: kernel: ksyms: Export symbol syscall() for
 fixing modpost issue
To: richard@nod.at, jdike@addtoit.com
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

syscall() is implemented in libc.so/a (e.g. for glibc, in "syscall.o"),
so for normal ".o" files, it is undefined, neither can be found within
kernel wide, so will break modpost.

Since ".o" files is OK, can simply export 'syscall' symbol, let modpost
know about that, then can fix this issue.

The related error (with allmodconfig under um):

    MODPOST 1205 modules
  ERROR: "syscall" [fs/hostfs/hostfs.ko] undefined!

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 arch/um/kernel/ksyms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/kernel/ksyms.c b/arch/um/kernel/ksyms.c
index 543c047..e7780f3 100644
--- a/arch/um/kernel/ksyms.c
+++ b/arch/um/kernel/ksyms.c
@@ -42,3 +42,6 @@ EXPORT_SYMBOL(os_makedev);
 EXPORT_SYMBOL(add_sigio_fd);
 EXPORT_SYMBOL(ignore_sigio_fd);
 EXPORT_SYMBOL(sigio_broken);
+
+extern long int syscall (long int __sysno, ...);
+EXPORT_SYMBOL(syscall);
-- 
1.9.3

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

