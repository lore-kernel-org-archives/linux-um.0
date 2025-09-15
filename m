Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8ADCAC58F
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 07:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=59eiYpGD8uho8aeaQI+TTJPc1va7kDm+pwBNsNnHp4g=; b=OCSfPTYaWWMR7jokaBuQ8C4vYD
	CTdoAOp/8e0kTOXxv9/PoA77RxTHg0hUxAIXWu2706+ntyfI8B1G2pPsjvhwBLdiy0Ps6IRh+mn+s
	DrGTBzf4lPrDWuefM46gRZX1H0Srm+q5yiJy70CFoIJ0AJSQ+4Rfv553DvBNoX8bp5qltNggMLWvK
	Vtwa50fppr7qU6SZVa3At8Hq5AhqsTCRFuujrnJ/G8k9qIu2au6Bs+qEVHV/tAamdLL/T7dJ9hwDy
	7enoyVVtKs6iD9UdQpJ40DuSBCtAnfGnel/gYTqvG+I8dGUTG5I92vxyxddvxKtY1Go6/Zln4W9xB
	uzc9x6JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3pc-000000035Sc-2Hnt;
	Mon, 15 Sep 2025 07:41:00 +0000
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3pa-000000035S8-1VWe
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 07:40:59 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 85612EC0200;
	Mon, 15 Sep 2025 03:40:56 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 15 Sep 2025 03:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757922056;
	 x=1758008456; bh=59eiYpGD8uho8aeaQI+TTJPc1va7kDm+pwBNsNnHp4g=; b=
	mPtOxgNjo3xL57GnKyn1Oub4BNkFSJTbQjrA25Qk7wTzXp7zgRDNdeT8mhDYYI58
	s1bMOIdnFtZQaX0bKa6dg7kgC5/JHn6Rc0WIqgDBPkaMxHMboJGQEee/2ScegseE
	Lzxa6o3nM9Pmwv/IFuTtr+36R5qtCvjNStI1sLzvRHXWFzCEYDrQtxST/wOfJkB1
	4MybNIYSAZaFPdaDXd/G39cAroG2loBR4tI2W6AE2e7mezsS7QsrN4AE9jWfdVUg
	ix1zg7v5A4Zj9+LkSSdfgwXRjngFCbu72+BKmASIaOqYfpyJkoNGFBjRcv0UxE7/
	di5FThC0cuz40ycMmVG8/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757922056; x=
	1758008456; bh=59eiYpGD8uho8aeaQI+TTJPc1va7kDm+pwBNsNnHp4g=; b=e
	6nKJ9MDSJz6fZT6mCvEDb+k714Y45hicwgsbF8CvrMEX+tcwzyOCTDyYno6mL5rv
	dZAOhYytgDsmlXsmFM/6V1YYsOrubfZ7NZWqJdDEfUU9waMYScxQS1O0aKjzXqYn
	LCvvAILtU31zg5ck5VYDOiCkPkRbTBo0yYVzwqZolWx8T+WHBpougBMXCAgtqfeT
	ATgwm0l+YXf32ESFdcP8m/uhkFHE5DDMG4LYXt9RupbRljhlevjJYQ8MG2IslFZm
	Y1BF4L5tvYYCm60V4at1igWuipiu2hZvF3WAa74naR/fYgruUoJSmDcOlbU71W0A
	2npYGA6bQbo/NqLEZrwEQ==
X-ME-Sender: <xms:B8PHaH9tbQsCrChGLgloB1_IAbGTWHh6o-5l9BiHWfHBkE_YAj2TgA>
    <xme:B8PHaDvVAYkskUkwS0SSDrhdO9IVfpfskdPqJT54PYyXn3ASFqpv-dQbG-vskBv2B
    7AC51zUs9mn-Mz6K5c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehtihifvghirdgsthifsegrnhhtghhrohhuphdrtghomhdprhgtphhtth
    hopegrnhhtohhnrdhivhgrnhhovhestggrmhgsrhhiughgvghgrhgvhihsrdgtohhmpdhr
    tghpthhtohepthhifigvihdrsghivgeslhhinhhugidruggvvhdprhgtphhtthhopehlih
    hnuhigqdhumheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehr
    ihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopegsvghnjhgrmhhinhesshhiphhsoh
    hluhhtihhonhhsrdhnvghtpdhrtghpthhtohepjhhohhgrnhhnvghssehsihhpshholhhu
    thhiohhnshdrnhgvthdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:B8PHaCPyj_mzqAbc_5mwxQSMBeUILdui4vNktCYRn6dr0e-fJ6CCZA>
    <xmx:B8PHaMrDv5ukvr64PMqBAQMBcwjTPZbxq3CbNz6BNDTVaKrguUhA-g>
    <xmx:B8PHaFvaOnUChVnwLUrgAv3eVEg_VN6Px7X0Ic6B7pqHbZCFQMy7SA>
    <xmx:B8PHaL2SPlwPyFq7zYl48_iYAe9T_srifWLyCIeHz9sCeiDtEYJOSQ>
    <xmx:CMPHaIfOY6scgdFUoqoin7pzKXtGNfmKJP5pr3kUM5gmcqshBSMSApf2>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7DC4B700069; Mon, 15 Sep 2025 03:40:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AAxI7Qcv7s-k
Date: Mon, 15 Sep 2025 09:40:35 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Tiwei Bie" <tiwei.bie@linux.dev>, "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 benjamin@sipsolutions.net, "Tiwei Bie" <tiwei.btw@antgroup.com>,
 Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <a10395f7-6666-4bdb-9aa0-bdd873029cc9@app.fastmail.com>
In-Reply-To: <20250914155658.1028790-7-tiwei.bie@linux.dev>
References: <20250914155658.1028790-1-tiwei.bie@linux.dev>
 <20250914155658.1028790-7-tiwei.bie@linux.dev>
Subject: Re: [PATCH v3 6/7] asm-generic: percpu: Add assembly guard
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_004058_472227_D1C6D6BB 
X-CRM114-Status: GOOD (  10.49  )
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

On Sun, Sep 14, 2025, at 17:56, Tiwei Bie wrote:
> From: Tiwei Bie <tiwei.btw@antgroup.com>
>
> Currently, asm/percpu.h is directly or indirectly included by
> some assembly files on x86. Some of them (e.g., checksum_32.S)
> are also used on um. But x86 and um provide different versions
> of asm/percpu.h -- um uses asm-generic/percpu.h directly.
>
> When SMP is enabled, asm-generic/percpu.h will introduce C code
> that cannot be assembled. Since asm-generic/percpu.h currently
> is not designed for use in assembly, and these assembly files
> do not actually need asm/percpu.h on um, let's add the assembly
> guard in asm-generic/percpu.h to fix this issue.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>

Have you tried if you can remove the percpu.h dependency from
the files that currently include it? In many cases it should
be enough to use percpu-defs.h.

If that doesn't work, I have no objections to this patch either.

Acked-by: Arnd Bergmann <arnd@arndb.de>

