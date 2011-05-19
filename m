Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <201105191920.44596.toralf.foerster@gmx.de>
References: <201105191526.31904.toralf.foerster@gmx.de>
	<BANLkTi=FinuAYpYXf1K6pQ-3i2vRJS=g9g@mail.gmail.com>
	<201105191920.44596.toralf.foerster@gmx.de>
Date: Thu, 19 May 2011 19:25:52 +0200
Message-ID: <BANLkTi=kDHuhKyVxEYWL92pyfLuQWAjtdQ@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: kernel 2.6.39 (user mode linux) crashes (2.6.38 works fine)
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

2011/5/19 Toralf F=F6rster <toralf.foerster@gmx.de>:
> Errm, automatic bisecting doesn't work, b/c the issue can't be reprod=
uced by a
> simple "wget https://..." - when I use konqueror - up to 6-10 times I=
'm asked
> to confirm a cookie or something else before the crash occures.
>
> And if I use "lynx -accept_all_cookies https://n22_uml/phpmyadmin/" t=
hen I'm
> able to login - so it has something to do with HTTP frames I suspecte=
d - but a
> shutdown of the UML instance wasn't possible too after such a try - p=
robably
> something else then the HTTP frames itself triggers the issue ...
>
> In short - =A0it is not phpmyadmin (3.4.0) itself, but it triggers th=
e bug (in
> fact sometimes I even could see the login window within Firefox of th=
e
> phpmyadmin site before the crash happened).
>
> Because therefore manual interaction is needed (or do you know an aut=
omated
> way for konqueror/ff/.... ?) at least it would be helpful if the bise=
cting
> could be narrowed doesn to a given path or somethign else.

BTW: Haven=92t you had such an issue a few months ago?
Does it work without https? Maybe mod_ssl triggers the bug...

--=20
Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

