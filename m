Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1W2MP2-0003VP-97
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jan 2014 14:52:40 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1W2MP0-0002i2-EE
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jan 2014 14:52:40 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun, 12 Jan 2014 15:52:21 +0100
Message-Id: <1389538341-31383-1-git-send-email-richard@nod.at>
In-Reply-To: <20140112120305.GA13076@gmail.com>
References: <20140112120305.GA13076@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH] um, x86: Fix vDSO build
To: mingo@redhat.com
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-tip-commits@vger.kernel.org, Richard Weinberger <richard@nod.at>, paul.gortmaker@windriver.com, hpa@zytor.com, tglx@linutronix.de

Commit "x86: Delete non-required instances of include <linux/init.h>"
broke the UML build.

arch/x86/um/vdso/vdso.S: Assembler messages:
arch/x86/um/vdso/vdso.S:2: Error: no such instruction: `__initdata'
arch/x86/um/vdso/vdso.S:9: Error: no such instruction: `__finit'

UML's vDSO needs linux/init.h.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/x86/um/vdso/vdso.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/um/vdso/vdso.S b/arch/x86/um/vdso/vdso.S
index 4b4bd4c..1cb468a 100644
--- a/arch/x86/um/vdso/vdso.S
+++ b/arch/x86/um/vdso/vdso.S
@@ -1,3 +1,4 @@
+#include <linux/init.h>
 
 __INITDATA
 
-- 
1.8.1.4


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today.
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

