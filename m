Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DtYY1-0003ud-6H	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Jul 2005 15:20:45 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1DtYXy-0002BN-OI	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Jul 2005 15:20:45 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050715204957.GE8069@ccure.user-mode-linux.org>
References: <20050714222007.568784000@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050714222007.568784000@homer>
Subject: [uml-devel] Re: [patch 1/1] printk : arch/um/
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
Date: Fri, 15 Jul 2005 16:49:57 -0400
To: domen@coderock.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Christophe Lucas <clucas@rotomalug.org>

On Fri, Jul 15, 2005 at 12:20:08AM +0200, domen@coderock.org wrote:
> printk() calls should include appropriate KERN_* constant.

Queued, thanks.  It may wait till after KS/OLS to get merged.

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
