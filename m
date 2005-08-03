Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E0NFe-0006mB-QK	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Aug 2005 10:41:58 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E0NFc-0002eA-D8
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Aug 2005 10:41:58 -0700
Subject: Re: [uml-devel] 2.6.12-bs7 vs 2.6.12-bb8
From: antoine <antoine@nagafix.co.uk>
In-Reply-To: <200507222020.55873.blaisorblade@yahoo.it>
References: <20050721220839.F01B389B90@sc8-sf-spam1.sourceforge.net>
	 <1122032119.13225.9.camel@dhcp-192-168-22-217.internal>
	 <200507222020.55873.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1123090843.5177.38.camel@dhcp-192-168-22-217.internal>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Wed, 03 Aug 2005 18:40:43 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

> > I've just stared testing your latest patches on a amd64 box running
> > 2.6.13-rc3-git4, bb8 seems to run (so far)
> Using TT or SKAS0 mode? And is this specific to that host release wrt 2.6.12?
> > but bs7 comes up with: 
(...)
bs works fine on 2.6.13-rc4 now, must have been a host bug?
But all guest 64-bit kernels are still loosing memory fast, gentoo's
"emerge --sync" is enough to eat 300+ MB of ram! (in about 5 minutes)

Antoine



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
