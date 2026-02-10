Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B32EA8129
	for <linux-um@archiver.kernel.org>; Tue, 10 Feb 2026 14:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jNWP9iqlvwh83wB1j0uD2/DZwiUKhBK19x4095q7W6o=; b=M78nESwzNoJdpxxHSzB0i0MLl6
	D2Yn5rcbLonc+ijB6AhNUS9AA9olwD7ifaG1nh5snyW6GEQK2eR7PMHCFqNyzTvvAUSXS19yzc0OY
	djVcvfbTRNElVxlXN0bzy7XUmVuyKlFi1u1ZPIDfZRzWGTiW28dlAANsfMnVQdsp6fFSqXZPe+X5K
	gJZuwYpsWFuDmWozhcJ2KI9eCEa3MtXWDf+vCIqlXxj+/6tYMtepjH1sf0SafIGFH5WOWMxeVYS2J
	9dBUrA9TXXGsIJbyTpUCf+dNZMW5IpJ7nqIeNhpt9wQ1/AeiOvyOyJf8wqADduJJSpKdwqk95HkK/
	sm4D6YmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpp4K-0000000H4P1-0Lad;
	Tue, 10 Feb 2026 14:50:24 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpp4F-0000000H4NR-2VPF;
	Tue, 10 Feb 2026 14:50:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9BDB860137;
	Tue, 10 Feb 2026 14:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E02CC116C6;
	Tue, 10 Feb 2026 14:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770735018;
	bh=YqNhqDan6ig5Eg8FfWiJBfgfNLXjdOvNf1vIcFRh5H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W3ex2H+6njMxfdkQtt4hfXP8xNYoYvUybMgCjkdXkRHCgKGQQudxPVj6r6Yq4X87J
	 qKQk4SPbkNxJjifgbRHYB0LIbaEKgNT1q7EAGZDodtYWpYtXt+PLTjreRRyYh0ZuB+
	 0XRCg3HQoTLA4LhyIdFuLZzdVr/SSw9/Ndr1QL+8Jlw7RzN+PIW/LRCopkpQH6Rwal
	 J24gsB2JhUZnmKMnS2yaIoTinVPtyDQgj4UHrG750qhTNlhIvb22kewZVjFgo8FCOz
	 fm9CerA5/tgkSQquoEeuWIQfz2qcaZ22uCaDVSNGjTWlgBnoS+i6Uy7a10vU89BO1/
	 TkxTBVLkg+EFQ==
Date: Tue, 10 Feb 2026 16:50:00 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Vineet Gupta <vgupta@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v2 2/4] mm: rename my_zero_pfn() to zero_pfn()
Message-ID: <aYtFmCQQMYkZh7Wh@kernel.org>
References: <20260209144058.2092871-1-rppt@kernel.org>
 <20260209144058.2092871-3-rppt@kernel.org>
 <0f15b363-a5e5-4a58-89b0-13b5112772b0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f15b363-a5e5-4a58-89b0-13b5112772b0@kernel.org>
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

On Mon, Feb 09, 2026 at 04:08:32PM +0100, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 09/02/2026 à 15:40, Mike Rapoport a écrit :
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > my_zero_pfn() is a silly name.
> > 
> > Rename zero_pfn variable to zero_page_pfn and my_zero_pfn() function to
> > zero_pfn().
> > 
> > While on it, move extern declarations of zero_page_pfn outside the
> > functions that use it and add a comment about what ZERO_PAGE is.
> 
> I guess the idea of the extern declaration being inside its only external
> users was to ensure nobody would start using it directly, hence bypassing
> the overloadable helpers.
> 
> Should we at least call the variable __zero_page_pfn instead in order to
> warn people that using it directly requires care ?

I'd better move it back inside the helpers.
 
> Christophe
> 

-- 
Sincerely yours,
Mike.

