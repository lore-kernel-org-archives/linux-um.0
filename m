Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rob@landley.net>) id 1LOh5O-0004s2-MH
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2009 23:29:46 +0000
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]
	helo=grelber.thyrsus.com) by 72vjzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1LOh5F-00013K-Pn
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2009 23:29:46 +0000
From: Rob Landley <rob@landley.net>
Date: Sun, 18 Jan 2009 17:29:30 -0600
References: <20090115194033.GA10926@hack.private>
	<200901170328.15178.rob@landley.net>
	<20090118083237.GA3292@hack.private>
In-Reply-To: <20090118083237.GA3292@hack.private>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200901181729.31682.rob@landley.net>
Subject: Re: [uml-devel] [Patch] uml: fix a link error
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
To: =?iso-8859-1?q?Am=E9rico_Wang?= <xiyou.wangcong@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sunday 18 January 2009 02:32:37 Am=E9rico Wang wrote:
> >The result panics (twice) and exits, instead of giving me a shell prompt.
> >Built and run on stock Ubuntu 8.10.  (I posted about it on tuesday, but
> > nobody replied...)
>
> Hi, Rob.
>
> I tried what you said, it works very fine here, on my Fedora 10.
> Could you please tell us which kernel your host is using?

Ubuntu 8.10 stock kernel, calls itself "2.6.27-9-generic".

> and the guest?

Checking tuesday's bug report, it said:

> Linux version 2.6.28 (landley@driftwood) (gcc version 4.3.2 (Ubuntu =

> 4.3.2-1ubuntu11) ) #6 Tue Jan 13 01:54:34 CST 2009

It's the vanilla tarball (albeit extracted from source control according to =

the v2.6.28 tag rather than downloaded).

Possibly a gcc 4.3 issue?

Rob

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
