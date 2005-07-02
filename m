Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DoVWA-0000dZ-Ez	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Jul 2005 17:05:58 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)	id 1DoVW9-0001fw-RX
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Jul 2005 17:05:58 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [uml-devel] Re: [PATCH 1/2] UML - skas0 - separate kernel
 address space on stock hosts
Message-Id: <20050701170648.2762c702.akpm@osdl.org>
In-Reply-To: <200507020157.37593.blaisorblade@yahoo.it>
References: <200507012131.j61LVCLi027276@ccure.user-mode-linux.org>
	<20050701145802.5cebabd2.akpm@osdl.org>
	<200507020157.37593.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Date: Fri, 1 Jul 2005 17:06:48 -0700
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com, linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it

Blaisorblade <blaisorblade@yahoo.it> wrote:
>
> On Friday 01 July 2005 23:58, Andrew Morton wrote:
> > Jeff Dike <jdike@addtoit.com> wrote:
> > > This patch implements something very close to skas mode for hosts
> > > which don't support skas - I'm calling this skas0.
> >
> > I note that this patch assumes that
> > uml-kill-some-useless-vmalloc-tlb-flushing.patch is applied.
>
> You're fixing the conflict anyway since it's little, correct?

Well I can fix the reject if we decide that
uml-kill-some-useless-vmalloc-tlb-flushing.patch is not to be applied, but
it seems that there's no need.

> However, for now it seems that I can't reproduce anyway the iptables crash, 
> and even Jeff did some testing... so it seems it's ok.

OK..

Now what about uml-remove-winch-sem.patch?  I have a "keep this in -mm"
sign next to it.



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
