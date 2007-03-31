Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HXSHr-0008UX-P3 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 18:21:49 -0700
Received: from mbox.ssc.unict.it ([151.97.230.9] helo=ssc.unict.it)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HXSHq-00012T-1w
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 18:21:47 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Date: Sat, 31 Mar 2007 03:20:27 +0200
Message-ID: <20070331012027.24884.85252.stgit@americanbeauty.home.lan>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH] [PATCH] uml: fix static linking for real
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

There was a typo in commit 7632fc8f809a97f9d82ce125e8e3e579390ce2e5, preventing
it from working - 32bit binaries crashed hopelessly before the below fix and
work perfectly now.
Merge for 2.6.21, please.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/asm-um/common.lds.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-um/common.lds.S b/include/asm-um/common.lds.S
index b16222b..f5de80c 100644
--- a/include/asm-um/common.lds.S
+++ b/include/asm-um/common.lds.S
@@ -15,7 +15,7 @@
   PROVIDE (_unprotected_end = .);
 
   . = ALIGN(4096);
-  .note : { *(note.*) }
+  .note : { *(.note.*) }
   __start___ex_table = .;
   __ex_table : { *(__ex_table) }
   __stop___ex_table = .;




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
