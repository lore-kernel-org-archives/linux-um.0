Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1SKF9g-0001nN-HA
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Apr 2012 20:37:40 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SKF9c-00005d-CS
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Apr 2012 20:37:40 +0000
From: Richard Weinberger <richard@nod.at>
Date: Tue, 17 Apr 2012 22:37:15 +0200
Message-Id: <1334695036-19977-3-git-send-email-richard@nod.at>
In-Reply-To: <1334695036-19977-1-git-send-email-richard@nod.at>
References: <1334695036-19977-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 3/4] um: Remove CONFIG_IRQ_RELEASE_METHOD
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, tglx@linutronix.de, linux-kernel@vger.kernel.org

UML does no longer need CONFIG_IRQ_RELEASE_METHOD.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Kconfig.common |    5 -----
 arch/um/defconfig      |    1 -
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index 20a49ba..43ef890 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -56,11 +56,6 @@ config GENERIC_CLOCKEVENTS
 	bool
 	default y
 
-# Used in kernel/irq/manage.c and include/linux/irq.h
-config IRQ_RELEASE_METHOD
-	bool
-	default y
-
 config HZ
 	int
 	default 100
diff --git a/arch/um/defconfig b/arch/um/defconfig
index fdc97e2..7823ab1 100644
--- a/arch/um/defconfig
+++ b/arch/um/defconfig
@@ -12,7 +12,6 @@ CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_BUG=y
 CONFIG_GENERIC_CLOCKEVENTS=y
-CONFIG_IRQ_RELEASE_METHOD=y
 CONFIG_HZ=100
 
 #
-- 
1.7.7.3


------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

