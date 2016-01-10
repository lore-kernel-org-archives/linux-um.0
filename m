Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] um: link with -lpthread
References: <1451577977-12990-1-git-send-email-vegard.nossum@oracle.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <5692BB84.5060106@nod.at>
Date: Sun, 10 Jan 2016 21:13:56 +0100
MIME-Version: 1.0
In-Reply-To: <1451577977-12990-1-git-send-email-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Lorenzo Colitti <lorenzo@google.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 31.12.2015 um 17:06 schrieb Vegard Nossum:
> Similarly to commit fb1770aa78a43530940d0c2dd161e77bc705bdac, with gcc 5
> on Ubuntu and CONFIG_STATIC_LINK=y I was seeing these linker errors:
> 
> /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/librt.a(timer_create.o): In function `__timer_create_new':
> (.text+0xcd): undefined reference to `pthread_once'
> /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/librt.a(timer_create.o): In function `__timer_create_new':
> (.text+0x126): undefined reference to `pthread_attr_init'
> /usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/librt.a(timer_create.o): In function `__timer_create_new':
> (.text+0x168): undefined reference to `pthread_attr_setdetachstate'
> [...]
> 
> Obviously we also need -lpthread for librt.a.
> 
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>

Applied!

Thanks,
//richard

