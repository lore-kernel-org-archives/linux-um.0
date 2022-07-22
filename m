Return-Path: <arnd@arndb.de>
MIME-Version: 1.0
References: <20220721134924.596152-5-shorne@gmail.com> <20220721173733.GA1731649@bhelgaas>
 <YtnMEwh3U3Ng9q4a@antec>
In-Reply-To: <YtnMEwh3U3Ng9q4a@antec>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 22 Jul 2022 09:53:07 +0200
Message-ID: <CAK8P3a3T0GvYyRgw=ojD_wts_pfdzfqXS8iNfUYuByBvLF9SGQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] asm-generic: Add new pci.h and use it
Content-Type: text/plain; charset="UTF-8"
To: Stafford Horne <shorne@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Pierre Morel <pmorel@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-csky@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, linux-um <linux-um@lists.infradead.org>, linux-pci <linux-pci@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Thu, Jul 21, 2022 at 11:58 PM Stafford Horne <shorne@gmail.com> wrote:
> On Thu, Jul 21, 2022 at 12:37:33PM -0500, Bjorn Helgaas wrote:

>
> Thanks, you are right, I think some of the earlier functions may have needed it,
> which is why I had it earlier.  But now that we have removed those we should be
> able to remove this.
>
> That said, I think some of the architecture includes could also be removed.  On
> OpenRISC we are able to get away with only having the global asm-generic/pci.h
> so we don't need a wrapper pci.h header at all.
>
> However, I don't have everything setup to build all of those architectures so I
> was being a bit conservative to remove headers.  I'll see what I can do in the
> next version.

No need to worry about linux/types.h, this is pretty much included everywhere
already and neither the risk of extraneous includes or missing ones is
something to worry about. I'd just remove it if you do another respin, or
we can leave it in if Bjorn wants to just apply the v5 version.

       Arnd

