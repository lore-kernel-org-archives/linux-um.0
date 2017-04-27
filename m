Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1d3s8P-0005pe-37
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Apr 2017 22:43:37 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d3s8M-0000m0-JP
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Apr 2017 22:43:37 +0000
References: <149326283034.18877.3371130154502733533.stgit@devbox>
	<149326290055.18877.8217119813162466170.stgit@devbox>
	<5ca2f3ce-eba3-d306-b52f-061361c59bb1@nod.at>
	<20170428070414.50ace979df068df258ba92ce@kernel.org>
	<20170428074039.7b95c958b7e156594db1f096@kernel.org>
From: Richard Weinberger <richard@nod.at>
Message-ID: <45e67cbb-077e-ffdd-a363-511e71f6ad1a@nod.at>
Date: Fri, 28 Apr 2017 00:43:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170428074039.7b95c958b7e156594db1f096@kernel.org>
Subject: Re: [uml-devel] [PATCH] um: Fix to call read_initrd after
	init_bootmem
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Masami,

Am 28.04.2017 um 00:40 schrieb Masami Hiramatsu:
> Finally, git bisect shows that below commit caused this issue.
> 
> b63236972e1344b247750451e2be0a06cd125f21 is the first bad commit
> commit b63236972e1344b247750451e2be0a06cd125f21
> Author: Richard Weinberger <richard@nod.at>

Meh, it's always me. ;-)

> 
> For the stable, any kernel later than v4.8 has this issue.

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

