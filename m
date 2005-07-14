Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dt5Xt-0000Si-Vk	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 08:22:41 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1Dt5Xr-0008Lj-Ip	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 08:22:42 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Am I doing something wrong with -skas0?
Message-ID: <20050714142333.GA3752@ccure.user-mode-linux.org>
References: <200507122346.40320.rob@landley.net>
	<42D504D8.1010606@fujitsu-siemens.com> <200507131647.53822.rob@landley.net>
	<42D6459B.6080702@fujitsu-siemens.com> <42D654F7.2080608@fujitsu-siemens.com>
	<20050714134327.GB26655@ccure.user-mode-linux.org>
	<42D67282.4020601@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D67282.4020601@fujitsu-siemens.com>
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
Date: Thu, 14 Jul 2005 10:23:33 -0400
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>

On Thu, Jul 14, 2005 at 04:11:14PM +0200, Bodo Stroesser wrote:
> Do you know _what_ makes the problem happen? Is it depended on the
> compiler version (gcc 3.3.5) or is there any CONFIG_XXXXX, that lets
> make use some special compiler option?

CONFIG_FRAME_POINTER (or maybe CONFIG_DEBUG_INFO enables frame pointers)
would be my guess.

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
