Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DFDC7EE29
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 08:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=cvWuXxNbU/hef+APFiBXmm/7Zs2ih+OZQVlbu7QTfdE=; b=XuKHNwjz+X5CSUlT88wN8YdYZc
	mS+vjY9npae3s/S2nK+pW0ZfDPBuEYREDmtZphGKOKpN6mC7gyWsB2ONWnHMUGHVLlieNGwlSAZlm
	WULVSuOUZ5zJN/lPyTfQW4KpOpafZGGLY3pjeD1HcmFQG68NIMpEgYY9Qd5xK5whLJFlJjHnNZAdt
	IlfbHu5kXZ929pE5VNMm+nBMjcle1QqG6JiCk+hC4bKqR3u9VH5K9GcwBDYasqv2DICcmxYKN5YD5
	T4q3863nNsZ5H+dvh4eH1MDMADjEUSoTHi7X7hiw4pG0s2jZmMZ3kdIoICUEdtonhD6wQ0lXwqTNA
	bk7toqWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6odE-004ze1-0Q;
	Wed, 07 Jun 2023 08:35:04 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6odB-004zbn-08
	for linux-um@lists.infradead.org;
	Wed, 07 Jun 2023 08:35:03 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B08AD608110F;
	Wed,  7 Jun 2023 10:34:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id sXaARXfzj_XF; Wed,  7 Jun 2023 10:34:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 46A9F61A7038;
	Wed,  7 Jun 2023 10:34:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id REw2yvknD0Qh; Wed,  7 Jun 2023 10:34:55 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2CD10608110F;
	Wed,  7 Jun 2023 10:34:55 +0200 (CEST)
Date: Wed, 7 Jun 2023 10:34:55 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Eric Biggers <ebiggers@kernel.org>, Azeem Shaikh <azeemshaikh38@gmail.com>, 
	Maxim Krasnyansky <maxk@qti.qualcomm.com>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-hardening <linux-hardening@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-um <linux-um@lists.infradead.org>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, 
	kernel test robot <lkp@intel.com>
