Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9thy-0007IK-D9 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 15:38:18 -0800
Received: from emailhub.stusta.mhn.de ([141.84.69.5]
	helo=mailout.stusta.mhn.de)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D9thw-0003Oo-7C for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 15:38:17 -0800
From: Adrian Bunk <bunk@stusta.de>
Message-ID: <20050311233722.GS3723@stusta.de>
References: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org>
	<20050310225340.GD3205@stusta.de>
	<200503111849.j2BImsJp003370@ccure.user-mode-linux.org>
	<20050311165526.GA3723@stusta.de>
	<200503112354.j2BNrFJp005237@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503112354.j2BNrFJp005237@ccure.user-mode-linux.org>
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
Date: Sat, 12 Mar 2005 00:37:22 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Fri, Mar 11, 2005 at 06:53:15PM -0500, Jeff Dike wrote:
> bunk@stusta.de said:
> > And therefore you added a patch that helps only those distros at the
> > price of breaking other people and distros using sane compilers? 
> 
> Didn't you start this thread by pointing out that SuSE has a gcc 3.3.4
> which isn't?  I would call that a compiler which lies about its version, and
> for the purposes of this argument, I would say that it is not a sane
> compiler.

I said:

<--  snip  -->

This line has to be something like

( (__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4) && \
   HEAVILY_PATCHES_SUSE_GCC ) 

<--  snip  -->

IOW:
Only heavily patches gcc 3.3 compiler define __gcov_init.


Anton's original report said that he needs __gcov_init with
SuSE gcc 3.3.4 .


> Given this, your original (correct) claim was that my patch would not help
> such compilers.  Are you now claiming that it does help such compilers, and
> no one else?

No, my claim is that no sane gcc 3.3 defines __gcov_init.

> 				Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
