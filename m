Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29DAE77188
	for <linux-um@archiver.kernel.org>; Wed,  8 Jan 2025 11:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=20U5sO/u0uYru3hxNMHsooCdHBrAIIWG/43UdZigSIo=; b=FLcx7WPc48K7NjsD03QibYv5ra
	4bqREJh/t10wN3cXACbTqsUAhhu+bZ9XSuCJEkDYsHvrOrHUpweiiA8SzQ1x03Q/ZUhqmhGV9d2Vj
	TNj8Id/3sLrKcpVHnorrOGB2pCjMGqdLMLQ8hcB0ARWVForYzNmcpGf9SBzc4nrfCGaSgR4pTB0l2
	N2/R15/TesLt0mXVJrWzf4ceOr1sTkSpWAmhiDIE6qobvtSFqYiUesXvCqLwws47pvdZ+vBTphhOv
	utKtJBiQz0YOK0b9f+n1ulsdfvGodCQceZ3SZ4ag8mU/xJ8LPKg0KjdCB/NcG0uBgm1suFfVvtM6E
	yAEacqCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTwA-000000089Gr-26g7;
	Wed, 08 Jan 2025 11:09:22 +0000
Received: from flow-a8-smtp.messagingengine.com ([103.168.172.143])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVToz-000000087QD-25Tg;
	Wed, 08 Jan 2025 11:01:59 +0000
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 01AD8200CCC;
	Wed,  8 Jan 2025 06:01:54 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 08 Jan 2025 06:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736334113;
	 x=1736341313; bh=20U5sO/u0uYru3hxNMHsooCdHBrAIIWG/43UdZigSIo=; b=
	Cy+D97SpayPKf50CJRucU/OjuqxmZo1HPxdDHfFjtk4V4dzkHIGqqI4ZeTBGBIwQ
	CU43a3abN/lpxbZArBxq7/TC680Cne845B7Mt9ZmA7It+HSwgjARBYDZNaSmXNM2
	krcib2kkSpUfF5s2H8og+FziqnBYnNGV+oIkJokZXGPBRm2uRnZPUxupBCIsLyF3
	L95dQfXdiAUWRhy4AoFiIf7vssy39N0gIf97bLCYb6UE+9UATBG8UEmpoSxSvb3y
	VSe4QWYZNxY7/CiTOh3EVoghZyEg8uCRUsZwXWBw32ptH23GUNZihG2RL0COZuPY
	JUo0rYJf6FqI9B/v7Pe1QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736334113; x=
	1736341313; bh=20U5sO/u0uYru3hxNMHsooCdHBrAIIWG/43UdZigSIo=; b=M
	SIdJfQwmksvBJ00U9HcUOaODS1attuTNvWMQryD5z90DVgF6hJ7NU+/6na9R1zMX
	N4e5muAPBw/KbD4IiqcgMdfPyL5oytjmreBUaObCMGSlSguiImcZFV+PHOogQ0C8
	sfMV/tSn2hosWoXw0QfBP8yg8ww3eBodDuz6q/i7vkKifow1ceZYP7CRJ/mj2xVC
	a+qiTqelX8Gs/hSLYFr9PAhNoCapvXPNYTkqh4KLORdzvEktytEn7MA+4vx6ltiH
	wkTkgfP+WzoCXr6QB8GCjvYhe0eFs2cVoTQLmYEZANUV5rBtinqFmbMvZKxf3ghZ
	EQACF6/J+VIomkI/RscUA==
