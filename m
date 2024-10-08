Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B4FCEF163
	for <linux-um@archiver.kernel.org>; Tue,  8 Oct 2024 12:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UAD8NfSy5gmGeQl+E5iRkYF97RER4uEtGdtfvJHOxzw=; b=srjz25yzNiE3fJ/14Tki/D5tms
	8YnJLc/PPIzJ2nFbUilPftFe75tyjwkYn7l8LZiH+Z+JdA3Ooz+uFnHDhgwpy5CTdI1+AjfPKpMWY
	NCJpFwvTljGLA7vcfeEBeyF3kLE60ArRLjg+HGyaDk0v90JcDN/FDwE8YLQ0rwUkNnHY3fcMeX3Qe
	G1YddeyYPT1LLkaAFvHHHxBypTnR4Ey+mhzS6Wf2q50E27bJbMRbLGlCDxCNHA4VjgAtnj1on8SW4
	L0JMK8w76BPTcFUWQKrbj7Ie06m5zcyr6N7CxfpddcRrFgtym3sW20UnU2h5s5NBSz6wwZ5ofEuf1
	xxEtBEpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy9NG-00000005p2b-41g8;
	Tue, 08 Oct 2024 12:31:34 +0000
Received: from flow-a3-smtp.messagingengine.com ([103.168.172.138])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy9Li-00000005oj5-17a0;
	Tue, 08 Oct 2024 12:30:00 +0000
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 3443C2006F4;
	Tue,  8 Oct 2024 08:29:56 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 08 Oct 2024 08:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728390596;
	 x=1728397796; bh=UAD8NfSy5gmGeQl+E5iRkYF97RER4uEtGdtfvJHOxzw=; b=
	sP5CoCMsvWtNg92ykp0ui/Ue3nHw3oTNECqS2IzrNwt4GIFIv46ErsPMVU60J3Lu
	ddjCzsPXinEkY342h4vUYYG6H430MbR8qbJIJLymtNK/kulDuSBqVMPA+Fe3Uysq
	J0wTpvL0pM/tGj43qO8NxS/yK+UPWz9rH7yq7UCCatZYhqtnXIxJpBHY1klSBt8P
	moR3Kg8daYHw1IxfJXNw/o+tFc/45rkbq071DwQz6OvaaZUhjHJ3pH3DDomH+aFp
	qfAHyGcT47cxz9/FWB5i39qPIxLv3IvE2SZa0eJCYz2ZaS7a76zc13VKEi8jx9zB
	dzRgrBBoG9ybsWIuqi/fPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728390596; x=
	1728397796; bh=UAD8NfSy5gmGeQl+E5iRkYF97RER4uEtGdtfvJHOxzw=; b=d
	UrYXwy1mGCaJxx8eNdVrRYylV15yjyqyPiXWJGQmD5t6JaMa3ZkBzsvHoUxahe9p
	xXBwOSmVP9TA8Z6nMsj2mTIJsOSKKTGRFnRvAU90kgHaTg9JyfD56rhdiwCFOhf/
	buWc6cxz74kFCmsPSIu2gxefNTm/euHmH4XUVPDDzAzkG7dCAMctG2n2hMwuxHAH
	BDdoMDI5BQhtOZkumlVGHyd9lXc1ILcKkXH2GUNFCjB6zG/wRdN+kRzMtyNp7z+w
	1D1kkuYoNpDCE6oybck8EfdSCXxITtIaQ1nA/I+TF1HodWOYtC2h76Nyeyy57XyY
	xPXJA2L6tn4kwoV1/+x1w==
X-ME-Sender: <xms:wCUFZ-iJGwvzPE8nix2a16h8A0_vo8cISUscsF4O6JEnEffbmvmyXg>
    <xme:wCUFZ_BDdhL9_G1zbpqk3xOVURIT3K8CJ2iMVRamFnZ8WfRCOQ8hxy167-oqfHgir
    CKwhoc8utZ3SCm6H3k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohephedt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrg
    hssegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhg
    rdhukhdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtoh
    hmpdhrtghpthhtoheprghnthhonhdrihhvrghnohhvsegtrghmsghrihgughgvghhrvgih
    shdrtghomhdprhgtphhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhroh
    huphdrvghupdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghp
    thhtohepmhgrthhtshhtkeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhhpihhggh
    hinhesghhmrghilhdrtghomhdprhgtphhtthhopeguvghllhgvrhesghhmgidruggv
X-ME-Proxy: <xmx:wCUFZ2HlBNZwY4mnSHZdZzNxbehNHwgnB8hhonJDgBbKx7vaVDsgcw>
    <xmx:wCUFZ3Q8el7Z6qda2BHCthGLfbb8Ds2qtqLa_KfBmYIKmAg9lJJooQ>
    <xmx:wCUFZ7y5j5vRnz5oY_e5dafS_A-mhgmr-1-4cOE22nlDwH6iZgDIxQ>
    <xmx:wCUFZ16ZRx-hWNNhZ4rr0wnQvf9zcQoVo1SURaXHKlp5EwELdbn_tw>
    <xmx:xCUFZ0CHdFwvQjJDwttyR4lvWRMhmyKj7_bs2R_T_Z0KS-c7GPljodcN>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C4FC22220071; Tue,  8 Oct 2024 08:29:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Tue, 08 Oct 2024 12:29:32 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christoph Hellwig" <hch@infradead.org>,
 "Julian Vetter" <jvetter@kalrayinc.com>
Cc: "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, guoren <guoren@kernel.org>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Helge Deller" <deller@gmx.de>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Naveen N Rao" <naveen@kernel.org>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-sound@vger.kernel.org, "Yann Sionneau" <ysionneau@kalrayinc.com>
Message-Id: <b54a6f76-fcfd-40bd-b478-ca0a7e1af128@app.fastmail.com>
In-Reply-To: <ZwUbsviaqFUtjKEQ@infradead.org>
References: <20241008075023.3052370-1-jvetter@kalrayinc.com>
 <20241008075023.3052370-2-jvetter@kalrayinc.com>
 <ZwUbsviaqFUtjKEQ@infradead.org>
Subject: Re: [PATCH v8 01/14] Consolidate IO memcpy/memset into iomap_copy.c
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_052958_744876_71751079 
X-CRM114-Status: UNSURE (   8.40  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Tue, Oct 8, 2024, at 11:46, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 09:50:09AM +0200, Julian Vetter wrote:
>>  lib/iomap_copy.c         | 127 +++++++++++++++++++++++++++++++++++++++
>
> On top of the previous comments:  this really should be iomem_copy.c
> instead.

Right, I suggested adding it to the existing file since the
functions are logically related, but the naming of that file
identifiers in it is unfortunate:

__iowrite32_copy/__iowrite64_copy/__ioread32_copy sound like
they are meant to work on both IORESOURCE_MEM and IORESOURCE_IO
mappings the same way that iowrite64/ioread64/ioread32 do,
but actually using them on x86 port I/O (from pci_iomap or
ioport_map) would lead to a NULL pointer dereference.

      Arnd

