Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJkww-0002Ok-MW for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 21:18:30 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DJkws-00039m-K6 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 21:18:30 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: BUG with proposed fix Re: [uml-devel] Can't compile under vanilla
	2.6.11
References: <cbec11ac05031719187cb8e7d2@mail.gmail.com>
	<200503241203.57593.blaisorblade@yahoo.it>
	<cbec11ac05040721047a6dea90@mail.gmail.com>
In-Reply-To: <cbec11ac05040721047a6dea90@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504080624.38124.blaisorblade@yahoo.it>
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
Date: Fri, 8 Apr 2005 06:24:37 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Ian McDonald <imcdnzl@gmail.com>
Cc: Rob Landley <rob@landley.net>

On Friday 08 April 2005 06:04, Ian McDonald wrote:
> On Mar 24, 2005 11:03 PM, Blaisorblade <blaisorblade@yahoo.it> wrote:
> > On Monday 21 March 2005 06:30, Ian McDonald wrote:
> > > The other problem with not linking va_copy has been resolved by
> > > changing to __va_copy in skas/uaccess.c. This seems to be a known
> > > problem with older compilers and there is a patch out there but not in
> > > 2.6.11 or by the looks of it 2.6.12 rc1 by my reading of the log (nor
> > > for one for my previous e-mail)
> >
> > Ok, I'm taking that patch and merging it in my tree and in 2.6.12. I hope
> > it can go also in 2.6.11.6 (or .7, whatever).
> >
> > --
> > Paolo Giarrusso, aka Blaisorblade
> > Linux registered user n. 292729
> > http://www.user-mode-linux.org/~blaisorblade
>
> Here is an update:
> 2.6.12-rc2 has both va_copy patch and syscall patch and works for me
> once a patch is applied to arch/um/kernel/Makefile for some sed syntax
> 2.6.11.7 has va_copy patch only and works for me once I apply the
> syscall patch that I started and Paolo made much better.
I've sent it for merging, and I hope it will be in .8.
> Environment is Debian Woody, gcc 2.95.4, sed 3.02
>
> Thanks again for all involved in helping me to this state.
I'll put these changes also in the -bs tree. Actually, -bs1 should work for 
you because has the syscall and va_copy changes; -bb2 does not work because I 
merged the sed usage which bites you.

I'll now merge the sed fix for -bs3.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
