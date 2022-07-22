Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Fri, 22 Jul 2022 23:28:05 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v3 2/2] asm-generic: Add new pci.h and use it
In-Reply-To: <CAL_JsqK-_m2=yiD4qeSoXD-Uhh_r+kmC1qK50t8Tads-i+iJqw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2207222325010.48997@angie.orcam.me.uk>
References: <CAL_Jsq+_5-fhXddhxG2mr-4HD_brcKZExkZqvME1yEpa6dOGGg@mail.gmail.com> <mhng-7e3146ca-79b8-4e16-98a9-e354fb6d03ba@palmer-mbp2014> <CAL_JsqJHZEcnJi+UHQbYWVoy1okQjHSc9T377P1q8oOJnHBWFw@mail.gmail.com> <alpine.DEB.2.21.2207222006140.48997@angie.orcam.me.uk>
 <CAL_JsqK-_m2=yiD4qeSoXD-Uhh_r+kmC1qK50t8Tads-i+iJqw@mail.gmail.com>
MIME-Version: 1.0
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
To: Rob Herring <robh@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Bjorn Helgaas <bhelgaas@google.com>, Stafford Horne <shorne@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-csky@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, linux-um@lists.infradead.org, PCI <linux-pci@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>

On Fri, 22 Jul 2022, Rob Herring wrote:

> > > So again, how does one get a 0 address handed out when that's not even
> > > a valid region according to DT? Is there some legacy stuff that
> > > ignores the bridge windows?
> >
> >  It doesn't matter as <asm/pci.h> just sets it as a generic parameter for
> > the platform, reflecting the limitation of PCI core, which in the course
> > of the discussion referred was found rather infeasible to remove.  The
> > FU740 does not decode to PCI at 0, but another RISC-V device could.  And I
> > think that DT should faithfully describe hardware and not our software
> > limitations.
> 
> Let me ask this another way. When would a 0 memory or i/o address ever
> work? It doesn't seem this s/w limitation has anything specific to
> Risc-V. Given pci_iomap_range() rejects 0, I can't see how it could
> ever work. Maybe only for legacy ISA? So should the generic defaults
> just be what Risc-V is using instead of 0?

 Absolutely, cf.: 
<https://lore.kernel.org/lkml/alpine.DEB.2.21.2202260044180.25061@angie.orcam.me.uk/>.

  Maciej

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

