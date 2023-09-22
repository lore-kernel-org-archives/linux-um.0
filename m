Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC6DCD4F35
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 09:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3nmuZXAzEYy/sOvtR/vrV5k2nmttzeNtUSo/ryQUXiE=; b=Ml6OQtQwPBlaAB
	VJCZKdGOmyRTOBSiSn/C/Wmegx8d3nBQW6Nn9gzwWN4g9KOkJX3DJ0V64uu+tw8eCy8h6cPiktdyZ
	ORnKy9QVcvbq2PdfATnBo+iz5LlhBuMV6ucUW3ApPsFFjWFggFbyYCome4zd1c0W4VTqNhB4AY+tO
	y3R++F75JrO/lIjB3NYk9fwjfXiGJa3mzfH7qUlhe6vbAOf8L0bXDvkqD3ZDxis1rfZPrDClhNNsL
	y2ZjrY++KsLjxp2ARpL4TibwwvvZcJzOn6cy6VsE+9tFe79dcw2bw9YQYSXuFbDaUY575Xg/EZIrb
	UHBu1+Cis/K4oAWZuXFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjcEs-008Wj8-2r;
	Fri, 22 Sep 2023 09:14:18 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjcEq-008WiX-2w
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 09:14:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+2b/BKlL4p+OCD13e6hi1Vqjjss2O/yZQosC4g6Mwk0=;
	t=1695374056; x=1696583656; b=ABTIepyyZMPr8+ZBVA7509+qJkmJArrx4zJfNfxrbtAMsYW
	CjME5ErnySZiuoAfZZZ+HesjY0L9dfunsrMWahKtnFLW7ShjkgzU8EF3BxzJFUyBlCA19wC1PE11y
	y4U6YVTw/AOWcqo3+mPzsb2dwSvskMok0TBNPtahV7ZTIqsBdZieCHPM1/HaQDatnwcIOEiS1GLwN
	prkpsQF6eaOwkiNtiS6pKGlpa4Vbt5plBClk+v/PO7P14hLTSJojE7BBINVtwlxjWd1ttO9Z21pB7
	+SShBmc5ezEdUvk30asrXeGTCI9pic0+bViBbI+sZK+WDKo90LFySeQQKGZho+sA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjcEo-00F5v1-2b;
	Fri, 22 Sep 2023 11:14:15 +0200
Message-ID: <1ce8c412b0d2bdfa176f1f783281e393da94ff6f.camel@sipsolutions.net>
Subject: Re: [PATCH v5] um: Enable preemption in UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Fri, 22 Sep 2023 11:14:13 +0200
In-Reply-To: <efaa802bcd0369665b3dbc10030c9ca88aa2cb30.camel@sipsolutions.net>
References: <20230922065212.484385-1-anton.ivanov@cambridgegreys.com>
	 <fae1103161cf8c7bac8a138b267d2288ebb32a08.camel@sipsolutions.net>
	 <fa4069f1-e026-7672-4f71-9319cdd683a2@cambridgegreys.com>
	 <2de07f54b33dc060b75d982d4d8189f12e0d4c45.camel@sipsolutions.net>
	 <28f0be57-829b-9ddf-7b0d-a6c84932cbda@cambridgegreys.com>
	 <423e8ee5126e1dffda5f8877d07611a21972eea7.camel@sipsolutions.net>
	 <210bd25b2dcd9e4424923f55053086f67e219cc4.camel@sipsolutions.net>
	 <40babfb4-ed65-dd0e-23aa-abdfaa9c7149@cambridgegreys.com>
	 <efaa802bcd0369665b3dbc10030c9ca88aa2cb30.camel@sipsolutions.net>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_021416_945860_0F4F81E5 
X-CRM114-Status: GOOD (  18.14  )
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

On Fri, 2023-09-22 at 11:10 +0200, Johannes Berg wrote:
> On Fri, 2023-09-22 at 10:06 +0100, Anton Ivanov wrote:
> > On 22/09/2023 09:41, Johannes Berg wrote:
> > > > Yes, but when does the fork actually happen?
> > > > 
> > > Looking further at this, now I'm confused as to why it doesn't happen
> > > _all_ the time.
> > > 
> > > I think this has pretty much always been wrong, just now we actually
> > > notice it?
> > > 
> > > Basically, when we create a new thread (really just mm I think), we say
> > > the first thing that has to run there is fork_handler(), which
> > > initialises things the first time around. This calls force_flush_all()
> > > 
> > > But of course it's called from __schedule(), which has
> > > preemption/interrupts disabled. So you can't do mmap_read_lock()?
> > 
> > Stupid question.
> > 
> > If we have preemption and interrupts disabled and we are UP do we really need to lock it at this point?
> 
> Heh.
> 

Ah, but this works:

--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -606,8 +606,8 @@ void force_flush_all(void)
 	struct vm_area_struct *vma;
 	VMA_ITERATOR(vmi, mm, 0);
 
-	mmap_read_lock(mm);
+	rcu_read_lock();
 	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 1);
-	mmap_read_unlock(mm);
+	rcu_read_unlock();
 }


it seems?

And it doesn't even seem _bad_ since as you say nothing can change, and
we only inject stuff into the process in fix_range() anyway.

So maybe that works - perhaps with a big comment?

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
