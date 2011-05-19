Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <201105191526.31904.toralf.foerster@gmx.de>
References: <201105191526.31904.toralf.foerster@gmx.de>
Date: Thu, 19 May 2011 19:00:35 +0200
Message-ID: <BANLkTi=FinuAYpYXf1K6pQ-3i2vRJS=g9g@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: kernel 2.6.39 (user mode linux) crashes (2.6.38 works fine)
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi,

Please CC also user-mode-linux-devel@lists.sourceforge.net,
so you can reach much more UML users. :)

2011/5/19 Toralf F=F6rster <toralf.foerster@gmx.de>:
> I got a segfault as soon as I try to access the phpmyadmin web page o=
f the UML
> instance at https://<uml_hostname>/phpmyadmin/ =A0:

Hmm, strange.
phpmyadmin works fine on my UML test bed.
Can you bisect the issue?

--=20
Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