Message-ID: <2092891129.3692555.1686126895090.JavaMail.zimbra@nod.at>
In-Reply-To: <57443d420183b7a0bcab8041c2dfe3ba44e054f4.camel@sipsolutions.net>
References: <20230606182410.3976487-1-azeemshaikh38@gmail.com> <1833651082.3690424.1686084717406.JavaMail.zimbra@nod.at> <CADmuW3WzC61-si1j61kzwfx5EcsvSt4QBaY9VHiybBRWAN3yyA@mail.gmail.com> <20230607042340.GA941@sol.localdomain> <57443d420183b7a0bcab8041c2dfe3ba44e054f4.camel@sipsolutions.net>
Subject: Re: Reported-by/Closes tag for uncommitted issues (was: Re: [PATCH
 v2] uml: Replace strlcpy with strscpy)
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Reported-by/Closes tag for uncommitted issues (was: Re: [PATCH v2] uml: Replace strlcpy with strscpy)
Thread-Index: htCR070T9Bo9GMJdBdeq8ENX7eWHXA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_013501_384820_DD8CBF57 
X-CRM114-Status: GOOD (  17.91  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIkpvaGFubmVzIEJlcmciIDxq
b2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pgo+IE9uIFR1ZSwgMjAyMy0wNi0wNiBhdCAyMToyMyAt
MDcwMCwgRXJpYyBCaWdnZXJzIHdyb3RlOgo+PiAKPj4gPiA+ID4gUmVwb3J0ZWQtYnk6IGtlcm5l
bCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPgo+PiA+ID4gPiBDbG9zZXM6Cj4+ID4gPiA+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWtidWlsZC1hbGwvMjAyMzA1MzExMTM1LnpHTVQxZ1lS
LWxrcEBpbnRlbC5jb20vCj4+ID4gPiAKPj4gPiA+IEFyZSB5b3Ugc3VyZSBSZXBvcnRlZC1ieSBh
bmQgQ2xvc2VzIG1ha2Ugc2Vuc2U/Cj4+ID4gPiBBRkFJSyB0aGUgcmVwb3J0IHdhcyBvbmx5IG9u
IHlvdXIgZmlyc3QgcGF0Y2ggYW5kIG5vdGhpbmcgYWdhaW5zdCB1cHN0cmVhbS4KPj4gPiA+IFNv
IHN0YXRpbmcgdGhpcyBpbiB0aGUgdXBkYXRlZCBwYXRjaCBpcyBpbiB2YWluLgo+PiA+IAo+PiA+
IEkgbGVmdCB0aGUgbWV0YWRhdGEgaW4gb25seSBmb3IgdGhlIHNha2Ugb2YgcG9zdGVyaXR5LiBJ
ZiBpdCdzIG5vdAo+PiA+IGhlbHBmdWwsIEknbSBvayB3aXRoIHJlbW92aW5nIGl0Lgo+PiA+IAo+
PiAKPj4gSU1PIHVzaW5nIFJlcG9ydGVkLWJ5IGluIGNhc2VzIGxpa2UgdGhpcyBpcyBoYXJtZnVs
LCBhcyBpdCBtYWtlcyBjb21taXRzIHNlZW0KPj4gbGlrZSBidWcgZml4ZXMgd2hlbiB0aGV5IGFy
ZSBub3QuCj4gCj4gSSd2ZSB5ZXQgdG8gc2VlIGFueW9uZSBkaXNhZ3JlZSB3aXRoIHRoYXQsIGFu
ZCB5ZXQsIHRoZSByb2JvdCBhY3RpdmVseQo+IGFza3MgZm9yIHN1Y2ggdGFncyB0byBiZSBpbmNs
dWRlZCBpbiBwYXRjaCByZXN1Ym1pc3Npb25zLgo+IAo+IE9uIHRoZSBvbmUgaGFuZCwgSSBjYW4g
dW5kZXJzdGFuZCB0aGVpciBkZXNpcmUgdG8gYmUgcmVjb2duaXNlZCBmb3IKPiB0aGVpciBlZmZv
cnRzLiBBdCB0aGlzIHBvaW50IHRoZW4gd2UgbWlnaHQgc3VnZ2VzdCB0aGF0IHdlIGludHJvZHVj
ZSBhCj4gZGlmZmVyZW50IHRhZywgc2F5ICJJbXByb3ZlZC1ieToiIG9yICJJc3N1ZXMtZm91bmQt
Ynk6IiBvciBzb21ldGhpbmcuCgpSb2JvdHMgZG9uJ3QgaGF2ZSBmZWVsaW5ncy4gTm8gbmVlZCB0
byB3b3JyeS4gOy0pCiAKPiBPbiB0aGUgb3RoZXIgaGFuZCwgSSBkb24ndCBmZWVsIGxpa2Ugd2Ug
c2hvdWxkIGdpdmUgYSByb2JvdCBtb3JlCj4gcmVjb2duaXRpb24gdGhhbiB3ZSBnaXZlIF9wZW9w
bGVfIHJldmlld2luZywgYW5kIHdlIGN1cnJlbnRseSByZWFsbHkKPiBvbmx5IHJlY29nbmlzZSB0
aGVtIGJ5IGEgUmV2aWV3ZWQtYnkgdGFnLiBUaGVuIGFnYWluLCB0aGF0IGRvZXNuJ3Qgd29yawo+
IHdpdGggdGhlIHJvYm90IC0gaXQgaXMgcHJldHR5IG11Y2ggbG9va2luZyBhdCBlYWNoIHBhdGNo
IGFuZCBvbmx5Cj4gY29tbWVudHMgb24gYSBzbWFsbCBmcmFjdGlvbi4gV2UgYWxzbyByZWFsbHkg
ZG9uJ3Qgd2FudCBpdCB0byBjb21tZW50IG9uCj4gZWFjaCBhbmQgZXZlcnkgcGF0Y2ggLi4uCj4g
Cj4gCj4gU28gaXQgc2VlbXMgd2Ugc2hvdWxkIGFzayB0aGUgcm9ib3QgbWFpbnRhaW5lcnMgdG8g
anVzdCBzdG9wIHN1Z2dlc3RpbmcKPiB0aG9zZSB0YWdzPwoKQWdyZWVkLgoKVGhhbmtzLAovL3Jp
Y2hhcmQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
