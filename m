Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 30 Dec 2012 10:40:43 +0100
From: Richard Weinberger <richard@nod.at>
Message-ID: <20121230104043.2090940b@spider.haslach.nod.at>
In-Reply-To: <1356820651-8495-2-git-send-email-slyfox@gentoo.org>
References: <1356820651-8495-1-git-send-email-slyfox@gentoo.org>
	<1356820651-8495-2-git-send-email-slyfox@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 2/2] um: fix build failure due to mess-up of sig_info
 protorype
To: Sergei Trofimovich <slyfox@gentoo.org>
Cc: Jeff Dike <jdike@addtoit.com>, Martin =?UTF-8?B?UMOkcnRlbA==?= <martin.partel@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Sun, 30 Dec 2012 01:37:31 +0300
schrieb Sergei Trofimovich <slyfox@gentoo.org>:

> arch/um/os-Linux/signal.c:18:8: error: conflicting types for
> 'sig_info' In file included
> from /home/slyfox/linux-2.6/arch/um/os-Linux/signal.c:12:0:
> arch/um/include/shared/as-layout.h:64:15: note: previous declaration
> of 'sig_info' was here
>=20
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> CC: Jeff Dike <jdike@addtoit.com>
> CC: Richard Weinberger <richard@nod.at>
> CC: "Martin P=C3=A4rtel" <martin.partel@gmail.com>
> CC: Al Viro <viro@zeniv.linux.org.uk>
> CC: user-mode-linux-devel@lists.sourceforge.net
> CC: user-mode-linux-user@lists.sourceforge.net
> CC: linux-kernel@vger.kernel.org
> ---

I think both patches need to be backported to -stable.
I'll add the tag and push the patches ASAP to Linus.

Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

