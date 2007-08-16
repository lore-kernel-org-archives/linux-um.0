Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILi9O-0003uC-Kw for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 09:24:48 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ILi9M-00057q-3i
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 09:24:46 -0700
Date: Thu, 16 Aug 2007 12:24:28 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070816162428.GA8128@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] UML - Add a .note.SuSE section
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
To: Andrew Morton <akpm@osdl.org>, stable@kernel.org
Cc: Alberto Pires de Oliveira Neto <apon1@terra.com.br>, giedrius@su.lt, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

[ This is both 2.6.24 and -stable material ]

SuSE seems to require that binaries have a .note.SuSE section.
Without it, UML segfaults if any parameters are passed on the command
line.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/kernel/dyn.lds.S |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.22/arch/um/kernel/dyn.lds.S
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/dyn.lds.S	2007-08-15 10:39:39.000000000 -0400
+++ linux-2.6.22/arch/um/kernel/dyn.lds.S	2007-08-15 12:07:10.000000000 -0400
@@ -10,6 +10,7 @@ SECTIONS
   PROVIDE (__executable_start = START);
   . = START + SIZEOF_HEADERS;
   .interp         : { *(.interp) }
+  .note.SuSE	  : { *(.note.SuSE) }
   __binary_start = .;
   . = ALIGN(4096);		/* Init code and data */
   _text = .;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
