Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1RuYpE-0004ak-N2
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Feb 2012 00:22:24 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RuYpD-00008c-9N
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Feb 2012 00:22:24 +0000
From: Richard Weinberger <richard@nod.at>
Date: Tue,  7 Feb 2012 01:22:49 +0100
Message-Id: <1328574170-2286-4-git-send-email-richard@nod.at>
In-Reply-To: <1328574170-2286-1-git-send-email-richard@nod.at>
References: <1328574170-2286-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 4/5] um: Wire CONFIG_GENERIC_IO up
To: linux-kernel@vger.kernel.org
Cc: Artem.Bityutskiy@linux.intel.com, linux-mtd@lists.infradead.org, viro@zeniv.linux.org.uk, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>

UML has no io memory but implements everything defined in
generic-asm/io.h.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Kconfig.common |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index b37ae70..20a49ba 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -9,6 +9,7 @@ config UML
 	select HAVE_GENERIC_HARDIRQS
 	select GENERIC_IRQ_SHOW
 	select GENERIC_CPU_DEVICES
+	select GENERIC_IO
 
 config MMU
 	bool
-- 
1.7.6


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

