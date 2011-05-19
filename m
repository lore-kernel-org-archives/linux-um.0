Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Date: Thu, 19 May 2011 19:20:44 +0200
References: <201105191526.31904.toralf.foerster@gmx.de> <BANLkTi=FinuAYpYXf1K6pQ-3i2vRJS=g9g@mail.gmail.com>
In-Reply-To: <BANLkTi=FinuAYpYXf1K6pQ-3i2vRJS=g9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Message-Id: <201105191920.44596.toralf.foerster@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: kernel 2.6.39 (user mode linux) crashes (2.6.38 works fine)
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


richard -rw- weinberger wrote at 19:00:35
> Hi,
>=20
> Please CC also user-mode-linux-devel@lists.sourceforge.net,
> so you can reach much more UML users. :)
>=20
> 2011/5/19 Toralf F=F6rster <toralf.foerster@gmx.de>:
> > I got a segfault as soon as I try to access the phpmyadmin web page=
 of
> > the UML
>=20
> > instance at https://<uml_hostname>/phpmyadmin/  :
> Hmm, strange.
> phpmyadmin works fine on my UML test bed.
> Can you bisect the issue?

Errm, automatic bisecting doesn't work, b/c the issue can't be reproduc=
ed by a=20
simple "wget https://..." - when I use konqueror - up to 6-10 times I'm=
 asked=20
to confirm a cookie or something else before the crash occures.

And if I use "lynx -accept_all_cookies https://n22_uml/phpmyadmin/" the=
n I'm=20
able to login - so it has something to do with HTTP frames I suspected =
- but a=20
shutdown of the UML instance wasn't possible too after such a try - pro=
bably=20
something else then the HTTP frames itself triggers the issue ...

In short -  it is not phpmyadmin (3.4.0) itself, but it triggers the bu=
g (in=20
fact sometimes I even could see the login window within Firefox of the=20
phpmyadmin site before the crash happened).

Because therefore manual interaction is needed (or do you know an autom=
ated=20
way for konqueror/ff/.... ?) at least it would be helpful if the bisect=
ing=20
could be narrowed doesn to a given path or somethign else.

--=20
MfG/Sincerely
Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

