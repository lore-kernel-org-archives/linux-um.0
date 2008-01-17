Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFcTp-00011z-Uk for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:01 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFcTp-0001a5-5R
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:40:57 -0800
Date: Thu, 17 Jan 2008 16:40:39 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080117214039.GA6702@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 4/20] UML - Implement O_APPEND
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

The .a flags in openflags never had an implementation.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/os-Linux/file.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.22/arch/um/os-Linux/file.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/file.c	2007-12-13 13:50:52.000000000 -0500
+++ linux-2.6.22/arch/um/os-Linux/file.c	2007-12-13 15:23:13.000000000 -0500
@@ -191,6 +191,8 @@ int os_open_file(const char *file, struc
 		f |= O_TRUNC;
 	if (flags.e)
 		f |= O_EXCL;
+	if (flags.a)
+		f |= O_APPEND;
 
 	fd = open64(file, f, mode);
 	if (fd < 0)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
