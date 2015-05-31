Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YzAwL-0003c8-DU
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 May 2015 21:38:41 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YzAwK-0006R6-LY for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 May 2015 21:38:41 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun, 31 May 2015 23:38:25 +0200
Message-Id: <1433108305-9255-5-git-send-email-richard@nod.at>
In-Reply-To: <1433108305-9255-1-git-send-email-richard@nod.at>
References: <1433108305-9255-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 5/5] um: Fix mconsole dependency
To: richard@nod.at
Cc: user-mode-linux-devel@lists.sourceforge.net

mconsole depends on CONFIG_PROC_FS.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/Kconfig.um | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Kconfig.um b/arch/um/Kconfig.um
index bd5459c..28a9885 100644
--- a/arch/um/Kconfig.um
+++ b/arch/um/Kconfig.um
@@ -46,6 +46,7 @@ config HOSTFS
 
 config MCONSOLE
 	bool "Management console"
+	depends on PROC_FS
 	default y
 	help
           The user mode linux management console is a low-level interface to
-- 
1.8.4.5


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

