Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CINnU-0001dd-P2 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Oct 2004 01:50:48 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CINmI-0002im-Hd for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Oct 2004 01:50:48 -0700
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [uml-devel] [patch 1/1] uml: readd linux Makefile target
In-Reply-To: <20041014220554.0F20244BE@zion.localdomain>
Message-ID: <Pine.GSO.4.61.0410151047270.10040@waterleaf.sonytel.be>
References: <20041014220554.0F20244BE@zion.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Fri, 15 Oct 2004 10:49:17 +0200 (MEST)
To: blaisorblade_spam@yahoo.it
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Fri, 15 Oct 2004 blaisorblade_spam@yahoo.it wrote:
> Since people are used to doing "make linux ARCH=um" and to use "linux" as the
> kernel image, make it be an hard link to vmlinux. This should hurt the less
> possible the users (actually nothing) while not slowing down the build.
> 
> Acked-by: Jeff Dike <jdike@addtoit.com>
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
> ---
> 
>  linux-2.6.9-current-paolo/arch/um/Makefile |   12 ++++++++++++
>  1 files changed, 12 insertions(+)
> 
> diff -puN arch/um/Makefile~uml-readd-linux-target arch/um/Makefile
> --- linux-2.6.9-current/arch/um/Makefile~uml-readd-linux-target	2004-10-14 22:52:47.274383552 +0200
> +++ linux-2.6.9-current-paolo/arch/um/Makefile	2004-10-14 22:52:47.276383248 +0200
> @@ -62,6 +62,18 @@ ifeq ($(CONFIG_MODE_SKAS), y)
>  $(SYS_HEADERS) : $(ARCH_DIR)/include/skas_ptregs.h
>  endif
>  
> +all: linux
> +
> +linux: vmlinux
> +	$(RM) $@
> +	ln $< $@
> +
> +define archhelp
> +  echo '* linux		- Binary kernel image (./linux) - for backward'
> +  echo '		   compatibility only: now you can simply run'
> +  echo '		   the vmlinux binary you find in the kernel root.'
> +endef
> +

What happens if you modify the kernel source and rebuild the kernel?
I guess vmlinux gets deleted and replaced, but linux is still the old kernel,
because there's no .phony rule for linux?

What about using a symbolic link instead? It will always point to the most
recent kernel.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
