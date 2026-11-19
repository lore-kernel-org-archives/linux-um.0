Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226A9606A320
	for <linux-um@archiver.kernel.org>; Thu, 19 Nov 2026 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aSr/aq8T;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=a4A4kyme
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pZEjL21YISL+9a/ElpXqIaMhTEW+4FmS4usmLn3Cpvs=; b=aSr/aq8TAqG5No8SXJgYRTvPEa
	cGRAhwo7nbP8SKGyjJcn2TH+nBwyQFQ0pDp38YTXOMRxZhPCTiSHxK/rMfr7ydmsa9q7VN5fXrIww
	jktgCYoLohDOrmhZkwnYVKG/WJShned5yZwkYMoPWD8qOxnv6DynH/yKEFSNzLWXQlTEduTwCQKqF
	pLfudoYMqN4PdehehGfSHZATqfrKNwJ7wu8ctoSLOcggsv34WA0YF+YXPXQGRjzqM5QmJeDBIteA8
	31Idv5YE/qD1rkmRIfbp2sCK2XuTMQieovqXDgmIoDq2VuoyYuABcBTe2MdnBVe6lW96/0pFZFcPs
	a7yZFyyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU1Y9-0000000Bv67-2Im6;
	Thu, 19 Nov 2026 12:47:37 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU1Y6-0000000Bv2e-1dq5
	for linux-um@lists.infradead.org;
	Thu, 19 Nov 2026 12:47:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pZEjL21YISL+9a/ElpXqIaMhTEW+4FmS4usmLn3Cpvs=;
	t=1795092454; x=1796302054; b=a4A4kymeJz6zIxGjw9bRUGWwEP0xkDdoy0Nsf6tbR8EUfpc
	bHKC5sBMzTSCUWBrRpLP9DsBPlsA5wCYPt37ln3EBQrZrg9JZVdGrsNjPLgOTyf1Mw6SgQEWasnU5
	qP85JKfql+678uo+Kp9Y1LXtoUJniP8JlmfXj86oQ0F9OSlu8s5Qvgb7Mr0ba80J73Vn9q5MPQNmo
	CWgJYTyrcInnkEsfk0znCDWyijgolImXSDfBGlFuapNaOd5WULaecWtnEC8FwmQxJOStF4gzL9Ihd
	hIL7H2o05V7MRy1JHpRRnaEoYLCqrKLakluC5p4i5Z7c6NNvr/5QCJ87P18j0zZQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xU1Xv-00000004JjQ-02Hl;
	Thu, 19 Nov 2026 13:47:23 +0100
Message-ID: <480fe566b40da65fc2102c951394e39c4d8b7f22.camel@sipsolutions.net>
Subject: Re: [RFC] um: reproducible randomness for time-travel tests
From: Johannes Berg <johannes@sipsolutions.net>
To: =?UTF-8?Q?=E5=AD=9F=E4=BB=A4=E6=BE=B3?= <menglingao@xiaomi.com>, 
 "linux-um@lists.infradead.org"
	 <linux-um@lists.infradead.org>
Cc: "richard@nod.at" <richard@nod.at>, "anton.ivanov@cambridgegreys.com"	
 <anton.ivanov@cambridgegreys.com>, Benjamin Berg <benjamin@sipsolutions.net>
Date: Thu, 19 Nov 2026 13:47:22 +0100
In-Reply-To: <D2219FFB-73EF-4E27-B84A-5C8E550E3553@xiaomi.com>
References: <D2219FFB-73EF-4E27-B84A-5C8E550E3553@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_044734_716968_78990AD6 
X-CRM114-Status: GOOD (  14.95  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

> We use UML's time-travel mode for Bluetooth(BlueZ) integration tests. To =
make
> runs reproducible, we currently use an LD_PRELOAD shim to control the
> random data that the UML kernel obtains from the host.

Interesting. We do that for WiFi and have a number of patches to make
/dev/random reproducible :)

> Would UML accept an opt-in way to supply reproducible random input for
> time-travel tests? Normal boots would continue to use host randomness.
> I'd appreciate feedback on the scope and interface before preparing a
> patch.

It's a good question - thing is that it's fairly involved, and somewhat
difficult to maintain? In fact, I'm surprised you managed to make it
work with LD_PRELOAD, given that we patch out:

 - interrupt random source (basically stub add_interrupt_randomness,
   otherwise signal timing from the host can affect it)

 - utsname (in random_init_early) because the build time is there

 - os_getrandom() to take a seed from environment
   (probably the least controversial patch here)

 - not directly affecting random, but reproducibility, we sort hostfs
   directory entries so that their host order doesn't affect tests

 - similarly, dentry allocation in hostfs

 - similarly, patch hostfs to retry on EINTR (this is actually a bugfix
   we should probably upstream?)

 - similarly, some hostfs patch for updating the host inode timestamps
   when a file is closed (marked as needing extra work for non-TT) and
   setting timestamps on file creation

 - some patches to force out CRYPTO_JITTERENTROPY which doesn't work,
   but that may no longer be necessary and just historic

I don't conceptually object to having these upstream, specially if
there's another user (you) actually interested in reproducibility, but
some of these might need work. Benjamin can maybe comment better on many
of these.

johannes

