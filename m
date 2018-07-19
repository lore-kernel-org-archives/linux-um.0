Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fg8gC-0001vI-Ly
 for linux-um@lists.infradead.org; Thu, 19 Jul 2018 13:09:14 +0000
Date: Thu, 19 Jul 2018 15:11:49 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/9] kconfig: include common Kconfig files from
 top-level Kconfig
Message-ID: <20180719131149.GA12480@lst.de>
References: <20180708152004.21679-1-hch@lst.de>
 <20180708152004.21679-5-hch@lst.de>
 <CAK7LNAT5dzU-SOvqwnDs=bn3WA1_fmDj2abETmoHUdUExVF+WA@mail.gmail.com>
 <17c45e87-d9be-8453-1bce-18753e0a68b9@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <17c45e87-d9be-8453-1bce-18753e0a68b9@infradead.org>
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
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Christoph Hellwig <hch@lst.de>

On Wed, Jul 18, 2018 at 12:06:26AM -0700, Randy Dunlap wrote:
> All $ARCH look equivalent except for microblaze and nios2.
> For those, the config SWAP in init/Kconfig (line 221) comes before (and
> hence takes precedence) over arch/$(SRCARCH)/Kconfig settings, which is
> def_bool n for both microblaze and nios2.

Both of those are NOMMU architectures, so the default SWAP
decaration should do the right thing.

I wish the kconfig tools could warn about duplicate symbols, as they
are basically always bogus or at least very problematic.

I've update the kconfig-cleanup branch in git with the fixes, but
I didn't have time to do anything but a trivial x86 test yet.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

