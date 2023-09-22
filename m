Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB69CD4F2B
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 08:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j+Ulw1eE3Uy3HWE+4hjZ/e1Sxxo0ainJRmTOpuhy3Mk=; b=trII8a9gP5nyxy
	0vZ6FxmBWsAJNm6qG62nVpGH0vuVSzo6Kdna6PzRLUpR5WgMXhmi0UoI4qmey0mrKRCCTSeVXCVm2
	38IUNYzaF7zLV4Acb/azaWj/XCeHAiOim9PRfgkXed/9jWzJ2nXrZTciYeVcuKhkYeTDxxpHbX+V7
	vVd4mC4sL8evrlaYy0+aNTYJ/C/0h6znz88+7u/+bUvw4ZEmeRxJJOQ5K+1D4fvcHP6hA+iS0TKJi
	tQgKDidkeqwJhcwdl1++eIdQV978B5XH5Lp9uX9sibjOmbUyJzhQkjFJUNv23/t9olQhDRu0lH+d3
	OxpWbGIm5rJpMDuYv6cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjbjX-008RgT-2q;
	Fri, 22 Sep 2023 08:41:55 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjbjU-008ReH-2N
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 08:41:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8w2qT39oSYiqYJ3//nBhFlI9Bp8Btn/f19VAZkXQHCg=;
	t=1695372105; x=1696581705; b=n6rj8Gg2PWDaCoFQxkgDAkFzu1gHZnpKBhf9U6UXdKjCivU
	hWudifE+7bIlS28+8xJ8fVE7qCM3gNqDkJqkJ5kokeV1jpi+VXioEx0kl3rLYv32HJGWgdGEDEu7H
	ouvlG8Ji9nM4QGAz1Yxv5/e7skuo7gMWFEHtdzO3VbEePVvEShPiHQafocrh5vhgjAhucdu2G+LNC
	1QV3eeStMvun7kU7snVyZaYi0yzsVyt5UINmh1T07RXw3+2YaWmsfsRp399q9GNduWA6CihOAr/Ec
	VIjusbomXjt+J4uh1AcpRyO58cq7mRlA8+wOA3VRyce6r3lLzslviQvL4qTpkPvA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjbjK-00F3ro-33;
	Fri, 22 Sep 2023 10:41:43 +0200
Message-ID: <210bd25b2dcd9e4424923f55053086f67e219cc4.camel@sipsolutions.net>
Subject: Re: [PATCH v5] um: Enable preemption in UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Fri, 22 Sep 2023 10:41:42 +0200
In-Reply-To: <423e8ee5126e1dffda5f8877d07611a21972eea7.camel@sipsolutions.net>
References: <20230922065212.484385-1-anton.ivanov@cambridgegreys.com>
	 <fae1103161cf8c7bac8a138b267d2288ebb32a08.camel@sipsolutions.net>
	 <fa4069f1-e026-7672-4f71-9319cdd683a2@cambridgegreys.com>
	 <2de07f54b33dc060b75d982d4d8189f12e0d4c45.camel@sipsolutions.net>
	 <28f0be57-829b-9ddf-7b0d-a6c84932cbda@cambridgegreys.com>
	 <423e8ee5126e1dffda5f8877d07611a21972eea7.camel@sipsolutions.net>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_014152_772592_233E1E4A 
X-CRM114-Status: UNSURE (   8.04  )
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

> 
> Yes, but when does the fork actually happen?
> 

Looking further at this, now I'm confused as to why it doesn't happen
_all_ the time.

I think this has pretty much always been wrong, just now we actually
notice it?

Basically, when we create a new thread (really just mm I think), we say
the first thing that has to run there is fork_handler(), which
initialises things the first time around. This calls force_flush_all()

But of course it's called from __schedule(), which has
preemption/interrupts disabled. So you can't do mmap_read_lock()?

But I'm confused as to why it doesn't seem happen all the time?

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
