Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E5QF8-0007uS-OD	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Aug 2005 08:54:18 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E5QF8-0001GB-JF
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Aug 2005 08:54:19 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: 2.6.12.4 + bb12
Message-ID: <20050817145537.GA3974@ccure.user-mode-linux.org>
References: <1124276978.3965.10.camel@localhost.localdomain>
	<1124279672.3965.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124279672.3965.12.camel@localhost.localdomain>
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
Date: Wed, 17 Aug 2005 10:55:37 -0400
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: Blaisorblade <blaisorblade@yahoo.it>, UML devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Aug 17, 2005 at 12:54:32PM +0100, Antoine Martin wrote:
> And for completeness, I get this error on amd64:
> /usr/include/asm-x86_64/user.h:56: error: syntax error before ?u64?
> /usr/include/asm-x86_64/user.h:58: error: syntax error before ?mxcsr?
> /usr/include/asm-x86_64/user.h:59: error: syntax error before
> ?mxcsr_mask?
> /usr/include/asm-x86_64/user.h:60: error: syntax error before ?st_space?
> /usr/include/asm-x86_64/user.h:61: error: syntax error before
> ?xmm_space?
> /usr/include/asm-x86_64/user.h:62: error: syntax error before ?padding?
> /usr/include/asm-x86_64/user.h:63: error: syntax error before ?}? token
> /usr/include/asm-x86_64/user.h:87: error: field ?i387? has incomplete
> type

This one I have a patch for:

Index: linux-2.6.13-rc6/arch/um/os-Linux/elf_aux.c
===================================================================
--- linux-2.6.13-rc6.orig/arch/um/os-Linux/elf_aux.c	2005-08-08 12:11:18.000000000 -0400
+++ linux-2.6.13-rc6/arch/um/os-Linux/elf_aux.c	2005-08-15 13:53:50.000000000 -0400
@@ -9,7 +9,6 @@
  */
 #include <elf.h>
 #include <stddef.h>
-#include <asm/elf.h>
 #include "init.h"
 #include "elf_user.h"
 #include "mem_user.h"

				Jeff


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
