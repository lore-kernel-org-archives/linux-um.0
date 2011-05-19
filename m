Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Date: Thu, 19 May 2011 22:18:16 +0200
References: <201105191526.31904.toralf.foerster@gmx.de> <BANLkTi=FinuAYpYXf1K6pQ-3i2vRJS=g9g@mail.gmail.com>
In-Reply-To: <BANLkTi=FinuAYpYXf1K6pQ-3i2vRJS=g9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Message-Id: <201105192218.18261.toralf.foerster@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: kernel 2.6.39 (user mode linux) crashes (2.6.38 works fine)
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


richard -rw- weinberger wrote at 19:00:35
> Can you bisect the issue?

tfoerste@n22 ~/devel/linux-2.6 $ git bisect bad
2e12978a9f7a7abd54e8eb9ce70a7718767b8b2c is the first bad commit
commit 2e12978a9f7a7abd54e8eb9ce70a7718767b8b2c
Author: Lai Jiangshan <laijs@cn.fujitsu.com>
Date:   Wed Dec 22 14:18:50 2010 +0800

    futex,plist: Pass the real head of the priority list to plist_del()
   =20
    Some plist_del()s in kernel/futex.c are passed a faked head of the
    priority list.
   =20
    It does not fail because the current code does not require the real=
 head
    in plist_del(). The current code of plist_del() just uses the head =
for=20
checking,
    so it will not cause a bad result even when we use a faked head.
   =20
    But it is undocumented usage:
   =20
    /**
     * plist_del - Remove a @node from plist.
     *
     * @node:   &struct plist_node pointer - entry to be removed
     * @head:   &struct plist_head pointer - list head
     */
   =20
    The document says that the @head is the "list head" head of the pri=
ority=20
list.
   =20
    In futex code, several places use "plist_del(&q->list, &q->list.pli=
st);",
    they pass a fake head. We need to fix them all.
   =20
    Thanks to Darren Hart for many suggestions.
   =20
    Acked-by: Darren Hart <dvhart@linux.intel.com>
    Signed-off-by:  Lai Jiangshan <laijs@cn.fujitsu.com>
    LKML-Reference: <4D11984A.5030203@cn.fujitsu.com>
    Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

:040000 040000 78d47de377f8da1c131007a17ca915fbd13f7ff6=20
ffac93205aaf22fda0667d6395c8da7c7bf692e4 M      kernel

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

