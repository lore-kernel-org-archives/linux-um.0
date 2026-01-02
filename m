Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751A6FA3754
	for <linux-um@archiver.kernel.org>; Fri,  2 Jan 2026 18:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VF7Ncw4qUW1QvZXNeYN2PHKmriSnoyG5jmMgiKLYwBI=; b=DovQp5usBz7TNsKDpv5iwe8uww
	s1LEH0xGf57cLAMaR9GMYwYukKhCA6qbOvoHV+nD+BGFjriHhVxk5UG+vShAg58PNlW10vzmDAdtY
	+xLF9/6KBuX0Nmzp7dDQoRFN8ThST7YLzYbio9AouOTNnNousu/hss/SsHAXY4hHulwydn7K/s6ms
	flxaA37TVK4CjfMkehURq5YhMADugS/06ayD0wv+CxjfneztUi5aMPJ25yV5JOndHjPT2gIl8DT3v
	UROaUX6Ti2llWQk/bK1wP4J1UOEQ8E94/xNnQTa+b2RG2c8KuWAwQSOfHi7r7aZdqDqn5zyI4KF5j
	bSN/f0Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbjVQ-00000008bkA-21CE;
	Fri, 02 Jan 2026 18:04:08 +0000
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbjVM-00000008bhz-0sin
	for linux-um@lists.infradead.org;
	Fri, 02 Jan 2026 18:04:06 +0000
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4ee147baf7bso10911cf.1
        for <linux-um@lists.infradead.org>; Fri, 02 Jan 2026 10:04:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767377042; cv=none;
        d=google.com; s=arc-20240605;
        b=foV21v6+QnoIiZ7ZtniX6gcQSZDioAdZSsmQlTX/UtGIwuaU8qkaw36kCOQeIaJFP8
         ZRQ2uXFTPjuTKKtmriiwdEuOPpDQein9/zswPEtl7YxBpIHoFfO8O7C/4HVFsRRaU0by
         RceODeux+TNDFRXLTV2KIla34G58ba535UJGKe8sBEavN97gWOnF158ZSW9uqQjN6mXk
         6kUvEJ+RyonVSBEBcAeOcPmWPBl1ZFT54pC+0L5xj8uhE3CISQPwuShKG18sMpcQN1tR
         JiDmSqV9XIv6vJQBcnZBkJSLyMKMTZ9syAoj5tKcDL58mmLllVoRPzTn/nN+OwebEngr
         1gHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VF7Ncw4qUW1QvZXNeYN2PHKmriSnoyG5jmMgiKLYwBI=;
        fh=1QeRoGva//lTgz0B/9DozpZHFRXxAQF6SFRgVqwnz7c=;
        b=jcwJkPfE/dB6iqyB+SikawNQlzJduOLKMXqxtHB5D8Z191PZ3so9hXMsN6eY8B7DJr
         XBg8iFiWcqcj9LvKvQxEK/kVk81rM2kcZ/fvkHwzttca6wsHncYMyxyMW+R6LhuKGbCW
         1uyJhglF+iUbi8z/U2tReYZxS0A7aov62fqHbLFfW7qLfqXqwZu+BwoJX2XfKPUVqNBE
         aKZN9xwQ/8q5eErhNbJtDqPeKzBQRVXxdb8fLc8Fr2DmuDXneVDoKG+L1aOLeTtM7NOg
         Vn+14WmczdG5AvqF90sB8zmQ6367UHli8qRN2IRKhid/606gDQQ8KopRcryrjnOMZT0f
         K9ag==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767377042; x=1767981842; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VF7Ncw4qUW1QvZXNeYN2PHKmriSnoyG5jmMgiKLYwBI=;
        b=MAambTeXZ6vsTdRtk1B1JYcxzaKiquUj9bvhbs9NWK6IRHuCFKhcOOV8TnQ4JYfbXP
         GESKL+4v92CNnNeHl29WH2sjVN2uqhfkrViCgoprrK/oJQekubfNwBXlu/55uRDOFg0Q
         PJSvL4/b3gYGRiWJPU+UO6zIx5fUbCbOPNEKnbgAH9BfDkwnX+GMmEb+J4OkAbvNhlUj
         ML5ZnQeR5569iP4U9kV3wX1jeJYurvPossN7fYP5Aj7KCZnsqpharpeguazSgBIJpTeR
         hyUCXpydZ/FC8cPHfEaA+KgX7rccsPnjLrde+Gj4NeGgAUUFJ3GATTd+43EqwubsJcCD
         Nmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767377042; x=1767981842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VF7Ncw4qUW1QvZXNeYN2PHKmriSnoyG5jmMgiKLYwBI=;
        b=az2cUmUhK6LYYcgC+IQzErY3Wq/ryLTP5+m3LmA49t95OLjOKMv9mzCLhbT/24H+dY
         EbiF8TlImzjjQUBpbenxkD9KdhQMhZ9ImCJaqhWAbQoA8+2B9+grugv+tcGSvAzzVoyW
         z1nTPWEfPsUixh8hIQ3GKLK6xcab27qaPK5BZH+DDZ1F/+627H9onFkZpLRpBG7WfmVg
         A+7D660f5e8vW1meVMwabz6cPf5UZ4Rsn3rYV6BDbKkLnNRWRzdS9Ce2AggJZ1n4L3y/
         XZobEpNQhKoV2eWBDfCDedIi+apNIL5vCZacj9SrglhTQ0dtpYqfuAPoOpw5w7kfXYa5
         cR8g==
