Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1Qu80J-0003aB-Lh
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:11:47 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qu80I-000445-RV
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Aug 2011 19:11:47 +0000
Date: Thu, 18 Aug 2011 20:11:39 +0100
MIME-Version: 1.0
Message-Id: <E1Qu80B-000815-UG@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
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
Subject: [uml-devel] Subject: [PATCH 76/91] um: page_offset.h is never used
To: richard@nod.at
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


... and neither is the only define in it

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/asm/page_offset.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)
 delete mode 100644 arch/um/include/asm/page_offset.h

diff --git a/arch/um/include/asm/page_offset.h b/arch/um/include/asm/page_offset.h
deleted file mode 100644
index 1c168df..0000000
--- a/arch/um/include/asm/page_offset.h
+++ /dev/null
@@ -1 +0,0 @@
-#define PAGE_OFFSET_RAW (uml_physmem)
-- 
1.7.2.5



------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

