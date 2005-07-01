Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DoTVZ-0003PF-TA	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Jul 2005 14:57:13 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)	id 1DoTVX-0001Ij-NG
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Jul 2005 14:57:13 -0700
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20050701145802.5cebabd2.akpm@osdl.org>
In-Reply-To: <200507012131.j61LVCLi027276@ccure.user-mode-linux.org>
References: <200507012131.j61LVCLi027276@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Date: Fri, 1 Jul 2005 14:58:02 -0700
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, "blaisorblade@yahoo.it" <blaisorblade_spam@yahoo.it>

Jeff Dike <jdike@addtoit.com> wrote:
>
> This patch implements something very close to skas mode for hosts
> which don't support skas - I'm calling this skas0.

I note that this patch assumes that
uml-kill-some-useless-vmalloc-tlb-flushing.patch is applied.

AFAIK that patch is still in limbo due to objections from Paolo.  Can we
sort that out please?


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
