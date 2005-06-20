Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkTiX-0008Ur-AD	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 14:22:05 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DkTiS-0001bx-Sh	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 14:22:05 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Entropy on boot
Message-ID: <20050620211638.GB10675@ccure.user-mode-linux.org>
References: <20050620202549.A6907@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620202549.A6907@sphinx.mythic-beasts.com>
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
Date: Mon, 20 Jun 2005 17:16:38 -0400
To: Paul Warren <pdw@ex-parrot.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Jun 20, 2005 at 08:25:49PM +0100, Paul Warren wrote:
> We've recently prepared a filesystem image for the latest Debian
> distribution, and hit a problem with it hanging on starting Apache2.  We
> traced this to a lack of entropy to feed /dev/random, causing the
> Apache's startssl to block.
> 
> Chris Lightfoot has developed this patch to feed the guest's entropy
> pool with data read from the host's /dev/random on boot:
> 
> 	http://mythic-beasts.com/uml/random-seed.patch
> 
> Paul

Are you using UML's hwrng driver?  Did it not help?

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
