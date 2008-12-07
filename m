Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hannes@cmpxchg.org>) id 1L9Pjv-0001uy-OQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Dec 2008 19:56:27 +0000
Received: from cmpxchg.org ([85.214.51.133])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L9Pjt-0001W4-A1
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 07 Dec 2008 19:56:27 +0000
Date: Sun, 7 Dec 2008 20:55:38 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
Message-ID: <20081207195537.GA24808@cmpxchg.org>
References: <2375c9f90812021451hfd77292yf2463ca99d07b88e@mail.gmail.com>
	<20081203012051.GA8953@cmpxchg.org>
	<2375c9f90812030432m771984edkdd0c599bbae9bb3c@mail.gmail.com>
	<20081203134035.GA17560@cmpxchg.org>
	<2375c9f90812051702m217ee049i79ce2f9cc8280fb1@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2375c9f90812051702m217ee049i79ce2f9cc8280fb1@mail.gmail.com>
Subject: Re: [uml-devel] [Patch] uml: drop const qualifier for kernel_execve()
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: =?iso-8859-1?Q?Am=E9rico?= Wang <xiyou.wangcong@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, jdike@addtoit.com, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Sat, Dec 06, 2008 at 01:02:16AM +0000, Am=E9rico Wang wrote:
> On Wed, Dec 3, 2008 at 1:40 PM, Johannes Weiner <hannes@cmpxchg.org> wrot=
e:
> > On Wed, Dec 03, 2008 at 12:32:02PM +0000, Am=E9rico Wang wrote:
> >> On Wed, Dec 3, 2008 at 1:20 AM, Johannes Weiner <hannes@cmpxchg.org> w=
rote:
> >> > On Tue, Dec 02, 2008 at 10:51:09PM +0000, Am=E9rico Wang wrote:
> >> >> UML implementation of kernel_execve() should not have const qualifi=
er,
> >> >> because it will finally call do_execve() which doesn't have.
> >> >
> >> > And you made sure that do_execve() is correctly annotated?
> >> >
> >>
> >> Yes, I checked that.
> >
> > Good.  Then please fix up do_execve() or let the warning stand out as
> > a reminder.
> =

> ??
> Confused...
> =

> do_execve() is OK, we don't need to fix it.

I don't see where it writes through @filename.  So it seems the right
fix would be to make do_execve()s parameter const (and as it seems, a
lot more adjustments down this call graph) and not remove a correct
const from a callsite.

	Hannes

---------------------------------------------------------------------------=
---
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
