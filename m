Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K3bmm-00062e-7M for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 12:03:08 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K3bml-0008O6-JD
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 12:03:08 -0700
Date: Tue, 3 Jun 2008 15:02:37 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080603190237.GA9517@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 4/6] UML - memcpy export needs to follow host
	declaration
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Gabriel C <nix.or.die@googlemail.com>

x86_64 defines either memcpy or __memcpy depending on the gcc version,
and it looks like UML needs to follow that in its exporting.

Cc: Gabriel C <nix.or.die@googlemail.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/sys-x86_64/ksyms.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6-git/arch/um/sys-x86_64/ksyms.c
===================================================================
--- linux-2.6-git.orig/arch/um/sys-x86_64/ksyms.c	2008-05-28 12:32:34.000000000 -0400
+++ linux-2.6-git/arch/um/sys-x86_64/ksyms.c	2008-06-02 15:49:43.000000000 -0400
@@ -3,5 +3,9 @@
 #include <asm/checksum.h>
 
 /*XXX: we need them because they would be exported by x86_64 */
+#if (__GNUC__ == 4 && __GNUC_MINOR__ >= 3) || __GNUC__ > 4
+EXPORT_SYMBOL(memcpy);
+#else
 EXPORT_SYMBOL(__memcpy);
+#endif
 EXPORT_SYMBOL(csum_partial);

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
