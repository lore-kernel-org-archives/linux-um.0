Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4C606A326
	for <linux-um@archiver.kernel.org>; Thu, 19 Nov 2026 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wBY3USZi;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=Pw8dCMea
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fb74Ypm8N07IinnvpEh/ePSfHZzNgv58jl0p8HBZUsE=; b=wBY3USZiGwQDdsV5kGVZCKY2HT
	mFGuyFlm99T7tyz/N3KQXBvBWm2bOX6e5n9xRmYKcQ5BPGUPf6vBkkW7busUOG+p8QALOUxma7TP4
	+DIGKCAA5tR+tA9FnMWDls2r8f9Fv0g4yBC1L+U3yhTCm4tvzrAAjF0xqte0wh/2kghZBmNHZIC+2
	GSuazwKGEMmazGAdJeSuYs8acV7itKZao4kulmiUIjcWu2mVSD5+67kfCdotOCSzS/D8WxfAm3NJ1
	eoSLm4c3Y/wKgBskwRKhONIn8CSRtZSiNHg9zFkg11K545fPrzXR4jp2nzbXWlUF7wfWS7F4w+eMp
	SRiIGFXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU20X-0000000C086-3rH0;
	Thu, 19 Nov 2026 13:16:57 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU20V-0000000C07b-3zzf
	for linux-um@lists.infradead.org;
	Thu, 19 Nov 2026 13:16:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fb74Ypm8N07IinnvpEh/ePSfHZzNgv58jl0p8HBZUsE=;
	t=1795094215; x=1796303815; b=Pw8dCMea9KvLY9ERlt3mhPZGdhSq3xXtVwS6mydSODHwF9X
	8kDREi0qKokfh9KwWDOmxhVq/3g0pHI4MxA3/u6UuFSNXh0ATSUb9EsHcu1mTiHKtffihrHh09DdX
	YKk1WCsmsf0h4A6HFcZek1EBEF7n6Pg2aVlerkZs0m6Sr+jw5bY3vBKMOnTeSa4puX35OpuuKQUNO
	7G1UUH16vIaTM2mRsnYJEp08zN8KyLQM/cTteLYTXitdG1iQOnojNERbUK4JZD7+OmMPb97gwS6R+
	pySbZB3Qe72ZUCAcnJthaTcoZnS0ZtBjx6WNVCusEVQIXqK0EYupS3AOd14zPUxg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xU20P-00000004L2f-0Tpg;
	Thu, 19 Nov 2026 14:16:49 +0100
Message-ID: <cf5b39641d70ef666a8fc27bac893ab57354d4d5.camel@sipsolutions.net>
Subject: Re: [External Mail]Re: [RFC] um: reproducible randomness for
 time-travel tests
From: Johannes Berg <johannes@sipsolutions.net>
To: =?UTF-8?Q?=E5=AD=9F=E4=BB=A4=E6=BE=B3?= <menglingao@xiaomi.com>
Cc: "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, 
 "richard@nod.at"	 <richard@nod.at>, "anton.ivanov@cambridgegreys.com"	
 <anton.ivanov@cambridgegreys.com>, Benjamin Berg <benjamin@sipsolutions.net>
Date: Thu, 19 Nov 2026 14:16:47 +0100
In-Reply-To: <304D77DF-B1EF-454A-88D9-1BB898BD5F2B@xiaomi.com> (sfid-20261119_140447_724071_B1362E65)
References: <D2219FFB-73EF-4E27-B84A-5C8E550E3553@xiaomi.com>
	 <480fe566b40da65fc2102c951394e39c4d8b7f22.camel@sipsolutions.net>
	 <304D77DF-B1EF-454A-88D9-1BB898BD5F2B@xiaomi.com>
	 (sfid-20261119_140447_724071_B1362E65)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_051655_998304_AD8262A9 
X-CRM114-Status: GOOD (  15.82  )
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Lingao,

> In BSWorld, we run BlueZ in a 32-bit UML guest with time-travel=3Dext.

Right, =3Dext to integrate with a scheduler for whatever transport, and
multiple machines, presumably.

> We preload a small shared library into the UML process to intercept
> the host libc's getrandom().

Ah, OK.

> The harness derives a seed from the guest
> label. We also reuse the same kernel build and read-only rootfs,

Right, read-only rootfs simplifies some things over hostfs.

> disable CONFIG_UML_RANDOM, and keep the boot command line stable,

Ah right, command line stable is another thing - we had to resort to
mount namespaces IIRC.

> including the HCI serial file descriptor.

:) That's an extra quirk you have, we use virtio, so there's no FD on
the commandline.

> https://github.com/XiaoMi/bsworld
> https://github.com/XiaoMi/bsworld/blob/d809b998fd42866bd94cddd05edcc0a0b9=
9428a7/src/bsworld/uml/getrandom.c

That looks fairly similar to what we have, just implemented outside
instead of patching.

> We compared two runs in the same image and got byte-identical HCI and
> over-the-air captures for the BlueZ cases. That's the scope of our
> reproducibility check.

Ah OK. We actually did (at some point in the past at least) validate
that /dev/urandom returns the same stream :) But I guess BT would also
have keys derived etc. that depends on that anyway.

> The awkward part is that we have to build a separate 32-bit shared
> library and rely on UML calling the interposable libc symbol. The shim
> fixes the bytes UML gets from the host through that call. The guest
> RNG still mixes in other inputs, including the kernel build
> information, command line, and interrupt timing you mentioned.

Right.

> Would it make sense to start with the os_getrandom() seed from your
> list, enabled only when a seed is explicitly supplied for a
> time-travel boot? If your patch is available, I'd be happy to try it
> against our BlueZ tests.

I'll just send all of our related patches, there's no real secret here,
we just didn't think anyone would care, and didn't bother polishing the
changes enough to be upstreamable :)

johannes

