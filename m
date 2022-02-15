Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Tue, 15 Feb 2022 09:11:45 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v2] parport_pc: Also enable driver for PCI systems
In-Reply-To: <YgtQkjRe7fbXI/lS@infradead.org>
Message-ID: <alpine.DEB.2.21.2202150901170.34636@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk>
 <YgtQkjRe7fbXI/lS@infradead.org>
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
To: Christoph Hellwig <hch@infradead.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022, Christoph Hellwig wrote:

> > ===================================================================
> > --- linux-macro.orig/arch/arm64/include/asm/Kbuild
> > +++ linux-macro/arch/arm64/include/asm/Kbuild
> > @@ -3,6 +3,7 @@ generic-y += early_ioremap.h
> >  generic-y += mcs_spinlock.h
> >  generic-y += qrwlock.h
> >  generic-y += qspinlock.h
> > +generic-y += parport.h
> 
> Instead of adding generic-y just ad a mandatory-y in
> include/asm-generic/Kbuild.

 I'm inconvinced.  Not all archs want it, 5 don't.

  Maciej

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

