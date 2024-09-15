Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3C2C3ABA1
	for <linux-um@archiver.kernel.org>; Sun, 15 Sep 2024 16:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zYjFOxhIc6gg0NkYVM/96e0omPWTOB1ufw2hZ+jyrUc=; b=MMsZMj/uoLhVOo8PTdMDTcwKSP
	wKMX6aoB09i3+5dTQ1wrcdHyzsyyCsM+CPteRjdQtzo+aPmzGur1zy5GjJefCRAEa5KtbxrsmODLR
	JSq5u/Gb+m/jLRb6lLCRDkHN8Vq7cqYiq++VIV19s3fbD5kk6/pGnl88hDMC245tPAHFnzFkM/Qu7
	bgXhDY+URH8LmXy3Rm2yW3MInHDJM8Sn2Sd1QZBy1KDE6Ce+CSjbRyMdSHJ4/SK6Uv7k0zLNXeY3s
	Qs/swAA0fw4UBEdprAglivg9BBDSCC09UKIeA3C4dlkwYliwx8T+iHE4uvHeiI/p9Gqr81/ImD3LY
	bop/Z1XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spsXj-00000002NdJ-0LPe;
	Sun, 15 Sep 2024 16:56:11 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spsXg-00000002Ncr-1VO0
	for linux-um@lists.infradead.org;
	Sun, 15 Sep 2024 16:56:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zYjFOxhIc6gg0NkYVM/96e0omPWTOB1ufw2hZ+jyrUc=;
	t=1726419365; x=1727628965; b=iA8QeKnFpKa1SMsmuxQPrWbMZrq3Ikd4IQoYr5DEwXyHRB5
	6cdzNAJhh9mO7BKsoNkouqUJKjWU92GpHAnNJgvqHoUOAd4418PXrVDcXuDtSkI6jzYj56Nxd7Ofh
	FQmyWfL8kebgKvavYp2TLB4djVEeJ6DDSenOJXwM6GDBx0/4J4DFTitbGnzrZjzBG8UWraPD/cm13
	fB5KHn8uLB6gzWk/TWw3NDR6zdlCCiD+bN9kXd8BI3MRMaSHCZskiOLFuN3FIQOd8vg1f0DI8ussN
	aVXZBFX3+f/InphuyqAhTKiGUyfUih5xI9udFQMsSYrVbQzAj82Zz5NvNCGeDJRw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1spsXX-00000007VaX-0alN;
	Sun, 15 Sep 2024 18:55:59 +0200
Message-ID: <56a679e9ea6a6e6c7d9316608f25fd691001e8dc.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] um: Remove highmem leftovers
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Sun, 15 Sep 2024 18:55:49 +0200
In-Reply-To: <20240913142137.248245-3-tiwei.btw@antgroup.com>
References: <20240913142137.248245-1-tiwei.btw@antgroup.com>
	 <20240913142137.248245-3-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240915_095608_593288_A42EEC79 
