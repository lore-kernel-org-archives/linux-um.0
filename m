Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DoV8e-0008A3-2a	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Jul 2005 16:41:40 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DoV8c-00069A-8L	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Jul 2005 16:41:39 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050701225623.GA28413@ccure.user-mode-linux.org>
References: <200507012131.j61LVCLi027276@ccure.user-mode-linux.org>
	<20050701145802.5cebabd2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050701145802.5cebabd2.akpm@osdl.org>
Subject: [uml-devel] Re: [PATCH 1/2] UML - skas0 - separate kernel address
	space on stock hosts
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
Date: Fri, 1 Jul 2005 18:56:23 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, "blaisorblade@yahoo.it" <blaisorblade_spam@yahoo.it>

On Fri, Jul 01, 2005 at 02:58:02PM -0700, Andrew Morton wrote:
> I note that this patch assumes that
> uml-kill-some-useless-vmalloc-tlb-flushing.patch is applied.
> 
> AFAIK that patch is still in limbo due to objections from Paolo.  Can we
> sort that out please?

I did some testing to check that vmalloc is OK.  

First, boot and do a kernel build on COWed devices, which uses vmalloc space
for the block bitmaps.

Second, modprobed all modules, and made sure that one of them actually worked.
Ran a kernel build to induce lots of context switches, made sure it still 
worked.

It sure seems OK to me.

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
