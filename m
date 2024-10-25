Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FF6D0C611
	for <linux-um@archiver.kernel.org>; Fri, 25 Oct 2024 13:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:References:In-Reply-To:Message-Id:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mTD/E8mUSNoNp+vtjeW8NYfb5u7ndnKHIytXzDhahwE=; b=WrIhvejXyWW3iSopR0gFO0MsPO
	g8TMivxeskoGdQvYWMj4jUMtsFMCE7/UXa+VwAgs4URdlDHW9Y0Br4oYM9ZBPtXOZEHYcUl4zdmRN
	ezxGrH5BgMcK7FnaDrgcHivxYTRJuvq/2y1sKePwCmP6T9DBgnrjzHvVCjoicTKPwTP6kWrBUX8ET
	tLwjWdFmCiFrgRnvDiS60zUN7UVpzPSIZeSpzkEauWH7fdUlw+zfAhFILenZCH5EPuMvzaw/9Rk5j
	q001kAKUE9VZ2EL3WNT4Ck5R9+M9y81+k3Vrr0SiPN+C7wge9iC+2cwbxU/J0Xz833XsXRhqdGowP
	YzSB4JUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4KnR-00000003tj5-0wOx;
	Fri, 25 Oct 2024 13:56:09 +0000
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4KVZ-00000003qFH-1iOq;
	Fri, 25 Oct 2024 13:37:43 +0000
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 54D1325400C4;
	Fri, 25 Oct 2024 09:37:37 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 25 Oct 2024 09:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729863457;
	 x=1729949857; bh=mTD/E8mUSNoNp+vtjeW8NYfb5u7ndnKHIytXzDhahwE=; b=
	nTq77u+YbjEK1oOGqWOEMss4pavBeea5xmfNB5v8n1RQ22NxJIlmfp2TzT4IKpOx
	caApVTp1/TP1+2AFsH+6DaC7B1jXPpi59lVd0QmK1g4cyigLCbwCjjCU5UZejO28
	8c3d8AGT1CdV1FpUSe8Ohc2JPaB0EAv7X1aw4eGMMqsDN9QNF4MBCkY7XT7NWXhL
	O/OEAgSYzhCEctYt3/dxus3LsMgxjvtStf4TUCEi3KDe+iRqYuAwvWG/ws/9TCTb
	91Febe33d87M4u4RsAc2PSDoS2l7TEXW3ZHH0N9mqk4H/wIO2sYqmM++nNVpXfOu
	l8mVjbE2Y3ckzB0U2VTGjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729863457; x=
	1729949857; bh=mTD/E8mUSNoNp+vtjeW8NYfb5u7ndnKHIytXzDhahwE=; b=Y
	Yd+CaNQUnHw9YsFM/xsr4EEUnyKUrgtD2vti8QGZood/Hu9648OKjYo4bH7A6Neg
	jnJDKNvwBYkFvlybTuqF2bH/KaZKDCsMPx9nvXzHCWTKjsCUnllyUHCbFyKAeDhX
	YNkya00Lwsz0+acBTk9P7pZOFNJx3BvJUubdQClXQQcfFmAJOHzcSMDEsFGYeUz+
	Jg9HE+6A7ymczxjo7UpkNZEyk9ue5mso6y8MDn4M5ldn8ZNSI/lsZrOwKW2qGN95
	SK1C5a5uk//QbB1mqxfMZZhPvCEMy7uIU9Opdu0mHCbXfdkyJRO6uRsr50PfJcTO
	dO3S1hvvUj92Ys457iJAw==
X-ME-Sender: <xms:IJ8bZxsuj29dJ1vr5lHn5cEFvY6c8AEcCMtZGM1az7Jp64ZRgbF05Q>
    <xme:IJ8bZ6f_PFYR1VPWQ6NunpU9GXYmb8uTFHK2WzhvwLuyhGpOciB1CBT9pvUeu8GH4
    UYBuOr6HJ-I4-vOr1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejvddgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudel
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnh
    gvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplh
    hinhhugidqshhnphhsqdgrrhgtsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhr
    tghpthhtoheplhhinhhugidquhhmsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpd
    hrtghpthhtoheplhhinhhugidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdr
    ohhrghdprhgtphhtthhopehlohhonhhgrghrtghhsehlihhsthhsrdhlihhnuhigrdguvg
    hvpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdr
    ohhrghdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehlihhnuhigqd
    grlhhphhgrsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IJ8bZ0w8_fyzDu0Dhxg43egcOQd9fPmeL9IF1HbPQzAPODUmdkywqg>
    <xmx:IJ8bZ4Ng8v61LIOz9Z6hcNW7TrkYDvZ9-QsNLZ7fNM7Okgrh7sPTiA>
    <xmx:IJ8bZx-O8B7MlF4JofybzIynmnGJvvLwnq8RLzH_1fknLv9ZsqMu1w>
    <xmx:IJ8bZ4X5lrN7iDkKbGm85k7BOBq5kmsTovQZ6V9cVszatdT146tmOA>
    <xmx:IZ8bZ02QO2wzbQXTtXh5NJPoq2r5QyMwBKYu4QPUoTFRk_k35DiZGUWq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3B9352220071; Fri, 25 Oct 2024 09:37:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Fri, 25 Oct 2024 13:37:15 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christoph Hellwig" <hch@lst.de>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <c9f10ee9-697f-4f45-8c82-a6dc61e5a74e@app.fastmail.com>
In-Reply-To: <20241023053644.311692-1-hch@lst.de>
References: <20241023053644.311692-1-hch@lst.de>
Subject: Re: provide generic page_to_phys and phys_to_page implementations v3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_063742_278560_741678AA 
X-CRM114-Status: UNSURE (   7.66  )
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

On Wed, Oct 23, 2024, at 05:36, Christoph Hellwig wrote:
> page_to_phys is duplicated by all architectures, and from some strange
> reason placed in <asm/io.h> where it doesn't fit at all.  
>
> phys_to_page is only provided by a few architectures despite having a lot 
> of open coded users.
>
> Provide generic versions in <asm-generic/memory_model.h> to make these
> helpers more easily usable.
>

I've applied this to the asm-generic tree now.

Thanks for the cleanup!

     Arnd

