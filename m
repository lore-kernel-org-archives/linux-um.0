Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fnpQd-0007mI-P3
 for linux-um@lists.infradead.org; Thu, 09 Aug 2018 18:12:57 +0000
Received: by mail-qt0-f194.google.com with SMTP id c15-v6so7600180qtp.0
 for <linux-um@lists.infradead.org>; Thu, 09 Aug 2018 11:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180809174444.31705-1-paul.burton@mips.com>
 <20180809174444.31705-5-paul.burton@mips.com>
In-Reply-To: <20180809174444.31705-5-paul.burton@mips.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 9 Aug 2018 20:12:27 +0200
Message-ID: <CAK8P3a2WVrPc0yu3SXL4qRHsC0C8y=t_4srEy1ELdSBYx4ME=w@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] MIPS: Workaround GCC __builtin_unreachable
 reordering bug
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Paul Burton <paul.burton@mips.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-alpha@vger.kernel.org, linux-um@lists.infradead.org, Ralf Baechle <ralf@linux-mips.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, James Hogan <jhogan@kernel.org>, Matt Turner <mattst88@gmail.com>, Richard Henderson <rth@twiddle.net>

On Thu, Aug 9, 2018 at 7:45 PM Paul Burton <paul.burton@mips.com> wrote:

> +/*
> + * With GCC v4.5 onwards can use __builtin_unreachable to indicate to the
> + * compiler that a particular code path will never be hit. This allows it to be
> + * optimised out of the generated binary.
> + *
> + * Unfortunately GCC from at least v4.9.2 to current head of tree as of May
> + * 2016 suffer from a bug that can lead to instructions from beyond an

Has anything happened to address this in gcc in the meantime?
Could you update this text to reflect whatever is in current gcc-9?

      Arnd

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

