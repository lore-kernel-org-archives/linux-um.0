Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from bilbo.ozlabs.org ([203.11.71.1] helo=ozlabs.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hHnjX-0003IE-TC
 for linux-um@lists.infradead.org; Sat, 20 Apr 2019 11:00:37 +0000
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] [v2] x86/mpx: fix recursive munmap() corruption
In-Reply-To: <20190419194747.5E1AD6DC@viggo.jf.intel.com>
References: <20190419194747.5E1AD6DC@viggo.jf.intel.com>
Date: Sat, 20 Apr 2019 21:00:21 +1000
Message-ID: <878sw5szzu.fsf@concordia.ellerman.id.au>
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
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, hjl.tools@gmail.com, mhocko@suse.com, rguenther@suse.de, gxt@pku.edu.cn, benh@kernel.crashing.org, jdike@addtoit.com, Dave Hansen <dave.hansen@linux.intel.com>, linux-um@lists.infradead.org, x86@kernel.org, stable@vger.kernel.org, luto@amacapital.net, linux-mm@kvack.org, paulus@samba.org, richard@nod.at, yang.shi@linux.alibaba.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, vbabka@suse.cz, anton.ivanov@cambridgegreys.com

Dave Hansen <dave.hansen@linux.intel.com> writes:
> Changes from v1:
>  * Fix compile errors on UML and non-x86 arches
>  * Clarify commit message and Fixes about the origin of the
>    bug and add the impact to powerpc / uml / unicore32
>
> --
>
> This is a bit of a mess, to put it mildly.  But, it's a bug
> that only seems to have showed up in 4.20 but wasn't noticed
> until now because nobody uses MPX.
>
> MPX has the arch_unmap() hook inside of munmap() because MPX
> uses bounds tables that protect other areas of memory.  When
> memory is unmapped, there is also a need to unmap the MPX
> bounds tables.  Barring this, unused bounds tables can eat 80%
> of the address space.
>
> But, the recursive do_munmap() that gets called vi arch_unmap()
> wreaks havoc with __do_munmap()'s state.  It can result in
> freeing populated page tables, accessing bogus VMA state,
> double-freed VMAs and more.
>
> To fix this, call arch_unmap() before __do_unmap() has a chance
> to do anything meaningful.  Also, remove the 'vma' argument
> and force the MPX code to do its own, independent VMA lookup.
>
> == UML / unicore32 impact ==
>
> Remove unused 'vma' argument to arch_unmap().  No functional
> change.
>
> I compile tested this on UML but not unicore32.
>
> == powerpc impact ==
>
> powerpc uses arch_unmap() well to watch for munmap() on the
> VDSO and zeroes out 'current->mm->context.vdso_base'.  Moving
> arch_unmap() makes this happen earlier in __do_munmap().  But,
> 'vdso_base' seems to only be used in perf and in the signal
> delivery that happens near the return to userspace.  I can not
> find any likely impact to powerpc, other than the zeroing
> happening a little earlier.

Yeah I agree.

> powerpc does not use the 'vma' argument and is unaffected by
> its removal.
>
> I compile-tested a 64-bit powerpc defconfig.

Thanks.

cheers

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

