Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkNiS-0006zD-Co	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 07:57:36 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DkNiR-0006De-Qz	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 07:57:36 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Recent patches of note
Message-ID: <20050620144747.GA5530@ccure.user-mode-linux.org>
References: <s2b1a1ed.010@ORANGE.OUS.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s2b1a1ed.010@ORANGE.OUS.EDU>
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
Date: Mon, 20 Jun 2005 10:47:47 -0400
To: Anthony Brock <Anthony_Brock@ous.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Jun 16, 2005 at 03:59:24PM -0700, Anthony Brock wrote:
> Program received signal SIGSEGV, Segmentation fault.
> 0x080b86d0 in __vmalloc_area (area=0xbd15be0, gfp_mask=210, prot={pgprot = 0}) at string.h:363

Segfaults in vmalloc are completely normal.  They are just page faults.

> BUG: soft lockup detected on CPU#0!

The soft lockups should be fixed by the sched-starve patch.  This one is
likely caused by you sitting in the debugger.

If you do see any that don't involve gdb, and you have sched-starve applied,
let me know.

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
