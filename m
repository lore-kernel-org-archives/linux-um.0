Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.91] (helo=sc8-sf-mx1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DoVaF-0000s8-9N	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Jul 2005 17:10:11 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1-new.sourceforge.net with smtp (Exim 4.44)
	id 1DoVaA-00057l-Ku	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Jul 2005 17:10:11 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH 1/2] UML - skas0 - separate kernel address
	space on stock hosts
References: <200507012131.j61LVCLi027276@ccure.user-mode-linux.org>
	<200507020157.37593.blaisorblade@yahoo.it>
	<20050701170648.2762c702.akpm@osdl.org>
In-Reply-To: <20050701170648.2762c702.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507020215.51323.blaisorblade@yahoo.it>
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
Date: Sat, 2 Jul 2005 02:15:50 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com, linux-kernel@vger.kernel.org

On Saturday 02 July 2005 02:06, Andrew Morton wrote:
> Blaisorblade <blaisorblade@yahoo.it> wrote:
> > On Friday 01 July 2005 23:58, Andrew Morton wrote:

> Well I can fix the reject if we decide that
> uml-kill-some-useless-vmalloc-tlb-flushing.patch is not to be applied, but
> it seems that there's no need.

> > However, for now it seems that I can't reproduce anyway the iptables
> > crash, and even Jeff did some testing... so it seems it's ok.

> OK..

> Now what about uml-remove-winch-sem.patch?  I have a "keep this in -mm"
> sign next to it.
Well, wait a bit for that... I'll be publishing that out in my patchset, so 
we'll get wider testing.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
