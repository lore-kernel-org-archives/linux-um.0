Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZvrl-000335-1v for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Dec 2004 10:39:45 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CZvrj-0001mt-6O for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 02 Dec 2004 10:39:44 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] 2.6.9-bb3 on 2.6.9 host problem - triggering a host
	bug?
References: <200411292315.25368.blaisorblade_spam@yahoo.it>
	<200411301950.13529.blaisorblade_spam@yahoo.it>
	<41AE160D.3030807@fujitsu-siemens.com>
In-Reply-To: <41AE160D.3030807@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412021942.49285.blaisorblade_spam@yahoo.it>
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
Date: Thu, 2 Dec 2004 19:42:48 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Wednesday 01 December 2004 20:05, Bodo Stroesser wrote:
> Blaisorblade wrote:
> > On Monday 29 November 2004 23:15, Blaisorblade wrote:
> >
> > I pressed Enter before filling in details - this is what I get on some
> > UML versions at startup. Specifically, I get it on -bb3, and on versions
> > based on it, on startup. I've tried removing the patches I've added to
> > -bb3 and it still does not work, which is not nice.
>
> Have started to analyze the crash. If I did it right, the crash occurs at
> the beginning of kmem_cache_alloc(). It seems to be called with argument
> NULL as the pointer to the cache --> segfault.

> Hope, this helps.

> Bodo

Well, this crash (or something such) is easily repeatable if you disable TT 
mode when building and enable CONFIG_STATIC_LINK.

It is related, probably, either to some patches which went in *after* 
2.6.7-1um (at that time, there was still a separate patch to apply on top of 
the corrisponding kernel), or to some problems with the toolchain. I should 
build a 2.6.7-1um kernel with STATIC_LINK to verify that it works (and then 
that we broke it) or that it doesn't (and then it's the toolchain/build env), 
but I keep forgetting to do it.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
