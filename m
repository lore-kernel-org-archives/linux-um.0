Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514B4D0C5EC
	for <linux-um@archiver.kernel.org>; Fri, 25 Oct 2024 09:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0wMyGr/dlrWZ8eZOB+DkiFR2IQ4b4CzX3tGiTWgNJp8=; b=p6vzHVMNMLwobLwsCxWR516+3o
	CYUBZAlaR92Oj+HZF2wOaLcBK3J40vfnX5l/eYUpsEZQztsVeey5AZxQFz4Cb+kv60T4xFtmHCVHj
	lNECt3M9btPlIM8AvvUCwb2RrjyWTHnmP4hHm2Bv1/cy39LkHzMJvbpFzX55/V+S0NzI77occl0c8
	CR+nSuoiKD2Ahkm5MYyWULJ8TuNEgY3IRbA8NEAiDoMwBOGVxJrV0IyeLbiD9cMT/UgeIzUFN1VkQ
	m7/ortt617HN/NhADU/RNnGbRrQfzsmd2Q8QrNDAeqsO2U5ifCM8bRkiE6vTNz1Mp+x2oBAGI+NWC
	CcDdofeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4GMv-000000037fN-49m6;
	Fri, 25 Oct 2024 09:12:29 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4GLZ-000000037Rd-1x5g
	for linux-um@lists.infradead.org;
	Fri, 25 Oct 2024 09:11:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0wMyGr/dlrWZ8eZOB+DkiFR2IQ4b4CzX3tGiTWgNJp8=;
	t=1729847464; x=1731057064; b=aggS6/xdUljvTx3gBvNKwr+YWyeLZG7AhH39wLuPHjCBjfx
	ZkwwG9QRn72CSQTJh4Vk9rxlzK1mmCxx2bToncnEieKxhJNg7S/tZUqkUFKdeN7UvvECC47uzl6bC
	+SQV6xXqjrY/02cKgNw3kwQvPtPYJrcHcNROlwYlYlY6chcvNAQJ8E0sFh4mejDsT0vmOf2g9cYQq
	ICs2m1VmSbHja3OV9/51v3QuK0uEqdwuviChJtrqUkKOog5dfJIpSBruI1Nu8n+hQEuI7wyoEelWG
	i921trfrDqQMh2yzjkWalaI8pO4wltHyCwITaHfpKzsCkeFx9d/i/7wtpeFHkGHg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t4GLW-00000004S9k-33aD;
	Fri, 25 Oct 2024 11:11:03 +0200
Message-ID: <d84f04d9a60d4dffa81fe5d0f73646032f1294f1.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 03/13] um: nommu: memory handling
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, 
	jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: ricarkol@google.com
Date: Fri, 25 Oct 2024 11:11:01 +0200
In-Reply-To: <304383e5c9b2bba18678598bbdacadc9126d8f74.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
	 <304383e5c9b2bba18678598bbdacadc9126d8f74.1729770373.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_021105_528770_175A8A1D 
X-CRM114-Status: UNSURE (   8.74  )
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

(I should say, I'm still reading through this, and haven't formed an
overall opinion. Just nitpicking on the details as I see them for now)

> +#endif
> +
> =20
>  #include <asm-generic/mmu_context.h>

extra newline

>  /* tlb.c */
> +#ifdef CONFIG_MMU
>  extern void report_enomem(void);
> +#else
> +static inline void report_enomem(void)
> +{
> +}
> +#endif

Should that really do _nothing_? Perhaps it's not called at all in no-
MMU, but then you don't need it, but otherwise it seems it should do
something even if it's just panic()?


>  	brk_end =3D (unsigned long) UML_ROUND_UP(sbrk(0));
> +#ifdef CONFIG_MMU
>  	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
> +#else
> +	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 1);
> +#endif

That seems much simpler as

	map_memory(.....,
		   !IS_ENABLED(CONFIG_MMU));


> +#ifdef UML_CONFIG_MMU
>  	loc =3D mmap64((void *) virt, len, prot, MAP_SHARED | MAP_FIXED,
>  		     fd, off);
> +#else
> +	loc =3D mmap64((void *) virt, len, prot, MAP_SHARED | MAP_FIXED | MAP_A=
NONYMOUS,
> +		     fd, off);
> +#endif

Same here,

	mmap64(....
	       MAP_SHARED | MAP_FIXED |
		IS_ENABLED(CONFIG_MMU) ? MAP_ANONYMOUS : 0,
	       ...);

johannes

