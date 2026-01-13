Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A59D2D0E7
	for <linux-um@archiver.kernel.org>; Tue, 13 Jan 2026 12:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:Date:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j4BCb4tuwUydlXX/lekB/MWAbo5xTWmBY98lhxIZgCk=; b=xIkH1/pqYVS3x7gJLXjQdkGJ02
	8THow8D5oCoiCT3HLXbvU3INCJK5UdBL7R9u6fcUPJz6hIT89RKlDH38+MDHfVWIocPAV9O+Lia5k
	4dl0O1j1WdGWSXg4RyVPN9K9T9oirP2G9YTHvFqAcWkDkqM6V3dnMgtEh3Yl3v8UTwvWPLP6nPsoG
	uEKZ5az7hB5WUIlM4veCkdbpG0hgu4hcwqxUt6nh41zCyZFA8T6/mbXZBHrHpXzmHyF8/3mv4m6o5
	ik3sufb5l2gEa4oxzN39Wwtyu//4P2NhFGWMNzcJCIG/lvhIUT9zVcDAXaGZEm0JqTi43sP3DMtcp
	0x0My7CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfdaV-00000007553-0VPj;
	Tue, 13 Jan 2026 12:33:31 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfdaT-0000000753p-1NEC
	for linux-um@lists.infradead.org;
	Tue, 13 Jan 2026 12:33:30 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-c525de78ebaso2161382a12.3
        for <linux-um@lists.infradead.org>; Tue, 13 Jan 2026 04:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768307607; x=1768912407; darn=lists.infradead.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=j4BCb4tuwUydlXX/lekB/MWAbo5xTWmBY98lhxIZgCk=;
        b=JrB/OsD3UcJaQwF+E/jvirHSJHGhEjGawtu9Sz3J6QPvyQDozOlMOvMJyGNF7M+Esm
         WEMKHZnFPb13aH9lSgtV3nnhje+syAO5735tmcTRBQ2XELXK9FBIZjzcHgiHYKM0XCPr
         yfLqf/aPA5oEAylAU6btlkiWRAxv2+lNvyzvbm9tim7nutg4CJiL9FVXXHiSIA6n0arP
         cB3RzDtaNZQbB22XqbeztnjqikHclilYULeP8ty5n1tV8jzQy18kTl6WF7kXKGEP85SY
         VQsFq3u9Oaj7j6mVC7SBsoxUwWyxwffs5gZw4KHmZnuPw6VCseK82OuObcHKQ8JlUpOP
         G5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768307607; x=1768912407;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4BCb4tuwUydlXX/lekB/MWAbo5xTWmBY98lhxIZgCk=;
        b=YvmqokZrrUukPSLWQ6fFVmvjm9IH0dXYzfxdQNKJAHBex3bDy0jpMt4c+gZFq9vj/z
         hsMM46qUjMY0kT89cK4wl4iaRidWFqT5sb70U39053C+r90E3I3/HnoR88Dp5TYRzk4q
         +rUTYaf31pjzxh0u3bijV/o9OuZnhui6piBqVTHRozcOylFBC+c1V9A/6oeOUnohWDaS
         DcKE9XQPISx6n3BmiSTYw+clX6tB+3M6N6jdpX1Fshcnl8LcrSh/m9JTyCVVigVgSTHu
         zbiXr5r8OUZyEaYATGAwFK1AmkNmco2KrsbJVaUEOS7ObzFLWzVJ+O5wsLKyvvivMLQa
         Dq1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUitVAdNJji4h4BAeT159R7h8Cfa2tefZsG0e73eYCyHN7bLTyarnQAubxaFem6Obj2KGiRGfBpPw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy1lFLqrSysOfgXZZbu14fkgAKJ0tVhaYNN6OH4tQecil69OpLG
	OOorgRIHcXZ3/D0id3FaNrclu7q+M7cX0nyghKmGWLEcLjm8WnVCGiGa
X-Gm-Gg: AY/fxX4MvHqAwUk33BXITHWTbO+yXk3ObYNWqn4NX4E9nUU1q52eP15scP9nMFpzXDT
	wpyY0eNfAalw2swVSJPUi7EKJLqCOhbGo6IbPfiFNoqP5DbDM8kxaxw4ccxiFd8po5au8RePTDo
	ZvOjCIzvKYnRtvKV0jhpbpYSUyyx4cX8qfs2mj8C5ewHrPyvMRlD7Av80L7XV/diPbSPCFBIb36
	IQVu9AxyBj4kCQn755WGnUzSyT5FegM4ji4gWEHmmAG+CMXNFPJZPdk82TmlsvQOfy9lzUBTYdE
	+1Eov41U1L41JuiEI+FLK93bXrW9i8G8m5dLcaQchuFzBPrfuF7I7PVh+ZAS1x1elQK949+FjGU
	XFQGHgLuOgbH5CCxU1hvstauD/KnnG0ZeDH/z+brktHE1tbqbF+MsNsRAfg8d97v8duMHgRkG3Y
	Ed/bj5
X-Google-Smtp-Source: AGHT+IFw8NQUhXWsNFLNcy9VnhtaeqSccMp4bageDierszWlx1Kxyih6osyfD1+uAcqTN4o2oK4SYQ==
X-Received: by 2002:a17:90b:3ccc:b0:340:9ba6:8af4 with SMTP id 98e67ed59e1d1-34f68c47f0amr18570023a91.35.1768307607428;
        Tue, 13 Jan 2026 04:33:27 -0800 (PST)
Received: from dw-tp ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-350fd6e343bsm1428958a91.1.2026.01.13.04.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:33:26 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	"David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonathan Corbet <corbet@lwn.net>, 
	Klara Modin <klarasmodin@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Magnus Lindholm <linmag7@gmail.com>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>, 
	Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
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
Subject: Re: [PATCH v3 15/29] powerpc: introduce arch_zone_limits_init()
In-Reply-To: <20260111082105.290734-16-rppt@kernel.org>
Date: Tue, 13 Jan 2026 17:59:49 +0530
Message-ID: <87zf6hu24i.ritesh.list@gmail.com>
References: <20260111082105.290734-1-rppt@kernel.org> <20260111082105.290734-16-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_043329_408751_4C571486 
X-CRM114-Status: GOOD (  10.76  )
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

Mike Rapoport <rppt@kernel.org> writes:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Move calculations of zone limits to a dedicated arch_zone_limits_init()
> function.
>
> Later MM core will use this function as an architecture specific callback
> during nodes and zones initialization and thus there won't be a need to
> call free_area_init() from every architecture.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/powerpc/mm/mem.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

This v2 looks good to me. 
I have also done a basic bootup testing using Linux PPC CI.

Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

