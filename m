Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9sT5-00036y-2j for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 14:18:51 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D9sT3-0006Gf-H0 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 14:18:50 -0800
Message-Id: <200503112354.j2BNrFJp005237@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Fri, 11 Mar 2005 17:55:26 +0100."
	<20050311165526.GA3723@stusta.de> 
References: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org>
	<20050310225340.GD3205@stusta.de>
	<200503111849.j2BImsJp003370@ccure.user-mode-linux.org>
	<20050311165526.GA3723@stusta.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [PATCH 4/9] UML - Export gcov symbol based on gcc
	version
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
Date: Fri, 11 Mar 2005 18:53:15 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

bunk@stusta.de said:
> And therefore you added a patch that helps only those distros at the
> price of breaking other people and distros using sane compilers? 

Didn't you start this thread by pointing out that SuSE has a gcc 3.3.4
which isn't?  I would call that a compiler which lies about its version, and
for the purposes of this argument, I would say that it is not a sane
compiler.

Given this, your original (correct) claim was that my patch would not help
such compilers.  Are you now claiming that it does help such compilers, and
no one else?

				Jeff




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
