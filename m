Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dknps-0003tm-Ct	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Jun 2005 11:51:00 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1Dknpq-0005oC-12
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Jun 2005 11:50:59 -0700
Received: from sphinx.mythic-beasts.com ([212.69.37.6])
	by externalmx-1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)	id 1Dknpl-00078J-64
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Jun 2005 11:50:55 -0700
From: Paul Warren <pdw@ex-parrot.com>
Subject: Re: [uml-devel] Entropy on boot
Message-ID: <20050621195047.B14716@sphinx.mythic-beasts.com>
References: <20050620202549.A6907@sphinx.mythic-beasts.com>
	<20050620211638.GB10675@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620211638.GB10675@ccure.user-mode-linux.org>;
	from jdike@addtoit.com on Mon, Jun 20, 2005 at 05:16:38PM -0400
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
Date: Tue, 21 Jun 2005 19:50:47 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Jun 20, 2005 at 05:16:38PM -0400, Jeff Dike wrote:
> Are you using UML's hwrng driver?  Did it not help?

Unless I've missed something, that doesn't solve the problem for an
out-of-the-box Linux distro, which expects to read from /dev/random.

Paul


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
