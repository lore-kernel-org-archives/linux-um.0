Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <malattia@linux.it>) id 1bNiOA-0003uD-Gw
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2016 15:17:22 +0000
Received: from picard.linux.it ([213.254.12.146])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bNiO9-0001wx-FP
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2016 15:17:22 +0000
Date: Thu, 14 Jul 2016 08:17:09 -0700
From: Mattia Dongili <malattia@linux.it>
Message-ID: <20160714151709.GC11969@taihen.jp>
References: <20160713030256.GA26654@taihen.jp>
	<CAFLxGvyhO87SvLn5ofPMGobT6Y27vA-yzC7KxdVe_h6GPB+6Pg@mail.gmail.com>
	<20160714030836.GA1538@taihen.jp> <57874E5D.9030906@nod.at>
	<20160714150731.GB11969@taihen.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160714150731.GB11969@taihen.jp>
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
To: Richard Weinberger <richard@nod.at>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Jul 14, 2016 at 08:07:32AM -0700, Mattia Dongili wrote:
> On Thu, Jul 14, 2016 at 10:33:33AM +0200, Richard Weinberger wrote:
> > 
> > 
> > Am 14.07.2016 um 05:08 schrieb Mattia Dongili:
> ...
> > > I can certainly help with that, since I would like to do that work
> > > anyway in order to refresh the debian package. If you want to stuff the
> > > code in a git repository I can send patches in.
> > 
> > That would be great!
> > 
> > Step one would be converting the CVS repo to git:
> > http://user-mode-linux.cvs.sourceforge.net/viewvc/user-mode-linux/tools/
> > 
> > Can you do that?
> 
> Here's what I got:
> https://github.com/malattiad/uml-utilities

This is now:
https://github.com/malattia/uml-utilities

> The CVS repo on sourceforge is out of date though, it's missing a good
> chunk of code. The last commit is from 2004 or so.
> 
> If you don't have the remainder of the code history I can import a
> single commit with the delta to the latest tarball.
> 
> Also, I used this author conversion:
> jdike=Jeff Dike <jdike@addtoit.com>
> jleu=James R. Leu <jleu@mindspring.com>
> 
> -- 
> mattia
> :wq!
> 
> ------------------------------------------------------------------------------
> What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
> patterns at an interface-level. Reveals which users, apps, and protocols are 
> consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
> J-Flow, sFlow and other flows. Make informed decisions using capacity planning
> reports.http://sdm.link/zohodev2dev
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
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

