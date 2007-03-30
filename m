Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HXQEZ-0008Ns-TU for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 16:10:16 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HXQEY-0004Il-7K
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Mar 2007 16:10:15 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 31 Mar 2007 01:10:03 +0200
References: <20070330145255.GA5466@c2.user-mode-linux.org>
In-Reply-To: <20070330145255.GA5466@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200703310110.03985.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 1/2] UML - Fix umid in xterm titles
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, Davide Brini <davide.brini@unibo.it>, LKML <linux-kernel@vger.kernel.org>

On venerd=EC 30 marzo 2007, Jeff Dike wrote:
> From: Davide Brini <davide.brini@unibo.it>
>
> Calls lines_init() *after* xterm_title is modified to include umid.
>
> Signed-off-by: Davide Brini <davide.brini@unibo.it>
> Signed-off-by: Jeff Dike <jdike@linux.intel.com>

Acked-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

> --
>  arch/um/drivers/ssl.c           |    4 ++--
>  arch/um/drivers/stdio_console.c |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> Index: linux-2.6.21-mm/arch/um/drivers/ssl.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.21-mm.orig/arch/um/drivers/ssl.c	2007-03-30
> 10:11:01.000000000 -0400 +++
> linux-2.6.21-mm/arch/um/drivers/ssl.c	2007-03-30 10:28:51.000000000 -0400
> @@ -191,12 +191,12 @@ static int ssl_init(void)
>  	ssl_driver =3D register_lines(&driver, &ssl_ops, serial_lines,
>  				    ARRAY_SIZE(serial_lines));
>
> -	lines_init(serial_lines, ARRAY_SIZE(serial_lines), &opts);
> -
>  	new_title =3D add_xterm_umid(opts.xterm_title);
>  	if (new_title !=3D NULL)
>  		opts.xterm_title =3D new_title;
>
> +	lines_init(serial_lines, ARRAY_SIZE(serial_lines), &opts);
> +
>  	ssl_init_done =3D 1;
>  	register_console(&ssl_cons);
>  	return 0;
> Index: linux-2.6.21-mm/arch/um/drivers/stdio_console.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.21-mm.orig/arch/um/drivers/stdio_console.c	2007-03-30
> 10:11:01.000000000 -0400 +++
> linux-2.6.21-mm/arch/um/drivers/stdio_console.c	2007-03-30
> 10:28:51.000000000 -0400 @@ -166,12 +166,12 @@ int stdio_init(void)
>  		return -1;
>  	printk(KERN_INFO "Initialized stdio console driver\n");
>
> -	lines_init(vts, ARRAY_SIZE(vts), &opts);
> -
>  	new_title =3D add_xterm_umid(opts.xterm_title);
>  	if(new_title !=3D NULL)
>  		opts.xterm_title =3D new_title;
>
> +	lines_init(vts, ARRAY_SIZE(vts), &opts);
> +
>  	con_init_done =3D 1;
>  	register_console(&stdiocons);
>  	return 0;
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel



--=20
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

