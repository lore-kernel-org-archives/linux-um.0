Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1bCBVE-0008Vo-6P
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2016 19:57:00 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1bCBVC-0000f6-Vb for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2016 19:57:00 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun, 12 Jun 2016 21:56:43 +0200
Message-Id: <1465761403-26619-2-git-send-email-richard@nod.at>
In-Reply-To: <1465761403-26619-1-git-send-email-richard@nod.at>
References: <1465761403-26619-1-git-send-email-richard@nod.at>
Subject: [uml-devel] [PATCH 2/2] um: Select HAVE_DEBUG_KMEMLEAK
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org

Now we have the infrastructure to support kmemleak.
Enable the HAVE flag.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Kconfig.common | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index cc00134..de562da 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -5,6 +5,7 @@ config UML
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_UID16
 	select HAVE_FUTEX_CMPXCHG if FUTEX
+	select HAVE_DEBUG_KMEMLEAK
 	select GENERIC_IRQ_SHOW
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IO
-- 
2.7.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

