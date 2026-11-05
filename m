Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084F3606A326
	for <linux-um@archiver.kernel.org>; Thu,  5 Nov 2026 07:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GTLWfrT9;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=c1IKNff7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tzpAoC2omTJl2fzGtB/LbdqFRSKRKecrRzXJsFBarKQ=; b=GTLWfrT9yi9QPZxo+h1JPZTFLQ
	x3JGCMxxw8d0lcyxXuR0i3Usb5t/v+3TKFQfhaTwDeij0xtVDJKoJgjx/QoiE7YCYl8e2mfizSj0+
	roexiL+vzuITuGfWO0LRiheKw4uFEqWV3n4P5RszyBCO5mCNNm1Vrgsv+TcJsGJiIpPI8Y5nLH4sB
	b0Iyj4EGCMMd08k74ZYcEldCELkj9OjyrZp6DV+w1RTksB/FyF+t7mpubcRLe+BoCSV6l3+cgT8Jy
	cPehwS8hbLLEM8vBRa11hADzunOsgQo/Zbg74rGfL3ED0fNW7I6KBAGPKJ78PRaOXAMgmvpvgcS+k
	Aev/CTXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOrwD-000000081uF-0Nv4;
	Thu, 05 Nov 2026 07:31:10 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOrw5-000000081tv-0ypi
	for linux-um@lists.infradead.org;
	Thu, 05 Nov 2026 07:31:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tzpAoC2omTJl2fzGtB/LbdqFRSKRKecrRzXJsFBarKQ=;
	t=1793863861; x=1795073461; b=c1IKNff7Tb3vWvCNaiLBxBFXTy3DJApvlgU/nFngvhRbKQt
	I5/gx9HciydNANu1KWzEHlUJLeDCSuQRerFz2tlVAOiZ85AQcgtVg/zKfPh00knc7+XTGq8wbMtmR
	Cva/3KJjBknaQ7MBAUjfxf1f1RcHmGvfRALkt6UjJ7dfjvA1OFpWG7wbW+ZYsdVCvQmh7ioDq7WYZ
	WIvhSqH6/Zx+JIXSZO5nOD/FOla64Mxd1w72xGhB8MTDxlDT+opyFYP0tGzANqSYDCcrEx0bFhjs8
	JxslCfAotanweGV/HGu1PlDuQ2l3sEH2X+/WyJ0wSQh2di7JdI+5QF3JoXF/25Ew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xOrvv-00000007QDT-1O6r;
	Thu, 05 Nov 2026 08:30:52 +0100
Message-ID: <d2496da0ffca1e425c194cb746088fa174fd3cf7.camel@sipsolutions.net>
Subject: Re: [PATCH v1] rust: arch/um: Fix loading Rust modules
From: Johannes Berg <johannes@sipsolutions.net>
To: FUJITA Tomonori <tomo@flapping.org>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, ojeda@kernel.org, 
	a.hindborg@kernel.org, acourbot@nvidia.com, aliceryhl@google.com, 
	bjorn3_gh@protonmail.com, boqun@kernel.org, dakr@kernel.org, 
	daniel.almeida@collabora.com, david@davidgow.net, gary@garyguo.net, 
	linux-um@lists.infradead.org, lossin@kernel.org, tamird@kernel.org, 
	tmgross@umich.edu, work@onurozkan.dev, rust-for-linux@vger.kernel.org, 
	fujita.tomonori@gmail.com
Date: Thu, 05 Nov 2026 08:30:50 +0100
In-Reply-To: <20261105.100942.1905172064477226868.tomo@flapping.org>
References: <20261004121230.373216-1-tomo@flapping.org>
		<20261103.180207.1243555897796693771.tomo@flapping.org>
		<0730c9d467af3897a547860d036a5591cb40905b.camel@sipsolutions.net>
	 <20261105.100942.1905172064477226868.tomo@flapping.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_233101_809150_2CACEB5E 
X-CRM114-Status: UNSURE (   9.95  )
X-CRM114-Notice: Please train this message.
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

On Thu, 2026-11-05 at 10:09 +0900, FUJITA Tomonori wrote:
>=20
> As the commit message says, Rust modules still fail to load with a
> larger mem=3D, because Rust code uses the small code model. Zigit Zo
> posted a fix for this in 2024 [1]. It is the same change as the one I
> would send:
>=20
> 	KBUILD_RUSTFLAGS +=3D -Ccode-model=3Dlarge
>=20
> It was not merged. Was it because the patch has no Signed-off-by?

I have no idea, but I process enough patches (mostly in wireless though)
that I almost certainly wouldn't remember one that just gets dropped on
the floor because it doesn't have a Signed-off-by (or similar mechanical
issues).

johannes

