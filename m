Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6Zcx-00082I-5B for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 12:03:07 -0700
Received: from pimout1-ext.prodigy.net ([207.115.63.77])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C6Zcv-0001SS-5T for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 12:03:07 -0700
From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [uml-devel] glibc and NPTL, problem, workarounds, etc.
Message-ID: <20040912190258.GA7818@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0409081440150.3136@sparrow>
	<200409122020.51479.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409122020.51479.blaisorblade_spam@yahoo.it>
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
Date: Sun, 12 Sep 2004 12:02:58 -0700
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, William Stearns <wstearns@pobox.com>

On Sun, Sep 12, 2004 at 08:20:51PM +0200, BlaisorBlade wrote:

> There is another patch which should make the work - (I never tested
> it, but it should work). Basically, uname will state it is a "i586"
> rather than "i686",
> so NPTL is not enabled:
>
> http://www.suse.de/~kraxel/uml/patches/uml-pretend-to-be-i586

This apparently only works because people[1] ship either i386 or i686
libc and only the latter has NPTL support --- but there is nothing
preventing i586 NPTL support in the future...

  --cw

[1] RH & Debian checked, maybe this isn't true for gentoo in which
    case it will break there?


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
