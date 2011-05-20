Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Date: Fri, 20 May 2011 11:19:35 +0200
References: <201105191526.31904.toralf.foerster@gmx.de> <201105201058.20355.toralf.foerster@gmx.de> <BANLkTim6yqMipB37Q=OJg=aC89vumCVewg@mail.gmail.com>
In-Reply-To: <BANLkTim6yqMipB37Q=OJg=aC89vumCVewg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Message-Id: <201105201119.36155.toralf.foerster@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: kernel 2.6.39 (user mode linux) crashes (2.6.38 works fine)
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


richard -rw- weinberger wrote at 11:02:35

> I hope it's _exactly_ the same result. vmlinux and linux are hard lin=
ked...
tfoerste@n22 ~/devel/linux-2.6 $ ls -lid vmlinux linux=20
2034205 -rwxr-xr-x 2 tfoerste users 35624874 May 20 09:28 linux
2034205 -rwxr-xr-x 2 tfoerste users 35624874 May 20 09:28 vmlinux


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

