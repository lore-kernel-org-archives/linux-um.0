Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DtXBn-0008Ct-On	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Jul 2005 13:53:43 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DtXBl-0001Le-IQ	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Jul 2005 13:53:44 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050715204747.GD8069@ccure.user-mode-linux.org>
References: <42D7D802.2080100@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D7D802.2080100@fujitsu-siemens.com>
Subject: [uml-devel] Re: Some changes in SKAS0
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
Date: Fri, 15 Jul 2005 16:47:47 -0400
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>, BlaisorBlade <blaisorblade_spam@yahoo.it>

On Fri, Jul 15, 2005 at 05:36:34PM +0200, Bodo Stroesser wrote:
> All three patches are attached. They are tested in i386 and s390,
> for me they work fine. I hope, the patches don't break x86_64.
> Unfortunately I can't test that.
> If there would be a solution for the RCX problem on x86_64, I would
> prefer to use the "int3" this subarch also, making the nasty
> ARCH_STUB_SEGV_MASK_SIGNAL macro obsolete.

Thanks, I've got these saved away.  I might not get to merge them until 
after KS/OLS though.

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
