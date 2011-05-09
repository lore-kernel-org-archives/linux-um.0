MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <BANLkTik-ouZ1a1fBJNwYsOjF0ve2ucbTig@mail.gmail.com>
References: <3030427.400951304580864978.JavaMail.www@wsfrf1110>
	<BANLkTimDwsBk-MvFFABgf0kzx3WHkt6uMA@mail.gmail.com>
	<4DC4398C.2070307@fnac.net>
	<BANLkTik-ouZ1a1fBJNwYsOjF0ve2ucbTig@mail.gmail.com>
Date: Mon, 9 May 2011 09:20:26 +0200
Message-ID: <BANLkTikMmpQr=ZSC6tzNOytEozkQKejZBQ@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] for ARCH=um, optionaly give a path for the
 vde installation.
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: Paul Chavent <paul.chavent@fnac.net>, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, May 9, 2011 at 00:08, richard -rw- weinberger
<richard.weinberger@gmail.com> wrote:
> Anyway, your patch makes use of "CFLAGS_vde_user.o",
> where is this variable used?

This syntax is used to specify additional compile options for vde_user.o.

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds

