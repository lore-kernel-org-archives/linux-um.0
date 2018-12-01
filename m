Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-06.nifty.com ([210.131.2.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT6h5-0004ob-Sg
 for linux-um@lists.infradead.org; Sat, 01 Dec 2018 14:56:33 +0000
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
 [209.85.217.42]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id wB1EtwoC015409
 for <linux-um@lists.infradead.org>; Sat, 1 Dec 2018 23:55:59 +0900
Received: by mail-vs1-f42.google.com with SMTP id b74so5076971vsd.9
 for <linux-um@lists.infradead.org>; Sat, 01 Dec 2018 06:55:58 -0800 (PST)
MIME-Version: 1.0
References: <1543220141-13744-1-git-send-email-yamada.masahiro@socionext.com>
 <20181126083633.GA10604@light.dominikbrodowski.net>
In-Reply-To: <20181126083633.GA10604@light.dominikbrodowski.net>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 1 Dec 2018 23:55:22 +0900
Message-ID: <CAK7LNASVcFj2-ooroLsyZgpVyv_xW1RJCkVtayg7sNxVjvHN=A@mail.gmail.com>
Subject: Re: [PATCH] pcmcia: remove per-arch PCMCIA config entry
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
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Christoph Hellwig <hch@lst.de>

On Mon, Nov 26, 2018 at 6:24 PM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> On Mon, Nov 26, 2018 at 05:15:41PM +0900, Masahiro Yamada wrote:
> > Now that all architectures include drivers/pcmcia/Kconfig where
> > the PCMCIA config is defined, the PCMCIA config entries in per-arch
> > Kconfig files are redundant.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> > I will queue this up to my kbuild tree
> > along with Christoph's clean-up patch set.
>
> Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
>
> Thanks,
>         Dominik

Applied to linux-kbuild.


-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

