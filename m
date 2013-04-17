Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eunb.song@samsung.com>) id 1USFwH-0007Zn-5C
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Apr 2013 00:09:29 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1USFwC-0003mj-7x for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Apr 2013 00:09:26 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MLD008JNHR6VM50@mailout4.samsung.com> for
	user-mode-linux-devel@lists.sourceforge.net; Wed,
	17 Apr 2013 09:09:17 +0900 (KST)
Date: Wed, 17 Apr 2013 00:09:17 +0000 (GMT)
From: EUNBONG SONG <eunb.song@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <8414166.322181366157356551.JavaMail.weblogic@epml27>
Reply-To: eunb.song@samsung.com
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
Subject: [uml-devel] [PATCH] um: set CONFIG_LOCKDEP_SUPPORT to CONFIG_LOCKDEP
To: jdike@addtoit.com, richard@nod.at
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net


CONFIG_LOCKDEP_SUPPORT is no longer valid.

Singed-off-by: EunBong Song <eunb.song@samsung.com>

---
 arch/um/defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/defconfig b/arch/um/defconfig
index 08107a7..bbc5aa7 100644
--- a/arch/um/defconfig
+++ b/arch/um/defconfig
@@ -7,7 +7,7 @@ CONFIG_UML=y
 CONFIG_MMU=y
 CONFIG_NO_IOMEM=y
 # CONFIG_TRACE_IRQFLAGS_SUPPORT is not set
-CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_LOCKDEP=y
 # CONFIG_STACKTRACE_SUPPORT is not set
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_BUG=y
-- 
1.7.0.4
------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

