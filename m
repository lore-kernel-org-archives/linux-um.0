Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 23 Sep 2021 15:01:04 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 3/3] memblock: cleanup memblock_free interface
Message-ID: <YUxsgN/uolhn1Ok+@linux.ibm.com>
References: <20210923074335.12583-1-rppt@kernel.org>
 <20210923074335.12583-4-rppt@kernel.org>
 <1101e3c7-fcb7-a632-8e22-47f4a01ea02e@csgroup.eu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1101e3c7-fcb7-a632-8e22-47f4a01ea02e@csgroup.eu>
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

On Thu, Sep 23, 2021 at 11:47:48AM +0200, Christophe Leroy wrote:
> =

> =

> Le 23/09/2021 =E0 09:43, Mike Rapoport a =E9crit=A0:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > =

> > For ages memblock_free() interface dealt with physical addresses even
> > despite the existence of memblock_alloc_xx() functions that return a
> > virtual pointer.
> > =

> > Introduce memblock_phys_free() for freeing physical ranges and repurpose
> > memblock_free() to free virtual pointers to make the following pairing
> > abundantly clear:
> > =

> > 	int memblock_phys_free(phys_addr_t base, phys_addr_t size);
> > 	phys_addr_t memblock_phys_alloc(phys_addr_t base, phys_addr_t size);
> > =

> > 	void *memblock_alloc(phys_addr_t size, phys_addr_t align);
> > 	void memblock_free(void *ptr, size_t size);
> > =

> > Replace intermediate memblock_free_ptr() with memblock_free() and drop
> > unnecessary aliases memblock_free_early() and memblock_free_early_nid().
> > =

> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> =

> > diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> > index 1a04e5bdf655..37826d8c4f74 100644
> > --- a/arch/s390/kernel/smp.c
> > +++ b/arch/s390/kernel/smp.c
> > @@ -723,7 +723,7 @@ void __init smp_save_dump_cpus(void)
> >   			/* Get the CPU registers */
> >   			smp_save_cpu_regs(sa, addr, is_boot_cpu, page);
> >   	}
> > -	memblock_free(page, PAGE_SIZE);
> > +	memblock_phys_free(page, PAGE_SIZE);
> >   	diag_amode31_ops.diag308_reset();
> >   	pcpu_set_smt(0);
> >   }
> > @@ -880,7 +880,7 @@ void __init smp_detect_cpus(void)
> >   	/* Add CPUs present at boot */
> >   	__smp_rescan_cpus(info, true);
> > -	memblock_free_early((unsigned long)info, sizeof(*info));
> > +	memblock_free(info, sizeof(*info));
> >   }
> >   /*
> =

> I'm a bit lost. IIUC memblock_free_early() and memblock_free() where
> identical.

Yes, they were, but all calls to memblock_free_early() were using
__pa(vaddr) because they had a virtual address at hand.

> In the first hunk memblock_free() gets replaced by memblock_phys_free()
> In the second hunk memblock_free_early() gets replaced by memblock_free()

In the first hunk the memory is allocated with memblock_phys_alloc() and we
have a physical range to free. In the second hunk the memory is allocated
with memblock_alloc() and we are freeing a virtual pointer.
 =

> I think it would be easier to follow if you could split it in several
> patches:

It was an explicit request from Linus to make it a single commit:

  but the actual commit can and should be just a single commit that just
  fixes 'memblock_free()' to have sane interfaces.

I don't feel strongly about splitting it (except my laziness really
objects), but I don't think doing the conversion in several steps worth the
churn.

> - First patch: Create memblock_phys_free() and change all relevant
> memblock_free() to memblock_phys_free() - Or change memblock_free() to
> memblock_phys_free() and make memblock_free() an alias of it.
> - Second patch: Make memblock_free_ptr() become memblock_free() and change
> all remaining callers to the new semantics (IIUC memblock_free(__pa(ptr))
> becomes memblock_free(ptr) and make memblock_free_ptr() an alias of
> memblock_free()
> - Fourth patch: Replace and drop memblock_free_ptr()
> - Fifth patch: Drop memblock_free_early() and memblock_free_early_nid() (=
All
> users should have been upgraded to memblock_free_phys() in patch 1 or
> memblock_free() in patch 2)
> =

> Christophe

-- =

Sincerely yours,
Mike.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

