Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DtYBe-0002sP-Cp	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Jul 2005 14:57:38 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DtYBc-0003Qv-8F	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Jul 2005 14:57:38 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050715215126.GA9234@ccure.user-mode-linux.org>
References: <29D15BBCA340DA4D8146D38B4924FC7A105113@zcarhxm0.corp.nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29D15BBCA340DA4D8146D38B4924FC7A105113@zcarhxm0.corp.nortel.com>
Subject: [uml-devel] Re: prot |= _PAGE_PCD | _PAGE_PWT;
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
Date: Fri, 15 Jul 2005 17:51:26 -0400
To: Majid Salame <msalame@nortel.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Jul 15, 2005 at 03:26:54PM -0400, Majid Salame wrote:
>  in asm-um/pgtable.h we do not have definitions and may be for good
> reason for PAGE_PCD and _PAGE_PWT.
> 
> #define _PAGE_PWT	0x008
> #define _PAGE_PCD	0x010
> 
> Can I in UML recode this statement in much same way drivers/char/mem.c
>      prot |= _PAGE_PCD | _PAGE_PWT;

What do they mean?

			Jeff


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
