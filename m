Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E254CA101F
	for <linux-um@archiver.kernel.org>; Wed, 10 Sep 2025 11:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OySP/ewzDP7qYoXqik2jfMmlTSWEYVQiB3tXcLsIXio=; b=kXmjzqsyZvWFu7m8qfI4WeNBMU
	o44AAo20/8zTPK8jAccBidL7RcZYlfGF+uyBt0tcu5OyqMyUYlCsWDufRpPAMA5YHVLFaR/f5CJd0
	vdD8JJ1No0gHqU7J4Xmonw2HXmVLpvK6n0fWPFcuA592vkm4pEKfHldJ9VDqA3v8F1x5M4a2//eWd
	GRCgfHJ1VFdtqetEEgRb24ev18HCOULDpqRVaFSWpX1z3X/R7MeeZGf5Z4sjWbTTVlxSC3WAuqwzy
	wulBw/YO+1SuPXqYgF/90IiRFURgoifR4aJDVDWZaDIQ3YIB8HrAZ+3hNb2MhUsgY4jqcyRnG3BpX
	VG5ojXfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwJTh-0000000Dy8E-411i;
	Wed, 10 Sep 2025 11:59:09 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwJTf-0000000Dy73-2Crj
	for linux-um@lists.infradead.org;
	Wed, 10 Sep 2025 11:59:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OySP/ewzDP7qYoXqik2jfMmlTSWEYVQiB3tXcLsIXio=;
	t=1757505547; x=1758715147; b=lohfoZSR0E/cvjVs+86QQUM+ablrzplu7gs5A4fMRVqRVZC
	+Ti9lCwfeMuYCw9dcWHM8pushVsCYEPFQry7lu6gcEKzcVx4d6kahZxX1gWpFwDIoj4ZXHDKypNbY
	PYWiK/mdZn8dxpDPs0yuoWIU99ujxLaU+UsAzUx/eL4LDdnaMZHYIRcxJ0dU1xJY/cHGyksZc7plx
	r/x1wZawKn63fBV3trJZ/cwIPZUdMVGABS23kpQKidC3SZ2h+KoaC6VzXnGH1NxjbAxiWvNxbXvyr
	pZNFmbqdJmCdj25ONUSU70E6ipNEA0Tvz3BQAHR0EyzLdBQolnXiuaMzHIzpbIrg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwJTb-0000000CnNR-07Z6;
	Wed, 10 Sep 2025 13:59:03 +0200
Message-ID: <d28c9690341715fff04fbc01fd80723a30195f23.camel@sipsolutions.net>
Subject: Re: [PATCH v2 03/10] um: vdso: Implement __vdso_getcpu() via syscall
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	benjamin@sipsolutions.net, arnd@arndb.de, tiwei.btw@antgroup.com
Date: Wed, 10 Sep 2025 13:59:02 +0200
In-Reply-To: <20250810055136.897712-4-tiwei.bie@linux.dev> (sfid-20250810_075310_514820_7C2543B7)
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
	 <20250810055136.897712-4-tiwei.bie@linux.dev>
	 (sfid-20250810_075310_514820_7C2543B7)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250910_045907_560481_659B065A 
X-CRM114-Status: UNSURE (   8.16  )
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

On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> From: Tiwei Bie <tiwei.btw@antgroup.com>
>=20
> We are going to support SMP in UML, so we can not hard code
> the CPU and NUMA node in __vdso_getcpu() anymore.

Correct. But does that mean we actually have to implement it via syscall
in the VDSO? That seems a bit odd? ARM doesn't seem to have getcpu in
the VDSO at all, for example, so could we do the same and just remove
it?

johannes