X-Forwarded-Encrypted: i=1; AJvYcCVZotjE+NWVl1aqXehlgzVqr2NER1fp2biJBhdYE2+QEk+LDnHcZp/nIDyG6vEcNKg9Z9S/SNwi6g==@lists.infradead.org
X-Gm-Message-State: AOJu0YwPDQqExSrweKs5f0MVr1yJ+gdV83ljhKMKiOl9kbtdiHU8rbpc
	DpmPbJJ+H+fcKPAQ54UgThYpT2MDTcgtMWPsgw5Z9wpY2iYToMInW1q70QMfdY0keq+5U6qeo4a
	VcT7k1y0dOaVTCIwNYbGZUlg1o85gHrbCmwDbdcuH
X-Gm-Gg: AY/fxX5cor7wA8E0FyGg1x7tpyDvQeJe4u3RP4+/17PCdGq2cTePTwNIYGJr8l8Rjef
	6/NbqvXLiwGmwAARxbe0+TA+F3OYfHM8VMMS5Em6ksBwCfS2U6rNOKyjBGIXWTLp5KkYXmO6YoQ
	u/vV2lAc37FPe/ZEH857uFXU/RTu4l3fPiVhMMruBts+OmgmqE/fFUX+Ap3n8nS8rH3LeeK1CZa
	SbeiQl0cJFUTwgLU/EpjneJavLVYuz7AkMv8mgaNPfYwi60c11gLiMUvMCkH68Gb4cCwiY=
X-Google-Smtp-Source: AGHT+IE626c1niVbXfJuRnnEKb/XVpUT3xgOsgVHvUYmmAhOToE2K50Gpbsa48xtp+jOGlgqExM/NP3EnDee4koBR/0=
X-Received: by 2002:a05:622a:8016:b0:4fb:e3b0:aae6 with SMTP id
 d75a77b69052e-4fbe3b0ad54mr14392961cf.1.1767377041692; Fri, 02 Jan 2026
 10:04:01 -0800 (PST)
MIME-Version: 1.0
References: <20260102070005.65328-1-rppt@kernel.org>
In-Reply-To: <20260102070005.65328-1-rppt@kernel.org>
From: Frank van der Linden <fvdl@google.com>
Date: Fri, 2 Jan 2026 10:03:49 -0800
X-Gm-Features: AQt7F2qPng5Y0NvX0my5UG4cpefC6iiH19nIvMPHQLdOtt1JmQ_l0Tjv8FxQEzo
Message-ID: <CAPTztWaZZt_ygCDNaDdW9A_TtT1FNZW6hFzyiq2b6_xxMw38gQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/28] arch, mm: consolidate hugetlb early reservation
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alex Shi <alexs@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	"David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
	Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, 
	Michal Simek <monstr@monstr.eu>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, x86@kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260102_100404_308849_F24984BF 