X-CRM114-Status: GOOD (  28.61  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi,

does that mean we can also drop the 3-level page table support on i386?
It seems like the two level page table is entirely sufficient on a
system without high memory (i.e. only 32bit physical addresses).

When I took a look at it for the 4-level page table support on 64 bit I
got a bit confused. But I had not realized that highmem support had
been removed.

Benjamin

On Fri, 2024-09-13 at 22:21 +0800, Tiwei Bie wrote:
> Highmem was only supported on UML/i386. And the support has been
> removed by commit a98a6d864d3b ("um: Remove broken highmem support").
> Remove the leftovers and stop UML from trying to setup highmem when
> the sum of physmem_size and iomem_size exceeds max_physmem.
>=20
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> ---
> =C2=A0arch/um/drivers/virtio_uml.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 9 +--------
> =C2=A0arch/um/include/shared/as-layout.h |=C2=A0 1 -
> =C2=A0arch/um/include/shared/mem_user.h=C2=A0 |=C2=A0 5 ++---
> =C2=A0arch/um/kernel/mem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ---
> =C2=A0arch/um/kernel/physmem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 30 +++++++++++-----------------
> --
> =C2=A0arch/um/kernel/um_arch.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 17 +++++++----------
> =C2=A06 files changed, 21 insertions(+), 44 deletions(-)
>=20
> diff --git a/arch/um/drivers/virtio_uml.c
> b/arch/um/drivers/virtio_uml.c
> index 2b6e701776b6..e7f5556e3c96 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -72,7 +72,7 @@ struct virtio_uml_vq_info {
> =C2=A0	bool suspended;
> =C2=A0};
> =C2=A0
> -extern unsigned long long physmem_size, highmem;
> +extern unsigned long long physmem_size;
> =C2=A0
> =C2=A0#define vu_err(vu_dev, ...)	dev_err(&(vu_dev)->pdev->dev,
> ##__VA_ARGS__)
> =C2=A0
> @@ -673,13 +673,6 @@ static int vhost_user_set_mem_table(struct
> virtio_uml_device *vu_dev)
> =C2=A0
> =C2=A0	if (rc < 0)
> =C2=A0		return rc;
> -	if (highmem) {
> -		msg.payload.mem_regions.num++;
> -		rc =3D vhost_user_init_mem_region(__pa(end_iomem),
> highmem,
> -				&fds[1],
> &msg.payload.mem_regions.regions[1]);
> -		if (rc < 0)
> -			return rc;
> -	}
> =C2=A0
> =C2=A0	return vhost_user_send(vu_dev, false, &msg, fds,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg.payload.mem_regions.num=
);
> diff --git a/arch/um/include/shared/as-layout.h
> b/arch/um/include/shared/as-layout.h
> index 06292fca5a4d..61965a06c18a 100644
> --- a/arch/um/include/shared/as-layout.h
> +++ b/arch/um/include/shared/as-layout.h
> @@ -41,7 +41,6 @@ extern unsigned long uml_physmem;
> =C2=A0extern unsigned long uml_reserved;
> =C2=A0extern unsigned long end_vm;
> =C2=A0extern unsigned long start_vm;
> -extern unsigned long long highmem;
> =C2=A0
> =C2=A0extern unsigned long brk_start;
> =C2=A0
> diff --git a/arch/um/include/shared/mem_user.h
> b/arch/um/include/shared/mem_user.h
> index 11a723a58545..adfa08062f88 100644
> --- a/arch/um/include/shared/mem_user.h
> +++ b/arch/um/include/shared/mem_user.h
> @@ -47,10 +47,9 @@ extern int iomem_size;
> =C2=A0#define ROUND_4M(n) ((((unsigned long) (n)) + (1 << 22)) & ~((1 <<
> 22) - 1))
> =C2=A0
> =C2=A0extern unsigned long find_iomem(char *driver, unsigned long
> *len_out);
> -extern void mem_total_pages(unsigned long physmem, unsigned long
> iomem,
> -		=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long highmem);
> +extern void mem_total_pages(unsigned long physmem, unsigned long
> iomem);
> =C2=A0extern void setup_physmem(unsigned long start, unsigned long usable=
,
> -			=C2=A0 unsigned long len, unsigned long long
> highmem);
> +			=C2=A0 unsigned long len);
> =C2=A0extern void map_memory(unsigned long virt, unsigned long phys,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long len, int r, in=
t w, int x);
> =C2=A0
> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
> index a5b4fe2ad931..5026668dc054 100644
> --- a/arch/um/kernel/mem.c
> +++ b/arch/um/kernel/mem.c
> @@ -6,7 +6,6 @@
> =C2=A0#include <linux/stddef.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/memblock.h>
> -#include <linux/highmem.h>
> =C2=A0#include <linux/mm.h>
> =C2=A0#include <linux/swap.h>
> =C2=A0#include <linux/slab.h>
> @@ -51,8 +50,6 @@ EXPORT_SYMBOL(empty_zero_page);
> =C2=A0pgd_t swapper_pg_dir[PTRS_PER_PGD];
> =C2=A0
> =C2=A0/* Initialized at boot time, and readonly after that */
> -unsigned long long highmem;
> -EXPORT_SYMBOL(highmem);
> =C2=A0int kmalloc_ok =3D 0;
> =C2=A0
> =C2=A0/* Used during early boot */
> diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
> index fb2adfb49945..cc5238c1bf1e 100644
> --- a/arch/um/kernel/physmem.c
> +++ b/arch/um/kernel/physmem.c
> @@ -24,17 +24,14 @@ EXPORT_SYMBOL(high_physmem);
> =C2=A0
> =C2=A0extern unsigned long long physmem_size;
> =C2=A0
> -void __init mem_total_pages(unsigned long physmem, unsigned long
> iomem,
> -		=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long highmem)
> +void __init mem_total_pages(unsigned long physmem, unsigned long
> iomem)
> =C2=A0{
> -	unsigned long phys_pages, highmem_pages;
> -	unsigned long iomem_pages, total_pages;
> +	unsigned long phys_pages, iomem_pages, total_pages;
> =C2=A0
> -	phys_pages=C2=A0=C2=A0=C2=A0 =3D physmem >> PAGE_SHIFT;
> -	iomem_pages=C2=A0=C2=A0 =3D iomem=C2=A0=C2=A0 >> PAGE_SHIFT;
> -	highmem_pages =3D highmem >> PAGE_SHIFT;
> +	phys_pages=C2=A0 =3D physmem >> PAGE_SHIFT;
> +	iomem_pages =3D iomem=C2=A0=C2=A0 >> PAGE_SHIFT;
> =C2=A0
> -	total_pages=C2=A0=C2=A0 =3D phys_pages + iomem_pages + highmem_pages;
> +	total_pages =3D phys_pages + iomem_pages;
> =C2=A0
> =C2=A0	max_mapnr =3D total_pages;
> =C2=A0}
> @@ -64,13 +61,12 @@ void map_memory(unsigned long virt, unsigned long
> phys, unsigned long len,
> =C2=A0 * @reserve_end:	end address of the physical kernel memory.
> =C2=A0 * @len:	Length of total physical memory that should be
> mapped/made
> =C2=A0 *		available, in bytes.
> - * @highmem:	Number of highmem bytes that should be mapped/made
> available.
> =C2=A0 *
> - * Creates an unlinked temporary file of size (len + highmem) and
> memory maps
> + * Creates an unlinked temporary file of size (len) and memory maps
> =C2=A0 * it on the last executable image address (uml_reserved).
> =C2=A0 *
> =C2=A0 * The offset is needed as the length of the total physical memory
> - * (len + highmem) includes the size of the memory used be the
> executable image,
> + * (len) includes the size of the memory used be the executable
> image,
> =C2=A0 * but the mapped-to address is the last address of the executable
> image
> =C2=A0 * (uml_reserved =3D=3D end address of executable image).
> =C2=A0 *
> @@ -78,19 +74,19 @@ void map_memory(unsigned long virt, unsigned long
> phys, unsigned long len,
> =C2=A0 * of all user space processes/kernel tasks.
> =C2=A0 */
> =C2=A0void __init setup_physmem(unsigned long start, unsigned long
> reserve_end,
> -			=C2=A0 unsigned long len, unsigned long long
> highmem)
> +			=C2=A0 unsigned long len)
> =C2=A0{
> =C2=A0	unsigned long reserve =3D reserve_end - start;
> =C2=A0	long map_size =3D len - reserve;
> =C2=A0	int err;
> =C2=A0
> -	if(map_size <=3D 0) {
> +	if (map_size <=3D 0) {
> =C2=A0		os_warn("Too few physical memory! Needed=3D%lu,
> given=3D%lu\n",
> =C2=A0			reserve, len);
> =C2=A0		exit(1);
> =C2=A0	}
> =C2=A0
> -	physmem_fd =3D create_mem_file(len + highmem);
> +	physmem_fd =3D create_mem_file(len);
> =C2=A0
> =C2=A0	err =3D os_map_memory((void *) reserve_end, physmem_fd,
> reserve,
> =C2=A0			=C2=A0=C2=A0=C2=A0 map_size, 1, 1, 1);
> @@ -109,7 +105,7 @@ void __init setup_physmem(unsigned long start,
> unsigned long reserve_end,
> =C2=A0	os_write_file(physmem_fd, __syscall_stub_start, PAGE_SIZE);
> =C2=A0	os_fsync_file(physmem_fd);
> =C2=A0
> -	memblock_add(__pa(start), len + highmem);
> +	memblock_add(__pa(start), len);
> =C2=A0	memblock_reserve(__pa(start), reserve);
> =C2=A0
> =C2=A0	min_low_pfn =3D PFN_UP(__pa(reserve_end));
> @@ -137,10 +133,6 @@ int phys_mapping(unsigned long phys, unsigned
> long long *offset_out)
> =C2=A0			region =3D region->next;
> =C2=A0		}
> =C2=A0	}
> -	else if (phys < __pa(end_iomem) + highmem) {
> -		fd =3D physmem_fd;
> -		*offset_out =3D phys - iomem_size;
> -	}
> =C2=A0
> =C2=A0	return fd;
> =C2=A0}
> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> index 8e594cda6d77..8f86aa468b50 100644
> --- a/arch/um/kernel/um_arch.c
> +++ b/arch/um/kernel/um_arch.c
> @@ -366,18 +366,15 @@ int __init linux_main(int argc, char **argv)
> =C2=A0
> =C2=A0	setup_machinename(init_utsname()->machine);
> =C2=A0
> -	highmem =3D 0;
> +	physmem_size =3D (physmem_size + PAGE_SIZE - 1) & PAGE_MASK;
> =C2=A0	iomem_size =3D (iomem_size + PAGE_SIZE - 1) & PAGE_MASK;
> +
> =C2=A0	max_physmem =3D TASK_SIZE - uml_physmem - iomem_size -
> MIN_VMALLOC;
> =C2=A0
> -	/*
> -	 * Zones have to begin on a 1 << MAX_PAGE_ORDER page
> boundary,
> -	 * so this makes sure that's true for highmem
> -	 */
> -	max_physmem &=3D ~((1 << (PAGE_SHIFT + MAX_PAGE_ORDER)) - 1);
> =C2=A0	if (physmem_size + iomem_size > max_physmem) {
> -		highmem =3D physmem_size + iomem_size - max_physmem;
> -		physmem_size -=3D highmem;
> +		physmem_size =3D max_physmem - iomem_size;
> +		os_info("Physical memory size shrunk to %llu
> bytes\n",
> +			physmem_size);
> =C2=A0	}
> =C2=A0
> =C2=A0	high_physmem =3D uml_physmem + physmem_size;
> @@ -413,8 +410,8 @@ void __init setup_arch(char **cmdline_p)
> =C2=A0	u8 rng_seed[32];
> =C2=A0
> =C2=A0	stack_protections((unsigned long) &init_thread_info);
> -	setup_physmem(uml_physmem, uml_reserved, physmem_size,
> highmem);
> -	mem_total_pages(physmem_size, iomem_size, highmem);
> +	setup_physmem(uml_physmem, uml_reserved, physmem_size);
> +	mem_total_pages(physmem_size, iomem_size);
> =C2=A0	uml_dtb_init();
> =C2=A0	read_initrd();
> =C2=A0


