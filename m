Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
MIME-Version: 1.0
References: <CAL_Jsq+_5-fhXddhxG2mr-4HD_brcKZExkZqvME1yEpa6dOGGg@mail.gmail.com>
 <mhng-7e3146ca-79b8-4e16-98a9-e354fb6d03ba@palmer-mbp2014> <CAL_JsqJHZEcnJi+UHQbYWVoy1okQjHSc9T377P1q8oOJnHBWFw@mail.gmail.com>
In-Reply-To: <CAL_JsqJHZEcnJi+UHQbYWVoy1okQjHSc9T377P1q8oOJnHBWFw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 22 Jul 2022 21:55:03 +0200
Message-ID: <CAK8P3a2aTS74TG8F+cVHX969hMQHKP3Ai5V0h-m+GeAq6kq5pQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] asm-generic: Add new pci.h and use it
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Bjorn Helgaas <bhelgaas@google.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Stafford Horne <shorne@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-csky@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, linux-um <linux-um@lists.infradead.org>, PCI <linux-pci@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>

On Fri, Jul 22, 2022 at 6:36 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, Jul 22, 2022 at 9:27 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> From fu740:
>                        ranges = <0x81000000  0x0 0x60080000  0x0
> 0x60080000 0x0 0x10000>,      /* I/O */
...
> So again, how does one get a 0 address handed out when that's not even
> a valid region according to DT? Is there some legacy stuff that
> ignores the bridge windows?

The PCI-side port number 0x60080000 gets turned into Linux I/O resource 0,
which I think is what __pci_assign_resource operates on.

The other question is why the platform would want to configure the
PCI bus to have a PCI I/O space window of size 0x10000 at the address
it's mapped into, rather than putting it at address zero. Is this a hardware
bug, a bootloader bug, or just badly set up in the DT?

Putting the PCI address of the I/O space window at port 0 is usually
better because it works with PCI devices and drivers that assume that
port numbers are below 0xfffff, and makes the PCI port number match
the Linux port number.

         Arnd

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

