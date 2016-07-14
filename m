Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <malattia@linux.it>) id 1bNX19-00086D-8W
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2016 03:08:51 +0000
Received: from picard.linux.it ([213.254.12.146])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bNX17-0003PU-3o
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2016 03:08:51 +0000
Date: Wed, 13 Jul 2016 20:08:37 -0700
From: Mattia Dongili <malattia@linux.it>
Message-ID: <20160714030836.GA1538@taihen.jp>
References: <20160713030256.GA26654@taihen.jp>
	<CAFLxGvyhO87SvLn5ofPMGobT6Y27vA-yzC7KxdVe_h6GPB+6Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFLxGvyhO87SvLn5ofPMGobT6Y27vA-yzC7KxdVe_h6GPB+6Pg@mail.gmail.com>
Subject: Re: [uml-devel] UML tools anywhere?
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
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Jul 13, 2016 at 11:11:03PM +0200, Richard Weinberger wrote:
> Hi!
> 
> On Wed, Jul 13, 2016 at 5:02 AM, Mattia Dongili <malattia@linux.it> wrote:
> > Hi,
> >
> > Does anybody knows if there is any newer version of the tools package
> > (the one with tunctl, uml_mount and friends)?
> >
> > I'm maintaining[1] the package in Debian and I was wondering whether the
> > original code is hosted somewhere.
> 
> http://user-mode-linux.sourceforge.net/old/dl-sf.html
> 
> There is no newer version.

Ha! interesting. I even have a 20070815 (and others post-2004) version
that is not on that page. I'm wondering how I got that, maybe just a
snapshot off of CVS.

> Do you have a list of issues in the current utilities?

There are some in the Debian bug tracking system, some (most?) are related to
packaging issues though[1].

> Maybe I should take this as chance to convert them to git and make
> a new release.

Well my number one wishlist item would be to change the hand rolled
makefile to something more maintainable where if I have to pass, say,
LDFLAGS, it'll get honoured by all tools.

I can certainly help with that, since I would like to do that work
anyway in order to refresh the debian package. If you want to stuff the
code in a git repository I can send patches in.

[1]:
https://bugs.debian.org/cgi-bin/pkgreport.cgi?archive=0;dist=unstable;ordering=normal;repeatmerged=0;src=uml-utilities

Thanks!
-- 
mattia
:wq!

------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

