Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6a3T-0006fM-Pj for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 12:30:31 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C6a3T-00083T-1S for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2004 12:30:31 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] glibc and NPTL, problem, workarounds, etc.
References: <Pine.LNX.4.58.0409081440150.3136@sparrow>
	<200409122020.51479.blaisorblade_spam@yahoo.it>
	<20040912190258.GA7818@taniwha.stupidest.org>
In-Reply-To: <20040912190258.GA7818@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409122127.12738.blaisorblade_spam@yahoo.it>
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
Date: Sun, 12 Sep 2004 21:27:12 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Chris Wedgwood <cw@f00f.org>, William Stearns <wstearns@pobox.com>

On Sunday 12 September 2004 21:02, Chris Wedgwood wrote:
> On Sun, Sep 12, 2004 at 08:20:51PM +0200, BlaisorBlade wrote:
> > There is another patch which should make the work - (I never tested
> > it, but it should work). Basically, uname will state it is a "i586"
> > rather than "i686",
> > so NPTL is not enabled:

> > http://www.suse.de/~kraxel/uml/patches/uml-pretend-to-be-i586

> This apparently only works because people[1] ship either i386 or i686
> libc and only the latter has NPTL support --- but there is nothing
> preventing i586 NPTL support in the future...
Are you sure? I remember that NPTL needs using some new instructions of i686
(maybe CMOVxx) for futexes, to be atomic. 
However, if I'm wrong, we could even pretend to be i386.
>   --cw

> [1] RH & Debian checked, maybe this isn't true for gentoo in which
>     case it will break there?

Well, you compile Gentoo for your own processor - you might maybe even enable 
-mregparm for everything (which even breaks binary compatibility everything). 
I guess if you build Gentoo on an i386, it will either refuse to build or 
build an i386 glibc. Otherwise, it does not make sense for them to ship i386 
glibc.

That said, you must just be careful when building the guest root_fs, with 
Gentoo.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
