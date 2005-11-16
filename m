Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcBCA-0006aX-7p for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Nov 2005 16:30:38 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EcBC8-0008R8-I3
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Nov 2005 16:30:38 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [RFC PATCH] fixes for some compilation errors
Message-ID: <20051116012309.GB11520@ccure.user-mode-linux.org>
References: <20051115233006.GA31279@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115233006.GA31279@RAM>
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
Date: Tue, 15 Nov 2005 20:23:09 -0500
To: Ram Pai <linuxram@us.ibm.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Nov 15, 2005 at 03:30:06PM -0800, Ram Pai wrote:
> -extern void *switch_to_tt(void *prev, void *next);
> +extern void switch_to_tt(void *prev, void *next);

Oops, I hadn't built with CONFIG_MODE_TT enabled in a while.

> -#include <asm/signal.h>
> +//#include <asm/signal.h>

I now have this as <signal.h> which works here - can you check this?

> +#include "kern_constants.h"

I already have this, I may not have refreshed the patch before pushing it
out.

>  	err = stub_syscall3(__NR_setitimer, ITIMER_VIRTUAL,
> -			    (long) STUB_DATA(timer), 0);
> +			    (long) &from->timer, 0);

What were these doing to you?

I pushed out a fixed patchset - can you recheck?

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
