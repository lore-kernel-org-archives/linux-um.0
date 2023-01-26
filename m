Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBB5C54E94
	for <linux-um@archiver.kernel.org>; Thu, 26 Jan 2023 07:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UMPNGf9XieWc4oe5BKRxLipBC6MfVnNmx745yzQl1mo=; b=lWV0u2xUR0L9wf
	/tWgJjOs/P0MXM1uUuNDDX/+V3TFGtIulHOO9A3XwXDn7fdXbtbjbCFXTi/H7GQ2Py0O4sZTUWrT4
	1d81F9Qbvt07PDRBFk+/uYE16mRNchZVewghpg8JjIQM0cnIhx2tNDILTRnZbbYCZKNu3uypGScHN
	LOVa0kgeuSF74olLXX6dPESLuaHw3/+pJ64zBlJR/nXdwQ4aP04hjqfTVgiVrb3PVGROUjHABBdJw
	p8xTLvXoYK+pBLGUG4vO87q7fIi07OpfhVeJ/caWoJ5Of3QE+hWBP7hi56HtgKMk3WYAZiVJ1uU33
	Hn1yEG99EZJ74QjNUl5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKwas-009pkc-Lj; Thu, 26 Jan 2023 07:22:46 +0000
Received: from new2-smtp.messagingengine.com ([66.111.4.224])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKwan-009pj3-AU; Thu, 26 Jan 2023 07:22:42 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailnew.nyi.internal (Postfix) with ESMTP id 84E2258287B;
	Thu, 26 Jan 2023 02:22:36 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 02:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to; s=fm2; t=1674717756; x=1674724956; bh=E33V4yTgr/
	ebT73Eum3QUd1t2W82YQcLJ50MWaQWWA8=; b=GiLb/skMhyZcQ01dO+WmZTL0hL
	fZ2ikfEbw6M+0GfWoi9BCHFyTrzd/xw84UaBaAMBNbekfpfzAvn0+3OyIl7DpZIk
	AscfaN2jhi+H4+HQPHW6kdeYv0wuJbvXO+Nmf3robmrH9p5Eaz+pTFIh+gw7OUdr
	GHaCtnvyFflXRN840zxE0TueOxb7X1UKgvjA9BbNkN54rpLAR1FBHefwPtJLfO63
	HU5voKjovLZNYSTASSTneRk9lhMeYYIxU5ah7ERIB1I+Tlqz6Sh6cL1quV9LIBsu
	LJGaa2P7uDg6V7dGWcg5+AdhatDXLV001yKTEzZw6AETD2Ctpr5noVgk6LyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1674717756; x=1674724956; bh=E33V4yTgr/ebT73Eum3QUd1t2W82
	YQcLJ50MWaQWWA8=; b=i56wP0aRGUynM8c34e7C84YjtNs5ESnKIS4Qk9sa0afa
	hZ6EA3tyzNwBZXGsbGt4dL3J7JuIzcSWHi3zNRP0iTUuzQE6/UwhR5FhRpLn/ouY
	xt6qq+vPBvkzpCHoSxo03igHd1P6lM5xa5cKrF0kUrwg7q2T50CTjxmrDjS0magc
	ZxGVHrCofyRHgqO1ckZj1XRFm2MlqCsUcWY5ZDdbx7SuYVnKPtd0L9F879LdS+aK
	Dn7zgQYu29nT9qh2c89O8Dw8mgobJhwQ28spFTbeCvY5iq0cHOI93ldlBxi2zZYx
	hCfhfAJXQq9sSPCh3KQtBHwxvY8+uaUayqJxJdu1iQ==
X-ME-Sender: <xms:OirSY0UrLGgYH3i-5TBnXx5kCGsN2YicrY23OHL1XQjg0oxapCF8GQ>
    <xme:OirSY4mGQAtxHP9bCv1xlHPGN64L04ZTpqbp3Zo_GJISeoNzutpf4eILgOt_wG15N
    1B3TnHPfXPQ5aq8ZzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvfedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:OirSY4a2BI8A8n6QHmfRNwvlyjZb0oHPUIh8AqkYJFN6HEjTyNF3mg>
    <xmx:OirSYzWHad1gVQ1pUnGhOP8BKq_-7XwGF62Qeq8f9YbfS8PPn3iaCw>
    <xmx:OirSY-nzh-yZLlxChEUc50uhXtONqG_p56LYIjKU8LygqILAOsLvJw>
    <xmx:PCrSY4uHnBHnmZDNTb4kWTrj5YTK-XYwojaMEFC5m6krF7i9k40zBQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7FEEBB60089; Thu, 26 Jan 2023 02:22:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <03605ec4-3e31-475e-8acf-2c342436aa24@app.fastmail.com>
In-Reply-To: <20230125190757.22555-4-rppt@kernel.org>
References: <20230125190757.22555-1-rppt@kernel.org>
 <20230125190757.22555-4-rppt@kernel.org>
Date: Thu, 26 Jan 2023 08:22:15 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mike Rapoport" <rppt@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Brian Cain" <bcain@quicinc.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Dinh Nguyen" <dinguyen@kernel.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Greg Ungerer" <gerg@linux-m68k.org>, guoren <guoren@kernel.org>,
 "Helge Deller" <deller@gmx.de>, "Huacai Chen" <chenhuacai@kernel.org>,
 "Matt Turner" <mattst88@gmail.com>, "Max Filippov" <jcmvbkbc@gmail.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Michal Simek" <monstr@monstr.eu>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Rich Felker" <dalias@libc.org>, "Richard Weinberger" <richard@nod.at>,
 "Stafford Horne" <shorne@gmail.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Vineet Gupta" <vgupta@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 linux-alpha@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux--csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
 x86@kernel.org
Subject: Re: [PATCH 3/3] mm, arch: add generic implementation of pfn_valid() for
 FLATMEM
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230125_232241_747979_6DFCC6CD 
X-CRM114-Status: UNSURE (   8.63  )
X-CRM114-Notice: Please train this message.
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

On Wed, Jan 25, 2023, at 20:07, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> Every architecture that supports FLATMEM memory model defines its own
> version of pfn_valid() that essentially compares a pfn to max_mapnr.
>
> Use mips/powerpc version implemented as static inline as a generic
> implementation of pfn_valid() and drop its per-architecture definitions
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I assume this can best go through the mm tree, let me know if I should
pick it up in the asm-generic tree instead.

     Arnd

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
