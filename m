Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JyuYy-0005jy-GA for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 May 2008 13:05:28 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JyuYw-00020r-Gw
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 May 2008 13:05:28 -0700
Date: Wed, 21 May 2008 16:05:15 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080521200515.GB12373@c2.user-mode-linux.org>
References: <48345B31.50904@googlemail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48345B31.50904@googlemail.com>
Subject: Re: [uml-devel] linux-next: UML build error
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
To: Gabriel C <nix.or.die@googlemail.com>
Cc: linux-next@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Wed, May 21, 2008 at 07:26:09PM +0200, Gabriel C wrote:
>   CC      arch/um/sys-x86_64/ksyms.o
> arch/um/sys-x86_64/ksyms.c:5: error: '__memcpy' undeclared here (not in a function)
> arch/um/sys-x86_64/ksyms.c:5: warning: type defaults to 'int' in declaration of '__memcpy'

Does the patch below help?  There's gcc-version-dependent logic in
include/asm-x86/string_64.h which decides whether to declare memcpy or
__memcpy and it looks like you're hitting that.

	     	      Jeff

-- 
Work email - jdike at linux dot intel dot com

Index: linux-2.6.22/arch/um/sys-x86_64/ksyms.c
===================================================================
--- linux-2.6.22.orig/arch/um/sys-x86_64/ksyms.c	2008-04-23 13:07:23.000000000 -0400
+++ linux-2.6.22/arch/um/sys-x86_64/ksyms.c	2008-05-21 16:03:03.000000000 -0400
@@ -2,4 +2,8 @@
 #include "asm/string.h"
 
 /*XXX: we need them because they would be exported by x86_64 */
+#if (__GNUC__ == 4 && __GNUC_MINOR__ >= 3) || __GNUC__ > 4
+EXPORT_SYMBOL(memcpy);
+#else
 EXPORT_SYMBOL(__memcpy);
+#endif

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
