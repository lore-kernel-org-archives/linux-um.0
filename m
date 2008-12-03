Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hannes@cmpxchg.org>) id 1L7ryo-0005HV-Oq
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Dec 2008 13:41:26 +0000
Received: from cmpxchg.org ([85.214.51.133])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1L7ryf-00083C-Dk
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Dec 2008 13:41:26 +0000
Date: Wed, 3 Dec 2008 14:40:35 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
Message-ID: <20081203134035.GA17560@cmpxchg.org>
References: <2375c9f90812021451hfd77292yf2463ca99d07b88e@mail.gmail.com>
	<20081203012051.GA8953@cmpxchg.org>
	<2375c9f90812030432m771984edkdd0c599bbae9bb3c@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2375c9f90812030432m771984edkdd0c599bbae9bb3c@mail.gmail.com>
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

On Wed, Dec 03, 2008 at 12:32:02PM +0000, Am=E9rico Wang wrote:
> On Wed, Dec 3, 2008 at 1:20 AM, Johannes Weiner <hannes@cmpxchg.org> wrot=
e:
> > On Tue, Dec 02, 2008 at 10:51:09PM +0000, Am=E9rico Wang wrote:
> >> UML implementation of kernel_execve() should not have const qualifier,
> >> because it will finally call do_execve() which doesn't have.
> >
> > And you made sure that do_execve() is correctly annotated?
> >
> =

> Yes, I checked that.

Good.  Then please fix up do_execve() or let the warning stand out as
a reminder.

	Hannes

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
