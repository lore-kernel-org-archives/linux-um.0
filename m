Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcKkE-0007jI-3n for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Nov 2005 02:42:26 -0800
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EcKkD-0006RK-SX
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Nov 2005 02:42:26 -0800
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jAGAgJ9d020462
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 16 Nov 2005 05:42:19 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id
	jAGAg67i062536 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 16 Nov 2005 03:42:06 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	jAGAgIwl014927 for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 16 Nov 2005 03:42:19 -0700
Subject: Re: [uml-devel] [RFC PATCH] fixes for some compilation errors
From: Ram Pai <linuxram@us.ibm.com>
In-Reply-To: <20051116012309.GB11520@ccure.user-mode-linux.org>
References: <20051115233006.GA31279@RAM>
	<20051116012309.GB11520@ccure.user-mode-linux.org>
Content-Type: text/plain
Message-Id: <1132137733.5720.17.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Wed, 16 Nov 2005 02:42:13 -0800
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, 2005-11-15 at 17:23, Jeff Dike wrote:
> On Tue, Nov 15, 2005 at 03:30:06PM -0800, Ram Pai wrote:
> > -extern void *switch_to_tt(void *prev, void *next);
> > +extern void switch_to_tt(void *prev, void *next);
> 
> Oops, I hadn't built with CONFIG_MODE_TT enabled in a while.
> 
> > -#include <asm/signal.h>
> > +//#include <asm/signal.h>
> 
> I now have this as <signal.h> which works here - can you check this?
> 
> > +#include "kern_constants.h"
> 
> I already have this, I may not have refreshed the patch before pushing it
> out.
> 
> >  	err = stub_syscall3(__NR_setitimer, ITIMER_VIRTUAL,
> > -			    (long) STUB_DATA(timer), 0);
> > +			    (long) &from->timer, 0);
> 
> What were these doing to you?
> 
> I pushed out a fixed patchset - can you recheck?

no. the last patch does not apply cleanly and it gives compilation
errors.


make -j32 arch/um/kernel/skas/clone.o ARCH=um
  CC      arch/um/kernel/skas/clone.o
arch/um/kernel/skas/clone.c: In function `stub_clone_handler':
arch/um/kernel/skas/clone.c:39: error: aggregate value used where an
integer was expected
make[1]: *** [arch/um/kernel/skas/clone.o] Error 1
make: *** [arch/um/kernel/skas/clone.o] Error 2

RP




> 
> 				Jeff
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
> Register for a JBoss Training Course.  Free Certification Exam
> for All Training Attendees Through End of 2005. For more info visit:
> http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
