Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E87EE801F
	for <linux-um@archiver.kernel.org>; Mon, 11 Sep 2023 07:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=oNHsUzMalNYa5u7vt4KT3Yl8ZnEygpFmy8WPMzC2Ves=; b=1/ihaYRoNc546o9gChqU27/8jy
	bMfqkRDZwcte/9DS/2cA5YXh7NH+/ORvcjSbS0wmv0KL8O4xjppEze5WuTRQyce7csxVE3cbaPrxg
	SWcijA5nPB4pZfGYHSHk1Ndt3fEqsJYXDNMiP0V8bRzOuLYXBlcN1tGFVIJDd9HBIVwAEC//smMU+
	apRNPr33mTo3dF+bq88RHDrc0w0k8JvWe8lmJTK9X6WfGFUF0aJom/f2Py1migDnJR8QflzUQ7ua+
	SmqgytV2LvqPApxVNHGomyDyyC/ciHPHeB7xfJkrcdQ8dxAOcSBG3A2v+rYBoohJjTPRCG+ZsYrdd
	pmDKkrRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfbac-00HS55-06;
	Mon, 11 Sep 2023 07:44:10 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfbaV-00HRjQ-0o
	for linux-um@lists.infradead.org;
	Mon, 11 Sep 2023 07:44:05 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 62534635DB5B;
	Mon, 11 Sep 2023 09:43:48 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Zt4T-9st26DK; Mon, 11 Sep 2023 09:43:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 08DD16234896;
	Mon, 11 Sep 2023 09:43:48 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Bc_dpGCLszHV; Mon, 11 Sep 2023 09:43:47 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id D05ED635DB5B;
	Mon, 11 Sep 2023 09:43:47 +0200 (CEST)
Date: Mon, 11 Sep 2023 09:43:47 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Vincent Whitchurch <Vincent.Whitchurch@axis.com>
Cc: davidgow <davidgow@google.com>, x86 <x86@kernel.org>, 
	dave hansen <dave.hansen@linux.intel.com>, kernel <kernel@axis.com>, 
	rafael j wysocki <rafael.j.wysocki@intel.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, mingo <mingo@redhat.com>, 
	linux-um <linux-um@lists.infradead.org>, tglx <tglx@linutronix.de>, 
	andreyknvl@gmail.com, anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Dmitry Vyukov <dvyukov@google.com>, hpa <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	ryabinin a a <ryabinin.a.a@gmail.com>, frederic@kernel.org, 
	bp <bp@alien8.de>, Alexander Potapenko <glider@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev <kasan-dev@googlegroups.com>
Message-ID: <1681710160.12996.1694418227692.JavaMail.zimbra@nod.at>
In-Reply-To: <f11475f922994b88f5adb14d23240716e16d5303.camel@axis.com>
References: <20230609-uml-kasan-v1-1-5fac8d409d4f@axis.com> <CABVgOS=X1=NC9ad+WV4spFFh4MBHLodhcyQ=Ks=6-FpXrbRTdA@mail.gmail.com> <f11475f922994b88f5adb14d23240716e16d5303.camel@axis.com>
Subject: Re: [PATCH] x86: Fix build of UML with KASAN
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: x86: Fix build of UML with KASAN
Thread-Index: AQHZmsQx3HM02RYVik+aPUiiZcEw2q+Dtz2AgJIVpwAaWaDaFg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_004403_466153_64E3D3D6 
X-CRM114-Status: UNSURE (   5.79  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIlZpbmNlbnQgV2hpdGNodXJj
aCIgPFZpbmNlbnQuV2hpdGNodXJjaEBheGlzLmNvbT4KPj4gVGhhbmtzOiBJIHN0dW1ibGVkIGlu
dG8gdGhpcyB0aGUgb3RoZXIgZGF5IGFuZCByYW4gb3V0IG9mIHRpbWUgdG8gZGVidWcgaXQuCj4+
IAo+PiBJJ3ZlIHRlc3RlZCB0aGF0IGl0IHdvcmtzIGhlcmUuCj4+IAo+PiBUZXN0ZWQtYnk6IERh
dmlkIEdvdyA8ZGF2aWRnb3dAZ29vZ2xlLmNvbT4KPiAKPiBUaGFua3MuICBQZXJoYXBzIHNvbWVv
bmUgY291bGQgcGljayB0aGlzIHVwPyAgSXQncyBiZWVuIGEgZmV3IG1vbnRocywKPiBhbmQgdGhl
IGJ1aWxkIHByb2JsZW0gaXMgc3RpbGwgcHJlc2VudCBvbiB2Ni42LXJjMS4KCkknbGwgaGFwcGls
eSBjYXJyeSBpdCB0aG91Z2ggdGhlIFVNTCB0cmVlIGlmIHdlIGdldCBhbiBBQ0sgZnJvbSB4ODYg
bWFpbnRhaW5lcnMuCgpUaGFua3MsCi8vcmljaGFyZAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC11bQo=