X-CRM114-Status: GOOD (  31.10  )
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

On Thu, Jan 1, 2026 at 11:00=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Hi,
>
> Order in which early memory reservation for hugetlb happens depends on
> architecture, on configuration options and on command line parameters.
>
> Some architectures rely on the core MM to call hugetlb_bootmem_alloc()
> while others call it very early to allow pre-allocation of HVO-style
> vmemmap.
>
> When hugetlb_cma is supported by an architecture it is initialized during
> setup_arch() and then later hugetlb_init code needs to understand did it
> happen or not.
>
> To make everything consistent and unified, both reservation of hugetlb
> memory from bootmem and creation of CMA areas for hugetlb must be called
> from core MM initialization and it would have been a simple change.
> However, HVO-style pre-initialization ordering requirements slightly
> complicate things and for HVO pre-init to work sparse and memory map shou=
ld
> be initialized after hugetlb reservations.
>
> This required pulling out the call to free_area_init() out of setup_arch(=
)
> path and moving it MM initialization and this is what the first 23 patche=
s
> do.
>
> These changes are deliberately split into per-arch patches that change ho=
w
> the zone limits are calculated for each architecture and the patches 22 a=
nd
> 23 just remove the calls to free_area_init() and sprase_init() from arch/=
*.
>
> Patch 24 is a simple cleanup for MIPS.
>
> Patches 25 and 26 actually consolidate hugetlb reservations and patches 2=
7
> and 28 perform some aftermath cleanups.
>
> I tried to trim the distribution list and although it's still quite long
> if you feel that someone was wrongly excluded please add them back.
>
> The changes also available in git:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=3Dh=
ugetlb-init/v2
>
> v2 changes:
> * move the hugetlb and memory map initializaion to mm_core_init_early()
> * add Acks
>
> v1: https://lore.kernel.org/all/20251228124001.3624742-1-rppt@kernel.org
>
> Mike Rapoport (Microsoft) (28):
>   alpha: introduce arch_zone_limits_init()
>   arc: introduce arch_zone_limits_init()
>   arm: introduce arch_zone_limits_init()
>   arm64: introduce arch_zone_limits_init()
>   csky: introduce arch_zone_limits_init()
>   hexagon: introduce arch_zone_limits_init()
>   loongarch: introduce arch_zone_limits_init()
>   m68k: introduce arch_zone_limits_init()
>   microblaze: introduce arch_zone_limits_init()
>   mips: introduce arch_zone_limits_init()
>   nios2: introduce arch_zone_limits_init()
>   openrisc: introduce arch_zone_limits_init()
>   parisc: introduce arch_zone_limits_init()
>   powerpc: introduce arch_zone_limits_init()
>   riscv: introduce arch_zone_limits_init()
>   s390: introduce arch_zone_limits_init()
>   sh: introduce arch_zone_limits_init()
>   sparc: introduce arch_zone_limits_init()
>   um: introduce arch_zone_limits_init()
>   x86: introduce arch_zone_limits_init()
>   xtensa: introduce arch_zone_limits_init()
>   arch, mm: consolidate initialization of nodes, zones and memory map
>   arch, mm: consolidate initialization of SPARSE memory model
>   mips: drop paging_init()
>   x86: don't reserve hugetlb memory in setup_arch()
>   mm, arch: consolidate hugetlb CMA reservation
>   mm/hugetlb: drop hugetlb_cma_check()
>   Revert "mm/hugetlb: deal with multiple calls to hugetlb_bootmem_alloc"
>
>  .../driver-api/cxl/linux/early-boot.rst       |  2 +-
>  Documentation/mm/memory-model.rst             |  3 --
>  .../translations/zh_CN/mm/memory-model.rst    |  2 -
>  arch/alpha/kernel/setup.c                     |  1 -
>  arch/alpha/mm/init.c                          | 16 ++++----
>  arch/arc/mm/init.c                            | 37 +++++++++---------
>  arch/arm/mm/init.c                            | 25 ++----------
>  arch/arm64/include/asm/hugetlb.h              |  2 -
>  arch/arm64/mm/hugetlbpage.c                   | 10 ++---
>  arch/arm64/mm/init.c                          | 39 ++++++++-----------
>  arch/csky/kernel/setup.c                      | 16 ++++----
>  arch/hexagon/mm/init.c                        | 19 +++------
>  arch/loongarch/include/asm/pgtable.h          |  2 -
>  arch/loongarch/kernel/setup.c                 | 10 -----
>  arch/loongarch/mm/init.c                      |  6 +--
>  arch/m68k/mm/init.c                           |  8 ++--
>  arch/m68k/mm/mcfmmu.c                         |  3 --
>  arch/m68k/mm/motorola.c                       |  6 +--
>  arch/m68k/mm/sun3mmu.c                        |  9 -----
>  arch/microblaze/mm/init.c                     | 22 +++++------
>  arch/mips/include/asm/pgalloc.h               |  2 -
>  arch/mips/include/asm/pgtable.h               |  2 +-
>  arch/mips/kernel/setup.c                      | 15 +------
>  arch/mips/loongson64/numa.c                   | 10 ++---
>  arch/mips/mm/init.c                           |  8 +---
>  arch/mips/sgi-ip27/ip27-memory.c              |  8 +---
>  arch/nios2/mm/init.c                          | 12 +++---
>  arch/openrisc/mm/init.c                       | 10 +----
>  arch/parisc/mm/init.c                         | 11 +-----
>  arch/powerpc/include/asm/hugetlb.h            |  5 ---
>  arch/powerpc/include/asm/setup.h              |  4 ++
>  arch/powerpc/kernel/setup-common.c            |  1 -
>  arch/powerpc/mm/hugetlbpage.c                 | 11 ++----
>  arch/powerpc/mm/mem.c                         | 27 +++++--------
>  arch/powerpc/mm/numa.c                        |  2 -
>  arch/riscv/mm/hugetlbpage.c                   |  8 ++++
>  arch/riscv/mm/init.c                          | 10 +----
>  arch/s390/kernel/setup.c                      |  2 -
>  arch/s390/mm/hugetlbpage.c                    |  8 ++++
>  arch/s390/mm/init.c                           | 13 +++----
>  arch/sh/mm/init.c                             | 12 +++---
>  arch/sparc/mm/init_64.c                       | 17 +++-----
>  arch/sparc/mm/srmmu.c                         | 17 ++++----
>  arch/um/kernel/mem.c                          | 10 ++---
>  arch/x86/kernel/setup.c                       |  5 ---
>  arch/x86/mm/hugetlbpage.c                     |  8 ++++
>  arch/x86/mm/init.c                            |  8 +---
>  arch/x86/mm/init_32.c                         |  2 -
>  arch/x86/mm/init_64.c                         |  4 --
>  arch/x86/mm/mm_internal.h                     |  1 -
>  arch/xtensa/mm/init.c                         | 14 +++----
>  include/linux/hugetlb.h                       | 12 ++----
>  include/linux/mm.h                            |  5 ++-
>  include/linux/mmzone.h                        |  2 -
>  init/main.c                                   |  1 +
>  mm/hugetlb.c                                  | 13 -------
>  mm/hugetlb_cma.c                              | 33 ++++++++--------
>  mm/hugetlb_cma.h                              |  5 ---
>  mm/hugetlb_vmemmap.c                          | 11 ------
>  mm/internal.h                                 |  6 +++
>  mm/mm_init.c                                  | 20 ++++++----
>  61 files changed, 219 insertions(+), 394 deletions(-)
>
>
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> --
> 2.51.0
>

Thanks for this series. When I introduced HVO pre-init, I noticed the
inconsistencies in init order, but shied away from attempting any
general cleanup, as I had only tested pre-init on x86.

With this, it should be possible to enable
ARCH_WANT_HUGETLB_VMEMMAP_PREINIT on architectures that support HVO. I
think that's only riscv and loongarch right now. But that's out of
scope here, though.

- Frank

