Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Ve4E7-0004Pr-6P
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Nov 2013 14:36:59 +0000
Received: from mail-vc0-f177.google.com ([209.85.220.177])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Ve4E6-0006ip-6T
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Nov 2013 14:36:59 +0000
Received: by mail-vc0-f177.google.com with SMTP id ib11so6632209vcb.36
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 06 Nov 2013 06:36:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1383747140.11779.YahooMailBasic@web125303.mail.ne1.yahoo.com>
References: <1383747140.11779.YahooMailBasic@web125303.mail.ne1.yahoo.com>
Date: Wed, 6 Nov 2013 15:36:52 +0100
Message-ID: <CAFLxGvyEd4c=cjoc5S8YkmcwY1fuswsr9cPuF2zsMJymRwS+Hg@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] ARM Status
To: Michael Wolf <anath3ma@yahoo.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Nov 6, 2013 at 3:12 PM, Michael Wolf <anath3ma@yahoo.com> wrote:
> It has been a while so I thought I would re-up the question.   Are there any efforts anywhere to port this to ARM?  If not, are there specific technical blocking issues?

Not really.
If someone *really* wants a arm UML he has to a) invest some money or
b) do it on it's own.

In theory UML on arm should be doable. It may need some thinking
because of VIVT caches.
We'd also need PTRACE_SYSEMU and other ptrace() related stuff.

IIRC Al Viro had some thought regarding an arm port.
Al, can you please enlighten us?


> Thanks,
> mwolf
>
> ------------------------------------------------------------------------------
> November Webinars for C, C++, Fortran Developers
> Accelerate application performance with scalable programming models. Explore
> techniques for threading, error checking, porting, and tuning. Get the most
> from the latest Intel processors and coprocessors. See abstracts and register
> http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel



-- 
Thanks,
//richard

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

