Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DD16D-00047P-2m for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 06:08:13 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DD16B-0003ul-55
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 06:08:12 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20050320150306.GA14594@bytesex>
References: <200503191904.05870.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503191904.05870.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: Supporting building on x86-64 host as 32-bit UML
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
Date: Sun, 20 Mar 2005 16:03:06 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

> 1) how the user must choose what he wants (SUBARCH=i386 can be useful,
> maybe a Kconfig option would be nice - we need to choose the default
> depending on the host arch).

That one is easy -- just use "linux32 make ...".  That will switch the
personality and "uname" will return "i686" instead of "x86_64" then ;)

> 2) using the proper options for the tools (addressed partially by the
> patch below)

Probably still needed.  Maybe not any more with gcc4, I remember there
was some discussion among the gcc folks to make gcc default to -m64 /
-m32 depending on the current personalily.  In that case the linux32
thingy mentioned above should catch that one as well.  Not sure that
actually happened.

> 3) using the proper headers (asm-i386 instead of asm-x86_64)... Fedora

linux32 should fix that one as well.

> +AFLAGS		+= -m32
> +CFLAGS		+= -m32

I think that can also be fixed on the make command line, with a small
wrapper script -- named make32 for example -- doing something like this:

  #!/bin/sh
  exec linux32 make CC="gcc -m32" AS="as -m32" ... "$@"

Last time I tried I ran into the problem that the glibc headers of the
x86_64 biarch compiler slightly different from the ones on a real i386
machine, thus some #ifdefs in uml userspace code didn't work as expected
and broke the build.

> +HOSTCFLAGS	+= -m32
> +HOSTLDFLAGS	+= -m32

Not needed I think.  Thats used for kconfig and other stuff which runs
on the _host_ machine (for cross compiles), thus it doesn't hurt if it
is 64 bit.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