X-ME-Sender: <xms:IFt-Z6UmaWSjYb7Gh0zcpksWzDDdEPgfiSYLh-0i-y9aLcE3r6zD_A>
    <xme:IFt-Z2nOjzdfh823ysQc1S2oDX-1-nZXTq_53rcym6EIbKwXeGB0UjDLQAu3SVTJl
    FqMSA1gCW8wUUAwYWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepgedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkvghvihhnrdgsrhhoughskhihse
    grrhhmrdgtohhmpdhrtghpthhtoheprhihrghnrdhrohgsvghrthhssegrrhhmrdgtohhm
    pdhrtghpthhtohepiihhvghnghhqihdrrghrtghhsegshihtvggurghntggvrdgtohhmpd
    hrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghn
    ughrvggrshesghgrihhslhgvrhdrtghomhdprhgtphhtthhopegrlhgvgiesghhhihhtih
    drfhhrpdhrtghpthhtohepnhhpihhgghhinhesghhmrghilhdrtghomhdprhgtphhtthho
    pehvihhshhgrlhdrmhhoohhlrgesghhmrghilhdrtghomhdprhgtphhtthhopehhuhhghh
    gusehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:IFt-Z-aQ2SmgS3nXZ8HOHScIMD5VPYsyBFMZLc-J-VgcUAnAe2HzCw>
    <xmx:IFt-ZxXCvJZ1AcFo5fB-biVPFqTsSFdNnldK9XWf-i56cAUN39KLdQ>
    <xmx:IFt-Z0lFXSJuGe63NytzX7QBWDpUz5bkZTKgpNbVjZZcysvLCNf6UA>
    <xmx:IFt-Z2eyKBxnx9FUnENXCTF11sxAJ8UI5uJaB8BKG5BUdEYntabkhQ>
    <xmx:IVt-Z-tKPBuX6yCR5FGPupQm8IjlY8CNUkvhyqGI8S0AmCpHcXU81GMM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1006D2220072; Wed,  8 Jan 2025 06:01:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Wed, 08 Jan 2025 12:01:31 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Qi Zheng" <zhengqi.arch@bytedance.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Kevin Brodsky" <kevin.brodsky@arm.com>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "David Hildenbrand" <david@redhat.com>, "Jann Horn" <jannh@google.com>,
 "Hugh Dickins" <hughd@google.com>, "Yu Zhao" <yuzhao@google.com>,
 "Matthew Wilcox" <willy@infradead.org>,
 "Muchun Song" <muchun.song@linux.dev>, vbabka@kernel.org,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "David Rientjes" <rientjes@google.com>, vishal.moola@gmail.com,
 "Will Deacon" <will@kernel.org>, aneesh.kumar@kernel.org,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Mike Rapoport" <rppt@kernel.org>, "Ryan Roberts" <ryan.roberts@arm.com>
Cc: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org
Message-Id: <fd6e7ad9-9d57-40b6-a8f6-455ea3ab3d27@app.fastmail.com>
In-Reply-To: <26d69c74a29183ecc335b9b407040d8e4cd70c6a.1736317725.git.zhengqi.arch@bytedance.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
 <26d69c74a29183ecc335b9b407040d8e4cd70c6a.1736317725.git.zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v5 03/17] asm-generic: pgalloc: Provide generic
 p4d_{alloc_one,free}
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_030158_124962_7965B554 
X-CRM114-Status: GOOD (  14.43  )
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

On Wed, Jan 8, 2025, at 07:57, Qi Zheng wrote:
> From: Kevin Brodsky <kevin.brodsky@arm.com>
>
> Four architectures currently implement 5-level pgtables: arm64,
> riscv, x86 and s390. The first three have essentially the same
> implementation for p4d_alloc_one() and p4d_free(), so we've got an
> opportunity to reduce duplication like at the lower levels.
>
> Provide a generic version of p4d_alloc_one() and p4d_free(), and
> make use of it on those architectures.
>
> Their implementation is the same as at PUD level, except that
> p4d_free() performs a runtime check by calling mm_p4d_folded().
> 5-level pgtables depend on a runtime-detected hardware feature on
> all supported architectures, so we might as well include this check
> in the generic implementation. No runtime check is required in
> p4d_alloc_one() as the top-level p4d_alloc() already does the
> required check.
>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  arch/arm64/include/asm/pgalloc.h | 17 ------------
>  arch/riscv/include/asm/pgalloc.h | 23 ----------------
>  arch/x86/include/asm/pgalloc.h   | 18 -------------
>  include/asm-generic/pgalloc.h    | 45 ++++++++++++++++++++++++++++++++
>  4 files changed, 45 insertions(+), 58 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de> # asm-generic

