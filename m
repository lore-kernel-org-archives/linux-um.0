Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00224606A334
	for <linux-um@archiver.kernel.org>; Thu,  5 Nov 2026 01:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1Xsncmiz;
	dkim=pass (2048-bit key, unprotected) header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm1 header.b=JljlgxBY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YwbgqOnB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:From:Subject:Cc:To:
	Message-Id:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=O1Cm8loHDCpj4P5ciX2hNK4rLsWUTu7xFi5Jun3HCMU=; b=1XsncmizJaY7a0LF6zEzzu9f+Q
	6ChMlpiOVDtO3GsIYE6iDnhQ6M9Zx6YbL4LgFkRCcqSCIDJS+B2VTAzC2CD2VTynfmzaqego+C7XD
	bY9ZMOyaMCP6wQV2UN9LVZcxWGWI5IbPT2aiJFlLSYtiQgCCVQA2gj6KuNcEqhlzZBad3elrrNpjE
	O1E1TiLEcDYbtgjbdRvwxNiSdVRjVeuAoCiFqtKyEFjdoA5gJ/ggGfJ+bwaybA4S1KiDcGGn4DG+A
	an+HHJHr1ScC07/1wWNabBx0qHZoiZRYyKYB6tv5BXhqg/DpoZl5Pj0nyKOGAWMDYukFpzPohdwG3
	Kw0T1dDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOlzL-00000007QxG-0Rn8;
	Thu, 05 Nov 2026 01:09:59 +0000
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOlzH-00000007Qwk-2l0p
	for linux-um@lists.infradead.org;
	Thu, 05 Nov 2026 01:09:57 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3AC52140015A
	for <linux-um@lists.infradead.org>; Wed,  4 Nov 2026 20:09:52 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 04 Nov 2026 20:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793840991;
	 x=1793927391; bh=O1Cm8loHDCpj4P5ciX2hNK4rLsWUTu7xFi5Jun3HCMU=; b=
	JljlgxBYK3TD4y8UzDmOQH0GlWixGSUmkOToX/SxDVRRGNubK70eCEGkcfCSeRcs
	/ESAgYsKOLQ9wkA9jmImMQFssmx3SV2S+cxcwgn9vBDvoiQ4kSuE6rPYEHxvOW53
	wu2bVmMjS8t1kN6+usou+3ufaCCaLcy2/k1tEn57HLR63YP/2ZzyxL+F9beDk5h0
	+qgQT/xyhqqsfnsGStyEWW9YBB4Z2n0IJCk6ZEulhC+JM5LgxFjXiwip5oKenVC/
	k9lfCoPVwInPseuOMvm5M4lLuCEV/y9NW8Kq+ofQgsKuS9z4VrCxDAsudFolgMkj
	WCIHCbIf90jMc//Few9tvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793840991; x=
	1793927391; bh=O1Cm8loHDCpj4P5ciX2hNK4rLsWUTu7xFi5Jun3HCMU=; b=Y
	wbgqOnBzV8g/E7enblipTXKbp2tQyHPWKQ8aSNjewIwABYKYLWDaMpnVTrC4k4da
	e/9ldh4PjxWgXOMe+4a08tPEtiQXICO9vEGS9bT9/8tntViBBMUVVLBxzH4d8q2S
	OF0Ln4po75M6M9/mAQrfJ2iIbhObQEx6JrkC7CKPuU6thGHGjql8fYXoPsBkzq4K
	SUMhrlWbLKxQfyxqornvaYSgnHY5Zp7UtW1qrwvxsKcCxkxlWmsGlDbjMFPJsisS
	qai1U84qaMO1/M12oqFLIueS+bW9feNR7kvn+rK32yX3JEUIBe/8MX8cslLV7x1s
	5QNTZvWUoRPw9JYTl7hRw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=flapping.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793840991; d=flapping.org;
	mf=PHRvbW9AZmxhcHBpbmcub3JnPg==;
	rt=PGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+;
	s=fm1:rsa-sha256:Lk5f7C91QlixOA9Qqaq0Jg+VnKSouFHjGswQd5ucAsnt5S7
	D16666WnFo2TEZS6d9YRdMFWP5I5eYa/g+U+U9n9kmwlRwwnqRMTgmp/5xfn6O1c
	+67q6dYS5MkT5Uhr3e0xUiYLH96m5U9lDVo6ytxhhKaecwvA0fqWUx8Y0+8dMv7T
	XZRtcWXUrfngXXZKzbyqvXE5BWiVYpbDzqDYs4wy1MqESI9Cc78wmOwxt7Z2hRXh
	IaPyw4a+s12aRy4LeWRs5rHz/Z79mqCxAwVmLUUiuSZd8HbMiIDXtf1XfWlNXD6k
	gk4YCjIpMCdy6sw7Z1+OMQBHlRuZSIbGgru19IQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ZzBY6074gGCHcj4UrGYdGaaGYSNSYpMCkgTzbReb3cw=:h1eQ3O/me2QmpJomDgtAar8tCa8N0hzu147I+Uc2G/U=;
