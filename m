Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Tue, 1 Mar 2022 20:43:58 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PING][PATCH v2] parport_pc: Also enable driver for PCI systems
In-Reply-To: <alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2203011751030.11354@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk>
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
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022, Maciej W. Rozycki wrote:

> Nowadays PC-style parallel ports come in the form of PCI and PCIe option 
> cards and there are some combined parallel/serial option cards as well 
> that we handle in the parport subsystem.  There is nothing in particular 
> that would prevent them from being used in any system equipped with PCI 
> or PCIe connectivity, except that we do not permit the PARPORT_PC config 
> option to be selected for platforms for which ARCH_MIGHT_HAVE_PC_PARPORT 
> has not been set for.

 Ping for:

<https://lore.kernel.org/lkml/alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk/>

  Maciej

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

