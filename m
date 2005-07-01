Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DoVIc-00005i-0u	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Jul 2005 16:51:58 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DoVIY-0006sw-1n	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Jul 2005 16:51:57 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH 1/2] UML - skas0 - separate kernel address
	space on stock hosts
References: <200507012131.j61LVCLi027276@ccure.user-mode-linux.org>
	<20050701145802.5cebabd2.akpm@osdl.org>
In-Reply-To: <20050701145802.5cebabd2.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200507020157.37593.blaisorblade@yahoo.it>
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
Date: Sat, 2 Jul 2005 01:57:36 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, "blaisorblade@yahoo.it" <blaisorblade_spam@yahoo.it>

On Friday 01 July 2005 23:58, Andrew Morton wrote:
> Jeff Dike <jdike@addtoit.com> wrote:
> > This patch implements something very close to skas mode for hosts
> > which don't support skas - I'm calling this skas0.
>
> I note that this patch assumes that
> uml-kill-some-useless-vmalloc-tlb-flushing.patch is applied.
You're fixing the conflict anyway since it's little, correct?
> AFAIK that patch is still in limbo due to objections from Paolo.  Can we
> sort that out please?
Ok, I'm going to test that out in the offending configuration. If that works, 
then Jeff will explain us why the same (rephrased) patch didn't work in 2.4 
and works in 2.6. When we have an explaination about that, I'll be very happy 
about merging the patch.

For myself, I don't even know why it didn't work in 2.4, I 
hadn't the knowledge and haven't the time.

People got breakage and when searching for it that looked the most invasive 
change, so I suggested removing and tests confirmed that.

However, for now it seems that I can't reproduce anyway the iptables crash, 
and even Jeff did some testing... so it seems it's ok.
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
