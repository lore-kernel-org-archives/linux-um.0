Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CEAC531F9
	for <linux-um@archiver.kernel.org>; Fri, 24 Jul 2026 06:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DRcgh4bYq48CJCxqiYKMTGPXUS/1arq4Ayaag0zi99s=; b=qSmb9wzPSV3VHOcSX3B3AdNBWV
	79mcd6Sy/9q3gb4tXGQS7savxdHYWX83guP53lARKNs96M1uV7ADU2DOwAmP5kwl1iViP50XQLOHB
	mL/XeRDJ0bi1CaTuNWfS5WrXE8ItanDAr5nZ3hWbCKRBFRvZUxtY/QBJgcH6eL33JJVGbK0JTsj9f
	Yrmv7NdmKAd5Kj/b+BOg3nuzxDFHcSleBf6LWg2bf4Q7XqmPsCishuDwHO4XZP3rHGlE2Sb5MZHGq
	yAGN+rqNjV4Bg50sKjOlA/K2AiOEeATwqY9A4wTNb45qUf8tkqWBrqhXUoiOfwhStV2ytJhp5EPXO
	Dg35LqTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn9c8-0000000FcwZ-48UH;
	Fri, 24 Jul 2026 06:42:32 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn9c6-0000000Fcvo-3GB6
	for linux-um@lists.infradead.org;
	Fri, 24 Jul 2026 06:42:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DRcgh4bYq48CJCxqiYKMTGPXUS/1arq4Ayaag0zi99s=;
	t=1784875350; x=1786084950; b=X3QurAKpbaTYG1B7VV/8Y2fAzA9R1wGC1ZndjBfgtZcUTSo
	Wpq9mfFG0eFtAy6MZF/UxEf7AK6ieXnXZ18rcFgsSoFEaszkLd35ijAqKOaYBcguWztySoeL3+3ZD
	lltNRcJpSEsURZ4tnoPLQsTJA/LbKOzsQGMt1YWCumT5oZDZHvTnauihlxVaNIWxgSnx9OAsgQkhI
	6OfRXHYREtw8MIch8HJLl0GcWqjY8oFgAmTR/f+jLNAikuq9kjaVWCm0P6iXC+sbZzS9bd5sXHZEJ
	2XaIstH2JWzTsm85UmLRwpXGPWhmTDROLVl5PhlFKrZ4I4nMZvEcfKUdOd3Ordmg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wn9c2-000000020ls-00Si;
	Fri, 24 Jul 2026 08:42:26 +0200
Message-ID: <82a386088c9505e38e00bed8367c96bf5ea0636f.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Allow multiple symbol definitions for GCOV builds
From: Johannes Berg <johannes@sipsolutions.net>
To: Alex Hung <alex.hung@amd.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: Bhawanpreet.Lakha@amd.com
Date: Fri, 24 Jul 2026 08:42:25 +0200
In-Reply-To: <13c06f83-ffb9-4834-9112-6da54a93ecbb@amd.com>
References: <20260708224006.3405038-1-alex.hung@amd.com>
	 <743d1be771381c86c7f264810d88876976cc508f.camel@sipsolutions.net>
	 <75f2f98c-78df-46df-9961-6ddf2870d044@amd.com>
	 <8b710b01b8117d41281595265da43ab0add10214.camel@sipsolutions.net>
	 <313f6cf4-91a1-42e7-8e19-d2883c5c4f73@amd.com>
	 <a30db44d0711d41065b1407aa5c20e062fec890c.camel@sipsolutions.net>
	 <13c06f83-ffb9-4834-9112-6da54a93ecbb@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_234230_814304_C6F4965B 
X-CRM114-Status: UNSURE (   7.88  )
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

On Thu, 2026-07-23 at 18:44 -0600, Alex Hung wrote:
>=20
>=20
> I think the two patches are relevant today
>=20
>    um: fix CONFIG_GCOV for built-in code
>    seq_file: rename mangle_path to seq_mangle_path
>=20
> I will update the patch date and add my SoB, and then send them to=20
> mailing list, if that's okay.

Sure. The first is probably the same as your prior RFC anyway?

I'd probably send them separately - good chance they might (need to) go
through different trees.

johannes

