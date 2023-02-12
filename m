Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F44C636D3
	for <linux-um@archiver.kernel.org>; Sun, 12 Feb 2023 17:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9SK1mBL8zwgM/hYx62Ce27FN0ZHrrC0UQwA/5s5udF0=; b=XTslOqHIJuCEzQ
	rpr2AZA+CZQzjzH2By84J2gbjifMdYepDe+5+hjxtEwcGM75OIUKU1Lqj0dOgfxarWQD1AP7zOrjL
	jFb6HZLQx/6zlb6fSrzVsirNalwXFKFasxl73eIGT4NPgBO7xx4AuwnVhL51cfWFtddSKhCdaJU4g
	jLkV0zu8r0U0FDSPS1Ty9W+LtvhDG7ZXxA8n/FupkDi23b8eMID/lZIuQEeu7QcQYQXJtohpHI8g4
	4tb0flIArNStVT1ElyzxXRU9K4Ye9hKJSjCZw28ns8+G1NG8HypKUxZrjPw5Qg5Hc36rWv0F+i52J
	Xh4Fr3KtwNhDIQy6oK5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRGGH-00BydL-D8; Sun, 12 Feb 2023 17:35:37 +0000
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRGG3-00ByY9-8V; Sun, 12 Feb 2023 17:35:24 +0000
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-16dcb07b805so6291476fac.0;
        Sun, 12 Feb 2023 09:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AviV4NP8CNDKVbz9j5WTQQVcHZAFX3ps8TmNJsoE4Jc=;
        b=MHIS9yiiSKowWCqVfdLqqCBXCJI87xi4ik1euT9MI5qsuF90euB0z5OyKuHA+cX91w
         YM7Wr6xuS7Jsgd7Y/u17CKVlvOwGsLCmOXhdEeanSjtI1beQ/D1NtEqo8E4P8eQmjrlC
         u7UFMNCSnuCP/T/T+tikXDIsSQMmHH2xGwg65Lv0VkoYlNQzShkSHlh6NsCvKZch8Vej
         m1HG5S97Md/HphSzvy3Z1aOcBibylidfKFslbj4nzbnKfNRe5nxJQMAlztxOYwkeDTKX
         lJ8sbGZbHDOmiA/KDUs9NhF4Uu6i1LxZhJTamcW/BCuJlw1+7dh4aeYpmNhWCcX+M886
         twIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AviV4NP8CNDKVbz9j5WTQQVcHZAFX3ps8TmNJsoE4Jc=;
        b=c1IpwhtiObbOWgBsFEzWni8Tti4ZVrDw4ZiUtNOvXW80RaQLbPn9cYAGbjTUKVu2Pe
         +zy3VSomsvSlqUn2WS/HuQ61MP++MJ8bN0K+x4mH8nYo8ueeSesL7ft5Kn0kYAqXF49M
         ZQtoRTXnY6E91TEajJ4EmCs8yLqB0p/I2HfyH2VtPk7o7n5nEPkxfgiRCOIAdhhFHuYK
         BuSWStRmQUb2MGUvqcGsQ5mdZhFqKERFcPQvE+iAqY2R2qqDAPHMSRWqz67N5yBrDnLC
         AzTXyiIM4iUhi4BHXoF3XkYpn9hgMx3v7COkotz3jfN0virXHoZqSpW2ysTuPn5a9eAU
         irPw==
X-Gm-Message-State: AO0yUKUI75BrRRO21lCr3bpkh1VEIsoZn2HTELusrTJEdpMvC3lwNT7F
	EmXixJx5WS6CLpoFTEYGAoE=
X-Google-Smtp-Source: AK7set+HQUfu5iOqDoYfEGRzO6Asv+HJqu3wHpvaAM105ZXPUWPVLHg/VWo/CEfIvczS113vNKvB7Q==
X-Received: by 2002:a05:6871:9d:b0:15f:32b:6e33 with SMTP id u29-20020a056871009d00b0015f032b6e33mr15518149oaa.39.1676223315946;
        Sun, 12 Feb 2023 09:35:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i9-20020a4abc09000000b004a3527e8279sm4076452oop.0.2023.02.12.09.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 09:35:15 -0800 (PST)
Date: Sun, 12 Feb 2023 09:35:13 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Vineet Gupta <vgupta@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2 2/4] m68k: use asm-generic/memory_model.h for both MMU
 and !MMU
