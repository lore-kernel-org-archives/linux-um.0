Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9nR0-0000Ho-Og for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 08:56:22 -0800
Received: from mailout.stusta.mhn.de ([141.84.69.5])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D9nQx-0004tw-R2 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 08:56:22 -0800
From: Adrian Bunk <bunk@stusta.de>
Message-ID: <20050311165526.GA3723@stusta.de>
References: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org>
	<20050310225340.GD3205@stusta.de>
	<200503111849.j2BImsJp003370@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503111849.j2BImsJp003370@ccure.user-mode-linux.org>
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
Date: Fri, 11 Mar 2005 17:55:26 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Fri, Mar 11, 2005 at 01:48:54PM -0500, Jeff Dike wrote:
> bunk@stusta.de said:
> > This patch is still wrong.
> > It seems my comment on this [1] was lost:
> > <--  snip  -->
> > This line has to be something like
> > ( (__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4)
> > && \
> >    HEAVILY_PATCHED_SUSE_GCC ) 
> 
> > I hope SuSE has added some #define to distinguish what they call  "gcc
> > 3.3.4" from GNU gcc 3.3.4 
> 
> It wasn't lost - I am just disinclined to cater to distros making their
> gcc lie about its version.

And therefore you added a patch that helps only those distros at the 
price of breaking other people and distros using sane compilers?

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
