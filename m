Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HYn9M-0007dD-PL for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Apr 2007 10:50:33 -0700
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HYn9H-0007FH-7u
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Apr 2007 10:50:32 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 3 Apr 2007 19:50:16 +0200
References: <20070402165011.GA7616@c2.user-mode-linux.org>
In-Reply-To: <20070402165011.GA7616@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200704031950.17109.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 2/4] UML - tidy process.c
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
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>

On luned=EC 2 aprile 2007, Jeff Dike wrote:
> Clean up arch/um/kernel/process.c -
> 	lots of return(x); -> return x; conversions
> 	a number of the small functions are either unused, in which
> case they are gone, along any declarations in a header, or could be
> made static.

> 	current_pid is ifdefed on CONFIG_MODE_TT and its declaration
> is ifdefed on both CONFIG_MODE_TT and UML_CONFIG_MODE_TT because we
> don't know whether it's being used in a userspace or kernel file.

Please, simply include uml-config.h and use just UML_CONFIG_MODE_TT.

> Index: linux-2.6.21-mm/arch/um/include/kern_util.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.21-mm.orig/arch/um/include/kern_util.h	2007-03-30
> 16:01:21.000000000 -0400 +++
> linux-2.6.21-mm/arch/um/include/kern_util.h	2007-04-02 12:07:48.000000000
> -0400 @@ -33,7 +33,9 @@ extern int nsyscalls;
>  	UML_ROUND_DOWN(((unsigned long) addr) + PAGE_SIZE - 1)
>
>  extern int kernel_fork(unsigned long flags, int (*fn)(void *), void *
> arg); +#if defined(CONFIG_MODE_TT) || defined(UML_CONFIG_MODE_TT)
>  extern unsigned long stack_sp(unsigned long page);
> +#endif
>  extern int kernel_thread_proc(void *data);
>  extern void syscall_segv(int sig);
>  extern int current_pid(void);



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

