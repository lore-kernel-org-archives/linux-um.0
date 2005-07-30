Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DzDGY-0007cv-KX	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jul 2005 05:50:06 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1DzDGW-0007cn-DJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jul 2005 05:50:06 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050730160218.GB4585@ccure.user-mode-linux.org>
References: <20050728185655.9C6ADA3@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050728185655.9C6ADA3@zion.home.lan>
Subject: [uml-devel] Re: [patch 1/3] uml: share page bits handling between 2
	and 3 level pagetables
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
Date: Sat, 30 Jul 2005 12:02:18 -0400
To: blaisorblade@yahoo.it
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jul 28, 2005 at 08:56:53PM +0200, blaisorblade@yahoo.it wrote:
> As obvious, a "core code nice cleanup" is not a "stability-friendly patch" so
> usual care applies.

These look reasonable, as they are what we discussed in Ottawa.

I'll put them in my tree and see if I see any problems.  I would
suggest sending these in early after 2.6.13 if they seem OK.

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
