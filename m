Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyBvh-0002iI-BN	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Jul 2005 10:12:21 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1DyBvc-0004DH-MJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Jul 2005 10:12:21 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 1/7] UML - -mm3 compile fix
References: <200507281626.j6SGQgsI009471@ccure.user-mode-linux.org>
In-Reply-To: <200507281626.j6SGQgsI009471@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507281929.26273.blaisorblade@yahoo.it>
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
Date: Thu, 28 Jul 2005 19:29:25 +0200
To: akpm@osdl.org
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thursday 28 July 2005 18:26, Jeff Dike wrote:
> -mm3 adds an include of asm/vm86.h in include/asm-i386/ptrace.h.  Since UML
> includes the underlying arch's ptrace.h, it needs an asm/vm86.h in order
> to build.
Note for both Jeff and Akpm: this is also for the current Linus' git 
repository (just since today).

> Signed-off-by: Jeff Dike <jdike@addtoit.com>

> Index: linux-2.6.12-rc3-mm2/include/asm-um/vm86.h
> ===================================================================
> --- linux-2.6.12-rc3-mm2.orig/include/asm-um/vm86.h	2005-07-28
> 05:04:34.593890552 -0400 +++
> linux-2.6.12-rc3-mm2/include/asm-um/vm86.h	2005-07-28 11:13:32.000000000
> -0400 @@ -0,0 +1,6 @@
> +#ifndef __UM_VM86_H
> +#define __UM_VM86_H
> +
> +#include "asm/arch/vm86.h"
> +
> +#endif

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
