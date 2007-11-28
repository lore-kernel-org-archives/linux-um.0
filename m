Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IxSDD-0001Q0-Ty for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 11:04:44 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IxSDC-00034N-Ur
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 11:04:43 -0800
Date: Wed, 28 Nov 2007 14:04:38 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071128190438.GA8298@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/4] UML - Keep UML Kconfig in sync with x86
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Fix a UML build breakage introduced by commit
1032c0ba9da5c5b53173ad2dcf8b2a2da78f8b17 - it introduces X86_32, with
many things which UML needs depending on it.

This patch adds definitions of X86_32 and RWSEM_XCHGADD_ALGORITHM to
the UML/i386 Kconfig.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/Kconfig.i386 |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-2.6/arch/um/Kconfig.i386
===================================================================
--- linux-2.6.orig/arch/um/Kconfig.i386	2007-11-19 12:49:30.000000000 -0500
+++ linux-2.6/arch/um/Kconfig.i386	2007-11-19 13:56:37.000000000 -0500
@@ -8,6 +8,13 @@ config UML_X86
 	bool
 	default y
 
+config X86_32
+       bool
+       default y
+
+config RWSEM_XCHGADD_ALGORITHM
+	def_bool y
+
 config 64BIT
 	bool
 	default n

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
