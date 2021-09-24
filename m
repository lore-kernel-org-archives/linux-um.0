Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Fri, 24 Sep 2021 08:32:21 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 3/3] memblock: cleanup memblock_free interface
Message-ID: <YU1i5YyldfS1HH0j@linux.ibm.com>
References: <20210923074335.12583-1-rppt@kernel.org>
 <20210923074335.12583-4-rppt@kernel.org>
 <1101e3c7-fcb7-a632-8e22-47f4a01ea02e@csgroup.eu>
 <YUxsgN/uolhn1Ok+@linux.ibm.com>
 <96e3da9f-70ff-e5c0-ef2e-cf0b636e5695@csgroup.eu>
Content-Disposition: inline
In-Reply-To: <96e3da9f-70ff-e5c0-ef2e-cf0b636e5695@csgroup.eu>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Mike Rapoport <rppt@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, devicetree@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mips@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>, linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Thu, Sep 23, 2021 at 03:54:46PM +0200, Christophe Leroy wrote:
> =

> Le 23/09/2021 =E0 14:01, Mike Rapoport a =E9crit=A0:
> > On Thu, Sep 23, 2021 at 11:47:48AM +0200, Christophe Leroy wrote:
> > > =

> > > =

> > > Le 23/09/2021 =E0 09:43, Mike Rapoport a =E9crit=A0:
> > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > =

> > > > For ages memblock_free() interface dealt with physical addresses ev=
en
> > > > despite the existence of memblock_alloc_xx() functions that return a
> > > > virtual pointer.
> > > > =

> > > > Introduce memblock_phys_free() for freeing physical ranges and repu=
rpose
> > > > memblock_free() to free virtual pointers to make the following pair=
ing
> > > > abundantly clear:
> > > > =

> > > > 	int memblock_phys_free(phys_addr_t base, phys_addr_t size);
> > > > 	phys_addr_t memblock_phys_alloc(phys_addr_t base, phys_addr_t size=
);
> > > > =

> > > > 	void *memblock_alloc(phys_addr_t size, phys_addr_t align);
> > > > 	void memblock_free(void *ptr, size_t size);
> > > > =

> > > > Replace intermediate memblock_free_ptr() with memblock_free() and d=
rop
> > > > unnecessary aliases memblock_free_early() and memblock_free_early_n=
id().
> > > > =

> > > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > > ---
> > > =

> > > > diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> > > > index 1a04e5bdf655..37826d8c4f74 100644
> > > > --- a/arch/s390/kernel/smp.c
> > > > +++ b/arch/s390/kernel/smp.c
> > > > @@ -723,7 +723,7 @@ void __init smp_save_dump_cpus(void)
> > > >    			/* Get the CPU registers */
> > > >    			smp_save_cpu_regs(sa, addr, is_boot_cpu, page);
> > > >    	}
> > > > -	memblock_free(page, PAGE_SIZE);
> > > > +	memblock_phys_free(page, PAGE_SIZE);
> > > >    	diag_amode31_ops.diag308_reset();
> > > >    	pcpu_set_smt(0);
> > > >    }
> > > > @@ -880,7 +880,7 @@ void __init smp_detect_cpus(void)
> > > >    	/* Add CPUs present at boot */
> > > >    	__smp_rescan_cpus(info, true);
> > > > -	memblock_free_early((unsigned long)info, sizeof(*info));
> > > > +	memblock_free(info, sizeof(*info));
> > > >    }
> > > >    /*
> > > =

> > > I'm a bit lost. IIUC memblock_free_early() and memblock_free() where
> > > identical.
> > =

> > Yes, they were, but all calls to memblock_free_early() were using
> > __pa(vaddr) because they had a virtual address at hand.
> =

> I'm still not following. In the above memblock_free_early() was taking
> (unsigned long)info . Was it a bug ? =


Not really because s390 has pa =3D=3D va:

https://elixir.bootlin.com/linux/latest/source/arch/s390/include/asm/page.h=
#L169


-- =

Sincerely yours,
Mike.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

