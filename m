Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDpHB-0002YA-ER for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 11:42:53 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DDpH7-0007tr-Ox for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 11:42:53 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: Testing GCOV handling in -bk
References: <200503201242.23591.blaisorblade@yahoo.it>
	<1111402190.24494.12.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1111402190.24494.12.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503222037.39350.blaisorblade@yahoo.it>
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
Date: Tue, 22 Mar 2005 20:37:39 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Anton Altaparmakov <aia21@cam.ac.uk>

On Monday 21 March 2005 11:49, Anton Altaparmakov wrote:
> On Sun, 2005-03-20 at 12:42 +0100, Blaisorblade wrote:
> > Anton, would you test the current -bk tree for the CONFIG_GCOV problem
> > and the patch I and Jeff put together?
> >
> > http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.11-bk8/patche
> >s/weak_gcov_init
> >
> > The above should fix the situation for you... for real 3.4 Gcc, however,
> > the problems are bigger because it also requires to change link flags
> > (and this interferes with some executables we build). I also get a link
> > failure on __bb_fork_<something>..., which I haven't been able to solve
> > until now.
>
> I would test it but UML in current -BK doesn't build at all.  It stops
> with:
>
>   CC      kernel/signal.o
> kernel/signal.c: In function `get_signal_to_deliver':
> kernel/signal.c:1849: error: structure has no member named `eflags'
> kernel/signal.c:1849: error: `TF_MASK' undeclared (first use in this
> function)
> kernel/signal.c:1849: error: (Each undeclared identifier is reported
> only once
> kernel/signal.c:1849: error: for each function it appears in.)
> make[1]: *** [kernel/signal.o] Error 1
> make: *** [kernel] Error 2
>
> Best regards,
>
>         Anton
Ok, watch the patches I'm sending now. The one titled "uml: fix compile" fix 
the above problem, while the one named "uml: real fix for __gcov_init 
symbols" is what I'm merging for this problem (from your results I guess it 
should work well for you too).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
