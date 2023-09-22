Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B1ACD4F32
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 08:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vnStgDdas+ft1Y34lL4W5phJhSecJCYboV0ME9FaNvo=; b=J3ock1weObzpke
	e3BVcjbTc0lrqGbm9BTUJfeq5xQsuo87feLRiiu31FqbXT+cpJBWoQSX5ksIrw79edxE5k3g7FKpI
	QbJZ35oKlqK3PbJfRrYifq969w+ioIdJ9C81PlYBduNxH+ri3fYdeKZ8clcSJbA+LbyC3Rm5qgXm/
	F5z6rRQoJhdVZkK7/NTFCkXcZDh/9MFNxtCzyWEZeVEYZpOmpkUQfH0IVhHq6Wfpm8+Xuyfw6kQfO
	MEGBCSV7WWYq3a12ygrfxCbJ5eBf3c4B4f89kQowiAiREjxO8gmS43RVr+QA8QTgb8C4UNiIuv5io
	p8TyJ2c/rUwa/d6PA/ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjbkp-008Rqf-0n;
	Fri, 22 Sep 2023 08:43:15 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjbkn-008Rpq-20
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 08:43:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=K0EpUHC3Zvjgh7CZ10jmCm5+HJ5iRwrQlA5L2+ELj0Y=;
	t=1695372193; x=1696581793; b=Ol+nJRocO3qZHWYb2FupEkXIZvfq6t9XOgZRFYFKhaw+HuI
	1afs2qy+hDLRpFEDy3gBMmYYAcROHHEXcP2vsm5b5oG+aeqx/p/iwFP0sWve9KBE2k+vqE7qnxpGF
	tRDqO+DzMlgAJExtCMTkkqPnKaCmvd9Nx79JSrDylnhhtGsceMoaIks8ndU/hJSrJo3YrKFWWiMxG
	VDWlj5rOuFPpFEE3kF99GbAomq4WiIeEF8FA4y1Wq8QGjvB+ADmJczRzdzunTfuoMlp4oo2orceUu
	vnu5J4G/+KikkQMmVDT5UP4e7spOtMHb4e4TMH3qjH+02xx/7L+STdhmkO5qmifA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjbkl-00F3yq-1u;
	Fri, 22 Sep 2023 10:43:11 +0200
Message-ID: <8a0085b037da53fa8af7c624116e05362b9c0e4b.camel@sipsolutions.net>
Subject: Re: [PATCH v5] um: Enable preemption in UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Fri, 22 Sep 2023 10:43:10 +0200
In-Reply-To: <210bd25b2dcd9e4424923f55053086f67e219cc4.camel@sipsolutions.net>
References: <20230922065212.484385-1-anton.ivanov@cambridgegreys.com>
	 <fae1103161cf8c7bac8a138b267d2288ebb32a08.camel@sipsolutions.net>
	 <fa4069f1-e026-7672-4f71-9319cdd683a2@cambridgegreys.com>
	 <2de07f54b33dc060b75d982d4d8189f12e0d4c45.camel@sipsolutions.net>
	 <28f0be57-829b-9ddf-7b0d-a6c84932cbda@cambridgegreys.com>
	 <423e8ee5126e1dffda5f8877d07611a21972eea7.camel@sipsolutions.net>
	 <210bd25b2dcd9e4424923f55053086f67e219cc4.camel@sipsolutions.net>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_014313_655694_6DA4FCD9 
X-CRM114-Status: GOOD (  13.15  )
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

On Fri, 2023-09-22 at 10:41 +0200, Johannes Berg wrote:
> > 
> > Yes, but when does the fork actually happen?
> > 
> 
> Looking further at this, now I'm confused as to why it doesn't happen
> _all_ the time.
> 
> I think this has pretty much always been wrong, just now we actually
> notice it?
> 
> Basically, when we create a new thread (really just mm I think), we say
> the first thing that has to run there is fork_handler(), which
> initialises things the first time around. This calls force_flush_all()
> 
> But of course it's called from __schedule(), which has
> preemption/interrupts disabled. So you can't do mmap_read_lock()?
> 
> But I'm confused as to why it doesn't seem happen all the time?
> 

Haha, no, I'm an idiot - should've checked earlier. __might_resched()
has a ratelimit on this print ... :)

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
