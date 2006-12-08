Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GsfKq-0005h6-A2 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Dec 2006 05:00:16 -0800
Received: from emailhub.stusta.mhn.de ([141.84.69.5]
	helo=mailout.stusta.mhn.de)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GsfKo-0002xK-Ki
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Dec 2006 05:00:16 -0800
Date: Fri, 8 Dec 2006 13:59:28 +0100
From: Adrian Bunk <bunk@stusta.de>
Message-ID: <20061208125928.GA25427@stusta.de>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] UML and fastcall/FASTCALL
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
To: jdike@karaya.com
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

UML on i386 is now the only case where fastcall/FASTCALL is not a noop.

There are two use cases for fastcall/FASTCALL in UML on i386:


1. optimization for C code
A faster calling convention is used for the functions annotated this way.


2. interfacing with assembler code
But include/asm-um/linkage.h contains the following:

<--  snip  -->

#ifndef __ASM_UM_LINKAGE_H
#define __ASM_UM_LINKAGE_H

#include "asm/arch/linkage.h"


/* <linux/linkage.h> will pick sane defaults */
#ifdef CONFIG_GPROF
#undef FASTCALL
#undef fastcall
#endif

#endif

<--  snip  -->

E.g. if CONFIG_SMP was still available on UML, CONFIG_SMP=y, 
CONFIG_GPROF=y would have some horrible effects when calling the 
functions in arch/i386/lib/semaphore.S.


Are there any benchmark numbers that the existing fastcall/FASTCALL 
annotations in the kernel really make a measurable difference for
C code?

Otherwise, we could use it only for assembler code using this calling 
convention (if there is any used by UML) - and CONFIG_GPROF mustn't 
change this.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
