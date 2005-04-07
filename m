Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJTzX-0006W9-13 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 03:12:03 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DJTzV-0002PF-2S
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 03:12:02 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Broken compiling under 2.6.12-rc2 on my machine
References: <cbec11ac050405205173f18157@mail.gmail.com>
	<200504062136.26895.blaisorblade@yahoo.it>
	<cbec11ac05040616556d6a71d8@mail.gmail.com>
In-Reply-To: <cbec11ac05040616556d6a71d8@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200504070408.30964.rob@landley.net>
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
Date: Thu, 7 Apr 2005 04:08:30 -0400
To: Ian McDonald <imcdnzl@gmail.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Wednesday 06 April 2005 07:55 pm, Ian McDonald wrote:
> > As you see, there is a fourth expression, *here*. But it's -e '}'.
> >
> > This patch went in after 2.6.11, I'm noticing - wow, are releases getting
> > so slow?
> >
> > > > System is Debian Woody,
> >
> > Can you post your sed version? and Rob, can you then test it and fix the
> > code?
>
> GNU sed version 3.02

According to this:

ftp://ftp.gnu.org/gnu/sed

That's from august 1998.  It's even older than gcc 2.95, the tarball of which 
contains files dated 7/29/99 (a full year later).  Saying we should support 
that is roughly equivalent to saying we should be able to build with gcc 
2.8.1, the compiler that was released six months before that was.

That said, the change I posted earlier would probably make it work.  The 
question is, do we care?   Documentation/Changes doesn't list a required sed 
version (even though other things in the kernel build use it), but perhaps it 
should.

> > > > And UML does compile under 2.6.11 with a patch for gcc
> >
> > The __va_copy fix, right? I'm trying to merge that in 2.6.11.7, it's
> > under review. The only problem is that somebody complains about the fact
> > Linux still supports 2.95. Luckily for you, Linus already shut them off
> > once, so the support won't go away soon.
>
> Yes lucky for me as I don't have root access to my box here and can't
> alter....

Documentation/Changes says the kernel actually requires gcc 2.95.3, which has 
the newest file on 3/16/2001.

Not my call, and I posted a fix that should work on the ancient stuff (I'm 
curious if it actually does).  It's not a hard fix at all, just pointing out 
some context...

Rob


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