Message-ID: <20230212173513.GA4052259@roeck-us.net>
References: <20230129124235.209895-1-rppt@kernel.org>
 <20230129124235.209895-3-rppt@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230129124235.209895-3-rppt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230212_093523_363227_B9B2CF01 
X-CRM114-Status: GOOD (  12.70  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi,

On Sun, Jan 29, 2023 at 02:42:33PM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> The MMU variant uses generic definitions of page_to_pfn() and
> pfn_to_page(), but !MMU defines them in include/asm/page_no.h for no
> good reason.
> 
> Include asm-generic/memory_model.h in the common include/asm/page.h and
> drop redundant definitions.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

This patch results in a boot failure when trying to boot the mcf5208evb qemu
emulation. Reverting it together with "mm, arch: add generic implementation
of pfn_valid() for FLATMEM" fixes the problem. There is no error log - the
emulation hangs silently until aborted.

Guenter

---
bisect log:

# bad: [6ba8a227fd19d19779005fb66ad7562608e1df83] Add linux-next specific files for 20230210
# good: [4ec5183ec48656cec489c49f989c508b68b518e3] Linux 6.2-rc7
git bisect start 'HEAD' 'v6.2-rc7'
# good: [94613f0efc69ed41f9229ef5c294db3ec37145da] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good 94613f0efc69ed41f9229ef5c294db3ec37145da
# good: [19e62c715fe70dae4582c2874ed3e66715d09af6] Merge branch 'rcu/next' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
git bisect good 19e62c715fe70dae4582c2874ed3e66715d09af6
# good: [5d8b7ecef7f4a681b6e5538db59ff26c389c0ab6] Merge branch 'for-next' of https://gitlab.com/peda-linux/mux.git
git bisect good 5d8b7ecef7f4a681b6e5538db59ff26c389c0ab6
# good: [c349bf6ec83903b20fe570c5609b9a864a64e09c] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git
git bisect good c349bf6ec83903b20fe570c5609b9a864a64e09c
# good: [5a06a9f17454df38f35672be522ff5eb9b4277d2] selftest: add testing unsharing and counting ksm zero page
git bisect good 5a06a9f17454df38f35672be522ff5eb9b4277d2
# bad: [f5d115a7b06e5661ed5218ffa9a2644c4ff1c135] Merge branch 'mm-nonmm-unstable' into mm-everything
git bisect bad f5d115a7b06e5661ed5218ffa9a2644c4ff1c135
# bad: [acb018d6ea0c055381fba7dddaef386ee28f8075] mm/vmalloc.c: allow vread() to read out vm_map_ram areas
git bisect bad acb018d6ea0c055381fba7dddaef386ee28f8075
# good: [1a5d9782ac969dc6e61c6786500b5160603188ea] mm/mmap: remove __vma_adjust()
git bisect good 1a5d9782ac969dc6e61c6786500b5160603188ea
# good: [4b32363697de957dcc890b6245bec3f58903639a] arm: include asm-generic/memory_model.h from page.h rather than memory.h
git bisect good 4b32363697de957dcc890b6245bec3f58903639a
# bad: [328cf3fa6682ce6a4de6f8bb8009c833dc33f3c8] mm/migrate: convert isolate_movable_page() to use folios
git bisect bad 328cf3fa6682ce6a4de6f8bb8009c833dc33f3c8
# bad: [b704c765b08cabe82adf76a4d1a74f3688eee410] mm/mempolicy: convert queue_pages_pmd() to queue_folios_pmd()
git bisect bad b704c765b08cabe82adf76a4d1a74f3688eee410
# bad: [e5734c8b0edfd2a053a5c256189586a3b1e9f63d] mm, arch: add generic implementation of pfn_valid() for FLATMEM
git bisect bad e5734c8b0edfd2a053a5c256189586a3b1e9f63d
# bad: [ad8aecea034c591b9754bc5908da9719853aa7fa] mips: drop definition of pfn_valid() for DISCONTIGMEM
git bisect bad ad8aecea034c591b9754bc5908da9719853aa7fa
# bad: [1f6271a0dfdf952c2e3981f424784d48f243a2be] m68k: use asm-generic/memory_model.h for both MMU and !MMU
git bisect bad 1f6271a0dfdf952c2e3981f424784d48f243a2be
# first bad commit: [1f6271a0dfdf952c2e3981f424784d48f243a2be] m68k: use asm-generic/memory_model.h for both MMU and !MMU

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
