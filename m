Return-Path: <jdike@addtoit.com>
Date: Mon, 13 Jul 2015 11:13:41 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20150713151341.GA4474@parts.user-mode-linux.org>
References: <DUB128-W4287C49CC298A43BB8A3409C9C0@phx.gbl>
 <55A3A5E0.8030802@nod.at>
 <DUB128-W657ACA17D13F07E1D42A339C9C0@phx.gbl>
 <CAMuHMdUjwQF3Lhcyo0L_TNGECtKMbOdDp+fixiyj=Svw7XeuXg@mail.gmail.com>
 <DUB128-W57E673D474548BF61C14F09C9C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DUB128-W57E673D474548BF61C14F09C9C0@phx.gbl>
Subject: Re: [uml-devel] linux-4.2-rc2/arch/um/drivers/net_user.c:258:
 possible missing call to va_end ?
To: David Binderman <dcb314@hotmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard@nod.at>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

> Since you've been so nice about it, here is my umpteenth go at a
> linux kernel patch.

Just eyeballing it, that looks right to me.  It just needs your
original bug report above the Signed-off-by.

				Jeff
-- 
Jeff Dike
AddToIt
978-254-0789 (o)
978-394-8986 (c)

