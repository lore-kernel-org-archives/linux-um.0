Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9mq8-0006Tz-Mk for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 08:18:16 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D9mq7-0003XJ-4c for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Mar 2005 08:18:16 -0800
Message-Id: <200503111849.j2BImsJp003370@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Thu, 10 Mar 2005 23:53:40 +0100."
	<20050310225340.GD3205@stusta.de> 
References: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org>
	<20050310225340.GD3205@stusta.de> 
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
Date: Fri, 11 Mar 2005 13:48:54 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

bunk@stusta.de said:
> This patch is still wrong.
> It seems my comment on this [1] was lost:
> <--  snip  -->
> This line has to be something like
> ( (__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4)
> && \
>    HEAVILY_PATCHED_SUSE_GCC ) 

> I hope SuSE has added some #define to distinguish what they call  "gcc
> 3.3.4" from GNU gcc 3.3.4 

It wasn't lost - I am just disinclined to cater to distros making their
gcc lie about its version.

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