X-ME-Sender: <xms:XtfrarFKFd1jRiUx-soDjw2JKn0yAL6PtySVsp3qfqewm2TKwzNmpQ>
    <xme:Xtframu9yu9XvOi1_nQsVxABaC7cCs5v-Oxk7KVHg2Ls-WR4pBUUCxyRqpyebIf-o
    xYxwrojUgww5MS9TD0R-xsiPuLa3-1ABv0ZN1cv000Yr5TRXWAyVRjU>
X-ME-Received: <xmr:XtfrapKBkCPorlrNIdPysTYtxq34-DiQpjxfaWjdKpHDI-jWioyKGYLrlt-LaIJhCFZH95HMS3MELbr7Ss79sZvh>
X-ME-Proxy-Cause: dmFkZTFTKgnzJb/olmzZafRDBCmiyrowTRveuM6WggarpAkf9WumN8MLQIQT8bI7YZQod7
    FEWwT/HUj9aEIwdnBxAwH0gfg+rdBQo1BlcB0TBRL92kvDyhijk1FAA/QwDUF0sUyeo3qe
    9RyZG+D6Ky3V1I8QcSecZMlPmNXJWNssWF65n39943ZHKwFeohZGmvIFbwbk9bQYn6i9YA
    eTu+tSZkwOWML0AQ3uVF4EoZSR8azsoCqBUQkOz5M71uolQCx8rfoV6MAYCox/TkmwhOPI
    pNY/NURLmg4tWMhMhMclkzav5/Y+L33Q27WM7YTOMVFyAkNVNZO3E1PpwVo1Oie4QQ32g8
    QjoAll4h3yni8ayd+8K/BVDzkpCuXi7TODJ71OkaDz2E1AuRT6oSiKxWtNihbMIEtTq/JP
    RHcZTIACIbibD3bx4vq+0SRaGLvF5XbinxEJVV+52jEaHeYHaOcUuihstjrlmdRmp/Ai+Q
    chrmiziMytLKguVNSRq7tXWI8EfFrHomikdl/eICrM2neEdZ6/3w1zD5CmufUKO+VX1yVx
    OqDZNANLe74NOgsRD+HSK0K2gvOnCg0wFZ5Wpe3bT+C29PLWvDvvLusoq1B5+dh+vn8il6
    BtjWSshGA0nG4XSzyzQkv5/1hoozD8Lmxp7j3fEtksLyt8Fj2x3nOj0X+u2Q
X-ME-Proxy: <xmx:XtfrasPt48ensFcMxPIecwSkgA8u25rGjffqM5mmgpCqURsADOrNDQ>
    <xmx:XtfrapaPNzfzJ-cTCnGJc42h9uy2gaHJC703e2DjNtRUnIhdzyCFNA>
    <xmx:Xtfragyb_6nc3EHi6m_iDgqUkadp70o2BnclXyHHQUGNMIgdUY4b0Q>
    <xmx:XtfratHZ69xMsRlMJPbmXm1MOYeckA_reu42XV0S8mV1g66bmGNAXw>
    <xmx:X9fraljK74PAPProyi7syw3PX4pP6BTec2M3bKc1ceDv_n21Lhh_uDdV>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 20:09:46 -0500 (EST)
Date: Thu, 05 Nov 2026 10:09:42 +0900 (JST)
Message-Id: <20261105.100942.1905172064477226868.tomo@flapping.org>
To: johannes@sipsolutions.net
Cc: tomo@flapping.org, richard@nod.at, anton.ivanov@cambridgegreys.com,
 ojeda@kernel.org, a.hindborg@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org,
 dakr@kernel.org, daniel.almeida@collabora.com, david@davidgow.net,
 gary@garyguo.net, linux-um@lists.infradead.org, lossin@kernel.org,
 tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev,
 rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com
Subject: Re: [PATCH v1] rust: arch/um: Fix loading Rust modules
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <0730c9d467af3897a547860d036a5591cb40905b.camel@sipsolutions.net>
References: <20261004121230.373216-1-tomo@flapping.org>
	<20261103.180207.1243555897796693771.tomo@flapping.org>
	<0730c9d467af3897a547860d036a5591cb40905b.camel@sipsolutions.net>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_170955_929522_F089597F 
X-CRM114-Status: GOOD (  11.58  )
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 03 Nov 2026 10:39:11 +0100
Johannes Berg <johannes@sipsolutions.net> wrote:

> On Tue, 2026-11-03 at 18:02 +0900, FUJITA Tomonori wrote:

[...]

>> Gentle ping. The patch still applies cleanly on top of v7.4-rc1. If
>> it looks fine, could you take it through the UML tree?
> 
> I guess I figured with the "rust:" prefix it'd go through their tree,
> but either way during the merge window and all I wasn't really paying
> attention to UML.
> 
> I'll pick it up now.

Thanks!

As the commit message says, Rust modules still fail to load with a
larger mem=, because Rust code uses the small code model. Zigit Zo
posted a fix for this in 2024 [1]. It is the same change as the one I
would send:

	KBUILD_RUSTFLAGS += -Ccode-model=large

It was not merged. Was it because the patch has no Signed-off-by?

[1] https://lore.kernel.org/rust-for-linux/54FC087D02C52990+20240903130606.292935-3-zig@iorw.io/

