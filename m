Return-Path: <richard.weinberger@gmail.com>
MIME-Version: 1.0
In-Reply-To: <BANLkTikMmpQr=ZSC6tzNOytEozkQKejZBQ@mail.gmail.com>
References: <3030427.400951304580864978.JavaMail.www@wsfrf1110>
	<BANLkTimDwsBk-MvFFABgf0kzx3WHkt6uMA@mail.gmail.com>
	<4DC4398C.2070307@fnac.net>
	<BANLkTik-ouZ1a1fBJNwYsOjF0ve2ucbTig@mail.gmail.com>
	<BANLkTikMmpQr=ZSC6tzNOytEozkQKejZBQ@mail.gmail.com>
Date: Mon, 9 May 2011 09:39:25 +0200
Message-ID: <BANLkTimjGxusY3LpQ5PHcQK8MTK1DUDZ9Q@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [uml-devel] [PATCH] for ARCH=um, optionaly give a path for the
 vde installation.
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Chavent <paul.chavent@fnac.net>, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, May 9, 2011 at 9:20 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, May 9, 2011 at 00:08, richard -rw- weinberger
> <richard.weinberger@gmail.com> wrote:
>> Anyway, your patch makes use of "CFLAGS_vde_user.o",
>> where is this variable used?
>
> This syntax is used to specify additional compile options for vde_user.o.
>

*headdesk*, thanks for pointing this out!

-- 
Thanks,
//richard

