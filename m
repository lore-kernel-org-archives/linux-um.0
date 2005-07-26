Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DxVpd-0005na-Qs	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Jul 2005 13:15:17 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1DxVpb-0004mB-3w
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Jul 2005 13:15:17 -0700
Message-Id: <200507262004.j6QK483G010074@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/4] UML - Update module interface
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 26 Jul 2005 16:04:08 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Dominik Hackl <dominik@hackl.dhs.org>

From: Dominik Hackl <dominik@hackl.dhs.org>

This patch replaces the deprecated MODULE_PARM function by the new 
module_param function.

Signed-off-by: Dominik Hackl <dominik@hackl.dhs.org>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/drivers/hostaudio_kern.c
===================================================================
--- linux-2.6.12.orig/arch/um/drivers/hostaudio_kern.c	2005-07-19 12:03:09.000000000 -0400
+++ linux-2.6.12/arch/um/drivers/hostaudio_kern.c	2005-07-19 12:09:04.000000000 -0400
@@ -57,10 +57,10 @@
 
 #else /*MODULE*/
 
-MODULE_PARM(dsp, "s");
+module_param(dsp, charp, 0644);
 MODULE_PARM_DESC(dsp, DSP_HELP);
 
-MODULE_PARM(mixer, "s");
+module_param(mixer, charp, 0644);
 MODULE_PARM_DESC(mixer, MIXER_HELP);
 
 #endif



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
