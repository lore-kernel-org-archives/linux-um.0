Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059E3D0C5F4
	for <linux-um@archiver.kernel.org>; Fri, 25 Oct 2024 09:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yg5AKBXKZZilkI6bCi0Iv4cvoug2oLRsirD69IFYSrw=; b=WIiTet7uQ0ngw1geK3wWUCnhQI
	nEjtecK/yQUhreZrYeuMzOFlh2eaF1/vBFWyJ1qz7KvLt7WQZuCe6UUfIErFmPbvkL2A2GuXsYShu
	8Isjv4azoxgjj5C9pae05qL/iELvYUo56bMo4ZFWnhovmRD08HjGLOk7tInz6F71SVFw9K4iaxwc3
	ZhSOGep8Aai9mpT8bBS/9aVhOYqcDS8omZQUR/azRaIhvHHNg6QuplPdZHMkuNT0E0oYRq5stjcM7
	FIqMU5DQQD+gnN3ZsS9zGvDGH3SWSastCG5+9blXcs1WAYjQzzW4KbIaBitQYyml2B5VwIzvDY/PG
	IfujIGeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4GiW-00000003Bh0-3QB0;
	Fri, 25 Oct 2024 09:34:48 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Ggv-00000003BOA-3Dcz
	for linux-um@lists.infradead.org;
	Fri, 25 Oct 2024 09:33:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yg5AKBXKZZilkI6bCi0Iv4cvoug2oLRsirD69IFYSrw=;
	t=1729848789; x=1731058389; b=xUQOEttF95tp4ZxUFj+c2Hy2/dpxVNmF1AgiLR0GqJURqwj
	y98dquSv11VT8yC9hpXSb98GGGlLiCciCMo0S9r9uToL5EC9oqIG5hEDypSEUDRZrgY9wGESQy28f
	VeZu6oJiJ7FStkuOq+FSyUjTQmUTpy9fZFyCMMQAkUnVt2CdYKHHbwYsyU4wuJsjGzzAiAwT+ebdv
	FjvnrdqP+LeOXzuzBFSEPcxJ1loWyr4JhqAquQi9Qokp5wKRks3bHB6FIRRc7NWcs4yuIvxHy6lYZ
	OPhIWOwV7H4Yaw7ArCWoOySdKCA8WOeP6a/Le7gJ1poByZwHU5r8SMz8HLCDeT0A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4Ggt-00000004StJ-0zGh;
	Fri, 25 Oct 2024 11:33:07 +0200
Message-ID: <ce4a00dadcaf888ff1bf7887b3af722a385e694e.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 13/13] um: nommu: plug nommu code into build system
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, 
	jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: ricarkol@google.com
Date: Fri, 25 Oct 2024 11:33:06 +0200
In-Reply-To: <82a7ee8b31c51edb47e144922581824a3b5e371d.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
	 <82a7ee8b31c51edb47e144922581824a3b5e371d.1729770373.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_023310_159842_A4F4688E 
X-CRM114-Status: UNSURE (   7.28  )
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

On Thu, 2024-10-24 at 21:09 +0900, Hajime Tazaki wrote:
>=20
>  config MMU
> -	bool
> +	bool "MMU-based Paged Memory Management Support"
>  	default y

"if !64bit" or something
=20
>  config UML_DMA_EMULATION
> @@ -187,8 +190,14 @@ config MAGIC_SYSRQ
>  	  The keys are documented in <file:Documentation/admin-guide/sysrq.rst>=
. Don't say Y
>  	  unless you really know what this hack does.
> =20
> +config ARCH_FORCE_MAX_ORDER
> +	int "Order of maximal physically contiguous allocations"
> +	default "10" if MMU
> +	default "16" if !

Should there even a be user prompt for it?
Perhaps "if EXPERT" or something?

>  config KERNEL_STACK_ORDER
>  	int "Kernel stack size order"
> +	default 3 if !MMU
>  	default 2 if 64BIT
>  	range 2 10 if 64BIT
>  	default 1 if !64BIT

give a different range for !MMU?

johannes

