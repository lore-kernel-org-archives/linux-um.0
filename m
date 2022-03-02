Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
MIME-Version: 1.0
References: <alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk>
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 2 Mar 2022 20:44:56 +0000
Message-ID: <CADVatmP4sPwyqi6vKPm3QOFD=47w1LwXtsUynhecY4wMYGhXmw@mail.gmail.com>
Subject: Re: [PATCH v2] parport_pc: Also enable driver for PCI systems
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
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-kernel <linux-kernel@vger.kernel.org>

On Mon, Feb 14, 2022 at 8:16 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> Nowadays PC-style parallel ports come in the form of PCI and PCIe option
> cards and there are some combined parallel/serial option cards as well
> that we handle in the parport subsystem.  There is nothing in particular
> that would prevent them from being used in any system equipped with PCI
> or PCIe connectivity, except that we do not permit the PARPORT_PC config
> option to be selected for platforms for which ARCH_MIGHT_HAVE_PC_PARPORT
> has not been set for.
>
> The only PCI platforms that actually can't make use of PC-style parallel
> port hardware are those newer PCIe systems that have no support for I/O
> cycles in the host bridge, required by such parallel ports.  Notably,
> this includes the s390 arch, which has port I/O accessors that cause
> compilation warnings (promoted to errors with `-Werror'), and there are
> other cases such as the POWER9 PHB4 device, though this one has variable
> port I/O accessors that depend on the particular system.  Also it is not
> clear whether the serial port side of devices enabled by PARPORT_SERIAL
> uses port I/O or MMIO.  Finally Super I/O solutions are always either
> ISA or platform devices.
>
> Make the PARPORT_PC option selectable also for PCI systems then, except
> for the s390 arch, however limit the availability of PARPORT_PC_SUPERIO
> to platforms that enable ARCH_MIGHT_HAVE_PC_PARPORT.  Update platforms
> accordingly for the required <asm/parport.h> header.
>
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Usually parport patches goes via Greg's tree. Adding Greg.

-- 
Regards
Sudip

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

