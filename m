Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IvLpm-0001tI-NI for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Nov 2007 15:51:50 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IvLpl-0002u7-7b
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Nov 2007 15:51:50 -0800
Date: Thu, 22 Nov 2007 18:51:41 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071122235141.GA7876@c2.user-mode-linux.org>
References: <E1Is5FL-00078H-00@dorka.pomaz.szeredi.hu>
	<20071114011002.GA11477@c2.user-mode-linux.org>
	<E1IsFbA-0007y2-00@dorka.pomaz.szeredi.hu>
	<20071114142247.GA5848@c2.user-mode-linux.org>
	<E1IsK83-0008CJ-00@dorka.pomaz.szeredi.hu>
	<20071114173639.GA7899@c2.user-mode-linux.org>
	<E1IsPo5-0008RU-00@dorka.pomaz.szeredi.hu>
	<20071116170630.GA9299@c2.user-mode-linux.org>
	<E1IvGTn-0007cC-7q@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1IvGTn-0007cC-7q@dorka.pomaz.szeredi.hu>
Subject: Re: [uml-devel] uml doesn't work on 2.6.24-rc2
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Nov 22, 2007 at 07:08:47PM +0100, Miklos Szeredi wrote:
> Thanks.  My other problem is (probably you are aware) that recent -mm
> kernels don't compile for UML.

The patch below fixes the build for rc3-mm1 for me.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

Index: linux-2.6.22/include/asm-um/asm.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.22/include/asm-um/asm.h	2007-11-21 12:15:03.000000000 -0500
@@ -0,0 +1,6 @@
+#ifndef __UM_ASM_H
+#define __UM_ASM_H
+
+#include "asm/arch/asm.h"
+
+#endif

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
