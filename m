Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D9DCD4F35
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 09:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r6RcY/m3CkrmmJI7BQ5l6/UtOrJHVxhvmVahNDVSs84=; b=nR5lVcaU3TyHar
	7q8+68DjqkeoXoyRgry8CuDBlkbBC7hw7klal1um+v74z+e+R4+djxnPLJXUlpSzuefi0Jg32pVdp
	Ce3zh53/Sbv4TexyojAvJ8myuNxxlOwDKV/CxhLvrfknQta8RA4y4ECwEDv8JSXTwMe6As/wr/Tre
	XPpy+ep3XqrauNAQ9nz8xc+l7IP5he8RQQJbT81FSgsffOeHTKyq26wD7TN8jUyW05WB326FJvE4h
	ouycTH6hg/XmuUE4BVgXK5o07x1wp+hsZ1Rsy9lUNldZ6sonez897fPGACw0PSxLf7p/dgUU2SCte
	1KZP7yAv5NJrCrFg7v5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjc5u-008VA9-1o;
	Fri, 22 Sep 2023 09:05:02 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjc5s-008V8x-1H
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 09:05:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=phocoDV6Q9RRWc7DyGiVoO8UhTWArA1CLCjYdJMBKrQ=;
	t=1695373499; x=1696583099; b=iEQKHi9fi8cBbX1LXhBPAAccyQofpryA9tsD7UhF4PlqqgK
	Fr140CzDxJusGftbN5z8ZnDtVRT41QrZBJuEeJqfClMdfDb6vPC0kfBlnyuoGvao1FtwIeFg7z2bq
	RM0Q9HCBYd+poOfrPxja2Fe9oq0Iav7K9QSTwtHGvWPMUwlK856mPFFbeU94KI4qT2I/yeeq9tvrA
	gHUmvhv61tZipYFvuPCGbIzkL8WUhD6VrDKFsz6wQ+eKr4tAbtvCkCY+NjFNaIUaZrSOYrxrEY457
	HT0kMa93ZOCOf5mX7C7UN/TOKUKBNhiadY/PDOtHRZs8kffdTvSoO88/jD44yWSw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjc5p-00F5Dv-0r;
	Fri, 22 Sep 2023 11:04:57 +0200
Message-ID: <05c6552775bfb5b5402cd636fb22d91634a87bee.camel@sipsolutions.net>
Subject: Re: [PATCH v5] um: Enable preemption in UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Fri, 22 Sep 2023 11:04:56 +0200
In-Reply-To: <8a0085b037da53fa8af7c624116e05362b9c0e4b.camel@sipsolutions.net>
References: <20230922065212.484385-1-anton.ivanov@cambridgegreys.com>
	 <fae1103161cf8c7bac8a138b267d2288ebb32a08.camel@sipsolutions.net>
	 <fa4069f1-e026-7672-4f71-9319cdd683a2@cambridgegreys.com>
	 <2de07f54b33dc060b75d982d4d8189f12e0d4c45.camel@sipsolutions.net>
	 <28f0be57-829b-9ddf-7b0d-a6c84932cbda@cambridgegreys.com>
	 <423e8ee5126e1dffda5f8877d07611a21972eea7.camel@sipsolutions.net>
	 <210bd25b2dcd9e4424923f55053086f67e219cc4.camel@sipsolutions.net>
	 <8a0085b037da53fa8af7c624116e05362b9c0e4b.camel@sipsolutions.net>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_020500_433744_BC46A98F 
X-CRM114-Status: GOOD (  10.75  )
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

On Fri, 2023-09-22 at 10:43 +0200, Johannes Berg wrote:
> > 
> > I think this has pretty much always been wrong, just now we actually
> > notice it?
> > 
> > Basically, when we create a new thread (really just mm I think), we say
> > the first thing that has to run there is fork_handler(), which
> > initialises things the first time around. This calls force_flush_all()
> > 

So I thought we could perhaps just force_flush_all() the new mm in
init_new_context(), but that segfaults userspace immediately.

So I need to fully understand first (again?) why we even need
force_flush_all() at this spot, but probably not today.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
