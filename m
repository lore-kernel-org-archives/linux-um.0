Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EbMm3-00086v-0z for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Nov 2005 10:40:19 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EbMm1-00066R-OX
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Nov 2005 10:40:19 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH] Ok, I build x86-64 -skas0,
	and it still segfaults.
Message-ID: <20051113193256.GA25736@ccure.user-mode-linux.org>
References: <200511121936.41697.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511121936.41697.rob@landley.net>
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
Date: Sun, 13 Nov 2005 14:32:56 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Nov 12, 2005 at 07:36:41PM -0600, Rob Landley wrote:
> Stub registers -
>         0 - 9090909090909090
>         1 - 9090909090909090
>         2 - 9090909090909090
>         3 - 9090909090909090
>         4 - 9090909090909090
>         5 - 9090909090909090
>         6 - 9090909090909090
>         7 - 9090909090909090
>         8 - 9090909090909090
>         9 - 9090909090909090
>         10 - 0
>         11 - 9090909090909090
>         12 - 9090909090909090
>         13 - 9090909090909090
>         14 - 9090909090909090
>         15 - ffffffffffffffff
>         16 - 9090909090909090
>         17 - 33
>         18 - 292
>         19 - 9090909090909090
>         20 - 2b

I remain baffled by this.  There is nothing valid there.  At the very least
RSP and RIP should be reasonable, and they're not.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
