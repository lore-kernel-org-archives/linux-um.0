Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 19 May 2011 16:43:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Message-ID: <20110519204342.GA10792@home.goodmis.org>
References: <201105191526.31904.toralf.foerster@gmx.de>
 <BANLkTi=FinuAYpYXf1K6pQ-3i2vRJS=g9g@mail.gmail.com>
 <201105192218.18261.toralf.foerster@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <201105192218.18261.toralf.foerster@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: kernel 2.6.39 (user mode linux) crashes (2.6.38 works fine)
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: richard -rw- weinberger <richard.weinberger@gmail.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, May 19, 2011 at 10:18:16PM +0200, Toralf F=F6rster wrote:
>=20
> richard -rw- weinberger wrote at 19:00:35
> > Can you bisect the issue?

Is this bug fully reproducable? If not, then you may have had a git
bisect good, when it should have been git bisect bad.

The futex/plist should not be affecting rwsem.

-- Steve

>=20
> tfoerste@n22 ~/devel/linux-2.6 $ git bisect bad
> 2e12978a9f7a7abd54e8eb9ce70a7718767b8b2c is the first bad commit
> commit 2e12978a9f7a7abd54e8eb9ce70a7718767b8b2c
> Author: Lai Jiangshan <laijs@cn.fujitsu.com>
> Date:   Wed Dec 22 14:18:50 2010 +0800
>=20
>     futex,plist: Pass the real head of the priority list to plist_del=
()
>    =20
>     Some plist_del()s in kernel/futex.c are passed a faked head of th=
e
>     priority list.
>    =20
>     It does not fail because the current code does not require the re=
al head
>     in plist_del(). The current code of plist_del() just uses the hea=
d for=20
> checking,
>     so it will not cause a bad result even when we use a faked head.
>    =20
>     But it is undocumented usage:
>    =20
>     /**
>      * plist_del - Remove a @node from plist.
>      *
>      * @node:   &struct plist_node pointer - entry to be removed
>      * @head:   &struct plist_head pointer - list head
>      */
>    =20
>     The document says that the @head is the "list head" head of the p=
riority=20
> list.
>    =20
>     In futex code, several places use "plist_del(&q->list, &q->list.p=
list);",
>     they pass a fake head. We need to fix them all.
>    =20
>     Thanks to Darren Hart for many suggestions.
>    =20
>     Acked-by: Darren Hart <dvhart@linux.intel.com>
>     Signed-off-by:  Lai Jiangshan <laijs@cn.fujitsu.com>
>     LKML-Reference: <4D11984A.5030203@cn.fujitsu.com>
>     Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
>=20
> :040000 040000 78d47de377f8da1c131007a17ca915fbd13f7ff6=20
> ffac93205aaf22fda0667d6395c8da7c7bf692e4 M      kernel
>=20
> --=20
> MfG/Sincerely
> Toralf F=F6rster
> pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

