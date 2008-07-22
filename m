Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KLDV7-0004y7-HM for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jul 2008 01:45:44 -0700
Received: from an-out-0708.google.com ([209.85.132.240])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KLDV4-000706-8h
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Jul 2008 01:45:40 -0700
Received: by an-out-0708.google.com with SMTP id b21so443974ana.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 22 Jul 2008 01:45:37 -0700 (PDT)
Message-ID: <804dabb00807220145y375eaaefk5a352046d5e944d7@mail.gmail.com>
Date: Tue, 22 Jul 2008 16:45:35 +0800
From: "Peter Teoh" <htmldeveloper@gmail.com>
In-Reply-To: <20080721154658.GA6860@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <20080721154658.GA6860@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] Fix for 2.6.26 ptrace crash
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: David Shane Holden <dpejesh@yahoo.com>, "david.r" <david.r@seznam.cz>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>

Thanks, the patch worked for me too.

As an aside, may be u would want to sync with mainline:

http://lkml.org/lkml/2007/5/3/460

which would solve the problem Boaz posed as well?

(the patch above seemed to indicate a problem of post-3.4 vs pre-3.4 GCC:

http://www.gnu.org/software/gcc/gcc-3.4/changes.html

but your patch indicated something to do with 4.x GCC vs pre-3.4 GCC?)

Sorry if I don't get it correctly :-).

On Mon, Jul 21, 2008 at 11:46 PM, Jeff Dike <jdike@addtoit.com> wrote:
> I believe I figured out the ptrace crash that showed up with 2.6.26,
> thanks to Toralf F=F6rster.
>
> The patch is below.
>
> I have one confirmation that this fixes the problem - I'd like a few
> more just to be sure.
>
>                        Jeff
>
> --
> Work email - jdike at linux dot intel dot com
>
> Index: linux-2.6.22/arch/um/include/init.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.22.orig/arch/um/include/init.h    2008-02-18 11:53:50.00000=
0000 -0500
> +++ linux-2.6.22/arch/um/include/init.h 2008-07-20 18:06:35.000000000 -04=
00
> @@ -45,6 +45,8 @@ typedef void (*exitcall_t)(void);
>  # define __section(S) __attribute__ ((__section__(#S)))
>  #endif
>
> +#if __GNUC__ =3D=3D 3
> +
>  #if __GNUC_MINOR__ >=3D 3
>  # define __used                        __attribute__((__used__))
>  #else
> @@ -52,6 +54,12 @@ typedef void (*exitcall_t)(void);
>  #endif
>
>  #else
> +#if __GNUC__ =3D=3D 4
> +# define __used                        __attribute__((__used__))
> +#endif
> +#endif
> +
> +#else
>  #include <linux/compiler.h>
>  #endif
>  /* These are for everybody (although not all archs will actually
>



-- =

Regards,
Peter Teoh

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
