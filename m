Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDnZo-0005I7-Mm for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 09:54:00 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DDnZn-0005SH-Pf for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 09:54:00 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: Supporting building on x86-64 host as 32-bit UML
References: <200503191904.05870.blaisorblade@yahoo.it>
	<20050320150306.GA14594@bytesex>
In-Reply-To: <20050320150306.GA14594@bytesex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503221853.20853.blaisorblade@yahoo.it>
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
Date: Tue, 22 Mar 2005 18:53:20 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>

On Sunday 20 March 2005 16:03, Gerd Knorr wrote:
> > 1) how the user must choose what he wants (SUBARCH=i386 can be useful,
> > maybe a Kconfig option would be nice - we need to choose the default
> > depending on the host arch).
>
> That one is easy -- just use "linux32 make ...".  That will switch the
> personality and "uname" will return "i686" instead of "x86_64" then ;)
linux32 is a SuSE specific alias like the "i386" for Fedora, right (they both 
alias setarch, IIRC)?
> > 2) using the proper options for the tools (addressed partially by the
> > patch below)
>
> Probably still needed.  Maybe not any more with gcc4, I remember there
> was some discussion among the gcc folks to make gcc default to -m64 /
> -m32 depending on the current personalily.  In that case the linux32
> thingy mentioned above should catch that one as well.  Not sure that
> actually happened.
We're not going to wait gcc4, especially if it is still so memory hungry...
> > 3) using the proper headers (asm-i386 instead of asm-x86_64)... Fedora
>
> linux32 should fix that one as well.
>
> > +AFLAGS  += -m32
> > +CFLAGS  += -m32
>
> I think that can also be fixed on the make command line, with a small
> wrapper script -- named make32 for example -- doing something like this:
>
>   #!/bin/sh
>   exec linux32 make CC="gcc -m32" AS="as -m32" ... "$@"
>
> Last time I tried I ran into the problem that the glibc headers of the
> x86_64 biarch compiler slightly different from the ones on a real i386
> machine, thus some #ifdefs in uml userspace code didn't work as expected
> and broke the build.
>
> > +HOSTCFLAGS += -m32
> > +HOSTLDFLAGS += -m32
>
> Not needed I think.  Thats used for kconfig and other stuff which runs
> on the _host_ machine (for cross compiles), thus it doesn't hurt if it
> is 64 bit.
I'm not sure, but that's probably needed for the userspace utilities that 
print out some headers (with offsets inside host proc. specific structs).
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
