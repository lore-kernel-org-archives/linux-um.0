Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFKkh-0003rK-QI for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Apr 2004 15:27:03 -0700
Received: from linuxhacker.ru
	([217.76.32.60] helo=shrek.linuxhacker.ru ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BFKkh-0002Oz-6b
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Apr 2004 15:27:03 -0700
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [uml-devel] Re: [PATCH] Fix for annoying problem with hostfs
	readdir problems.
Message-ID: <20040418222620.GA1779@linuxhacker.ru>
References: <20040415210318.GA205486@linuxhacker.ru>
	<20040415214629.GB207748@linuxhacker.ru>
	<200404181726.23698.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404181726.23698.blaisorblade_spam@yahoo.it>
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
Date: Mon, 19 Apr 2004 01:26:20 +0300
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: jdike@karaya.com, user-mode-linux-devel@lists.sourceforge.net

Hello!

On Sun, Apr 18, 2004 at 05:26:23PM +0200, BlaisorBlade wrote:
> > >    So the annoying problem with readdir not working on hostfs (on 2.6
> > > host kernel only for me) was finally hunted to memory allocation
> > >    problem during opendir.
> I've experienced it too onto 2.6 and someone else had the same problem - but 
> that patch is not perfect. Using always vmalloc() instead of kmalloc() is 
> wrong - vmalloc is slower, and Linus spoke against vmalloc(); it would also 
> slow down everything using malloc().

Well, speed is not of much an issue there, that function is only used for
glibc allocations. And that read_dir() is probably the only place that
causes glibc to allocate something.

> Probably you should use vmalloc() only if size is > the size limit (if this is 
> the problem, as I guess). When you come at free() it is a bit hard, but IIRC 
> vmalloc() can return pointers inside a certain, known memory area, right? So 
> it is possible to understand what function to call.

I am sure that all of the complexity you propose to implement won't pay off in
the end.

Bye,
    Oleg


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
