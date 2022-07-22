Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
MIME-Version: 1.0
References: <CAL_Jsq+_5-fhXddhxG2mr-4HD_brcKZExkZqvME1yEpa6dOGGg@mail.gmail.com>
 <mhng-7e3146ca-79b8-4e16-98a9-e354fb6d03ba@palmer-mbp2014>
 <CAL_JsqJHZEcnJi+UHQbYWVoy1okQjHSc9T377P1q8oOJnHBWFw@mail.gmail.com> <CAK8P3a2aTS74TG8F+cVHX969hMQHKP3Ai5V0h-m+GeAq6kq5pQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2aTS74TG8F+cVHX969hMQHKP3Ai5V0h-m+GeAq6kq5pQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 22 Jul 2022 15:44:02 -0600
Message-ID: <CAL_JsqKZoru2VZLeovPnQWe01ZMdw0krq0tcPx1O6YFUKa-L0g@mail.gmail.com>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Bjorn Helgaas <bhelgaas@google.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Stafford Horne <shorne@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-csky@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, linux-um <linux-um@lists.infradead.org>, PCI <linux-pci@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>

On Fri, Jul 22, 2022 at 1:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jul 22, 2022 at 6:36 PM Rob Herring <robh@kernel.org> wrote:
> > On Fri, Jul 22, 2022 at 9:27 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >
> > From fu740:
> >                        ranges = <0x81000000  0x0 0x60080000  0x0
> > 0x60080000 0x0 0x10000>,      /* I/O */
> ...
> > So again, how does one get a 0 address handed out when that's not even
> > a valid region according to DT? Is there some legacy stuff that
> > ignores the bridge windows?
>
> The PCI-side port number 0x60080000 gets turned into Linux I/O resource 0,
> which I think is what __pci_assign_resource operates on.
>
> The other question is why the platform would want to configure the
> PCI bus to have a PCI I/O space window of size 0x10000 at the address
> it's mapped into, rather than putting it at address zero. Is this a hardware
> bug, a bootloader bug, or just badly set up in the DT?

...putting it at *PCI* address zero, right? Yeah, that looks
suspicious. The core code seems to not use the PCI address, but
various drivers do. Maybe they are miscalculating things and still end
up with 0. If so, we're stuck with that ABI though we could fix it up
in the ranges parsing code and make driver behavior consistent.

In any case, that seems to be a somewhat common occurrence. A somewhat
accurate search (ignore the MBUS_ID ones):

$ git grep -A4 '\sranges =' -- arch/ | grep '0x81000000' | grep -v -E
'0x81000000\s[0x]+\s[0x]+\s'
arch/arm/boot/dts/armada-370.dtsi-
0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0       1 0 /* Port 0.0 IO
*/
arch/arm/boot/dts/armada-375.dtsi-
0x81000000 0x1 0       MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0 IO  */
arch/arm/boot/dts/armada-xp-98dx3236.dtsi-
 0x81000000 0x1 0       MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0.0 IO  */>;
arch/arm/boot/dts/bcm47622.dtsi:                ranges = <0 0x81000000
0x818000>;
arch/arm/boot/dts/dove.dtsi-                              0x81000000
0x1 0x0 MBUS_ID(0x04, 0xe0) 0 1 0   /* Port 0.0 I/O */
arch/arm/boot/dts/kirkwood-6192.dtsi-
0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0       1 0 /* Port 0.0 IO
*/>;
arch/arm/boot/dts/kirkwood-6281.dtsi-
0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0       1 0 /* Port 0.0 IO
*/>;
arch/arm/boot/dts/kirkwood-98dx4122.dtsi-
 0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0       1 0 /* Port 0.0 IO
*/>;
arch/arm/boot/dts/mt7623.dtsi:          ranges = <0x81000000 0
0x1a160000 0 0x1a160000 0 0x00010000
arch/arm/boot/dts/qcom-ipq4019.dtsi:                    ranges =
<0x81000000 0 0x40200000 0x40200000 0 0x00100000>,
arch/arm/boot/dts/qcom-ipq8064.dtsi:                    ranges =
<0x81000000 0 0x0fe00000 0x0fe00000 0 0x00100000   /* downstream I/O
*/
arch/arm/boot/dts/qcom-ipq8064.dtsi:                    ranges =
<0x81000000 0 0x31e00000 0x31e00000 0 0x00100000   /* downstream I/O
*/
arch/arm/boot/dts/qcom-ipq8064.dtsi:                    ranges =
<0x81000000 0 0x35e00000 0x35e00000 0 0x00100000   /* downstream I/O
*/
arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi:              ranges
= <0x00 0x00 0x81000000 0x4000>;
arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts: ranges =
<0x81000000 0 0xe8000000   0 0xe8000000   0 0x01000000   /* Port 0 IO
*/
arch/arm64/boot/dts/mediatek/mt8192.dtsi-
  <0x81000000 0 0x12800000 0x0 0x12800000 0 0x0800000>;
arch/arm64/boot/dts/qcom/ipq6018.dtsi:                  ranges =
<0x81000000 0 0x20200000 0 0x20200000
arch/arm64/boot/dts/qcom/ipq8074.dtsi:                  ranges =
<0x81000000 0 0x10200000 0x10200000
arch/arm64/boot/dts/qcom/ipq8074.dtsi:                  ranges =
<0x81000000 0 0x20200000 0x20200000
arch/arm64/boot/dts/rockchip/rk3399.dtsi-
<0x81000000 0x0 0xfbe00000 0x0 0xfbe00000 0x0 0x100000>;
arch/arm64/boot/dts/toshiba/tmpv7708.dtsi:                      ranges
= <0x81000000 0 0x40000000 0 0x40000000 0 0x00010000
arch/riscv/boot/dts/sifive/fu740-c000.dtsi:                     ranges
= <0x81000000  0x0 0x60080000  0x0 0x60080000 0x0 0x10000>,      /*
I/O */


> Putting the PCI address of the I/O space window at port 0 is usually
> better because it works with PCI devices and drivers that assume that
> port numbers are below 0xfffff, and makes the PCI port number match
> the Linux port number.

I could make the PCI schema check for this, but I guess technically
any 32-bit PCI I/O address is valid even if 64K is the practical
limit.

Rob

P.S. I really wish I/O space would disappear completely.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

