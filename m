Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dkpya-0006Uq-Qg	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Jun 2005 14:08:08 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DkpyZ-0002AT-9m	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Jun 2005 14:08:08 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Entropy on boot
Message-ID: <20050621210236.GA30220@ccure.user-mode-linux.org>
References: <20050620202549.A6907@sphinx.mythic-beasts.com>
	<20050620211638.GB10675@ccure.user-mode-linux.org>
	<20050621195047.B14716@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050621195047.B14716@sphinx.mythic-beasts.com>
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
Date: Tue, 21 Jun 2005 17:02:36 -0400
To: Paul Warren <pdw@ex-parrot.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Jun 21, 2005 at 07:50:47PM +0100, Paul Warren wrote:
> Unless I've missed something, that doesn't solve the problem for an
> out-of-the-box Linux distro, which expects to read from /dev/random.

I guess out-of-the-box Linux distros aren't intended for entroy-starved
environments.

So, I guess you can fix your distro to use the driver that UML provides
or you can put up with the starvation.  The hwrng driver is the right 
solution, and is far preferable to whacking a bunch into random.c.

That would never make it anywhere near mainline, so you would have a
choice of dumping that into every UML pool you build or fixing your
filesystems to use the rngtools.

				Jef


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
