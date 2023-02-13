Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14E6C636CC
	for <linux-um@archiver.kernel.org>; Mon, 13 Feb 2023 18:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=d9yOHBnMthkbORFOQ0J+RJ7jX+Tnp5qzdNfm5QKBc5Y=; b=qx2GvwS+57rvWy4G3ANbi5eqZL
	b/HRMTpRQwbCCmamaDes5VpEI0qk2Q8y+otang078sqyeL9WCKR6eOC5W353pv5KBfl2vpJ2dzshn
	5CEF4T7lG4dCLgveVe3SqZuy3aKJ2FOHdUyFAbzXZcjvVXc4aiiCXN5Zr+M5zfakYsnk/W7PggO+J
	ma9L7VsM9Bxej8a1IqJUTl6yya+8J0mh4bWma7P393BSE0n8/MMDNZH+M/OuP4hVgSYt/+wwndDeW
	S8im+nbL9LipP20OrI35389KknPML9/vEJ4hXGoOyscl/xZ4EYMjy2tT8M1yGmGUSLv3xNM+YQJlf
	7g7/ZClw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRdGw-00FpGF-6d; Mon, 13 Feb 2023 18:09:50 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRdGr-00FpBP-OY
	for linux-um@lists.infradead.org; Mon, 13 Feb 2023 18:09:47 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 77BE7642ECD2;
	Mon, 13 Feb 2023 19:09:40 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 6-TR9-K567nC; Mon, 13 Feb 2023 19:09:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 02E746226244;
	Mon, 13 Feb 2023 19:09:40 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0TrPLCqYLqq1; Mon, 13 Feb 2023 19:09:39 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id D33EE642ECD2;
	Mon, 13 Feb 2023 19:09:39 +0100 (CET)
Date: Mon, 13 Feb 2023 19:09:39 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, robh@kernel.org, 
	devicetree@lists.infradead.org, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	kernel <kernel@axis.com>
Message-ID: <583160475.125020.1676311779758.JavaMail.zimbra@nod.at>
In-Reply-To: <d3f6d627290bb1a6a1fcfdfd5fad915578453e02.camel@sipsolutions.net>
References: <20230127-uml-pci-platform-v1-1-ec6b45d2829f@axis.com> <d3f6d627290bb1a6a1fcfdfd5fad915578453e02.camel@sipsolutions.net>
Subject: Re: [PATCH] virt-pci: add platform bus support
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: virt-pci: add platform bus support
Thread-Index: cXUPjo4vUqh3hGEi3Rip8t2wqPOpTg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_100946_007387_6A829AF8 
X-CRM114-Status: UNSURE (   9.91  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIkpvaGFubmVzIEJlcmciIDxq
b2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pgo+IEFuOiAiVmluY2VudCBXaGl0Y2h1cmNoIiA8dmlu
Y2VudC53aGl0Y2h1cmNoQGF4aXMuY29tPiwgInJpY2hhcmQiIDxyaWNoYXJkQG5vZC5hdD4sICJh
bnRvbiBpdmFub3YiCj4gPGFudG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+Cj4gQ0M6IHJv
YmhAa2VybmVsLm9yZywgZGV2aWNldHJlZUBsaXN0cy5pbmZyYWRlYWQub3JnLCAibGludXgtdW0i
IDxsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnPiwgImxpbnV4LWtlcm5lbCIKPiA8bGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZz4sICJrZXJuZWwiIDxrZXJuZWxAYXhpcy5jb20+Cj4gR2Vz
ZW5kZXQ6IE1vbnRhZywgMTMuIEZlYnJ1YXIgMjAyMyAxODo1NDo0OQo+IEJldHJlZmY6IFJlOiBb
UEFUQ0hdIHZpcnQtcGNpOiBhZGQgcGxhdGZvcm0gYnVzIHN1cHBvcnQKCj4gT24gRnJpLCAyMDIz
LTAxLTI3IGF0IDE1OjMwICswMTAwLCBWaW5jZW50IFdoaXRjaHVyY2ggd3JvdGU6Cj4+IFRoaXMg
ZHJpdmVyIHJlZ2lzdGVycyBQQ0kgYnVzc2VzLCBidXQgdGhlIHVuZGVybHlpbmcgdmlydGlvIHBy
b3RvY29sCj4+IGNvdWxkIGp1c3QgYXMgZWFzaWx5IGJlIHVzZWQgdG8gcHJvdmlkZSBhIHBsYXRm
b3JtIGJ1cyBpbnN0ZWFkLiAgSWYgdGhlCj4+IHZpcnRpbyBkZXZpY2Ugbm9kZSBpbiB0aGUgZGV2
aWNldHJlZSBpbmRpY2F0ZXMgdGhhdCBpdCdzIGNvbXBhdGlibGUgd2l0aAo+PiBzaW1wbGUtYnVz
LCByZWdpc3RlciBwbGF0Zm9ybSBkZXZpY2VzIGluc3RlYWQgb2YgaGFuZGxpbmcgaXQgYXMgYSBQ
Q0kKPj4gYnVzLgo+PiAKPj4gT25seSBvbmUgcGxhdGZvcm0gYnVzIGlzIGFsbG93ZWQgYW5kIHRo
ZSBsb2dpYyBNTUlPIHJlZ2lvbiBmb3IgdGhlCj4+IHBsYXRmb3JtIGJ1cyBpcyBwbGFjZWQgYXQg
YW4gYXJiaXRyYXJpbHktY2hvc2VuIGFkZHJlc3MgYXdheSBmcm9tIHRoZQo+PiBQQ0kgcmVnaW9u
Lgo+IAo+IFNvIC4uLiBobS4gSSdtIG5vdCBzdXJlIEkgX2xpa2VfIHRoaXMgc28gbXVjaC4gSXQg
ZmVlbHMgZGVjaWRlZGx5Cj4gc3RyYW5nZSB0byBwdXQgaXQgdGhpcyB3YXkuCj4gCj4gQnV0IGl0
IGxvb2tzIGxpa2UgUmljaGFyZCBhbHJlYWR5IGFwcGxpZWQgaXQsIHNvIEkgc3VwcG9zZSBsb29r
IGF0IHRoaXMKPiBhcyBraW5kIG9mIGEgcmV0cm9hY3RpdmUgaW5mb3JtYXRpb24gZ2F0aGVyaW5n
LiA6KQoKSSBsaWtlZCB0aGUgaWRlYSwgdGhlIHBhdGNoIG1hZGUgc2Vuc2UsIHNvIHllcy4KQnV0
IHRoaXMgZG9lcyBub3QgbWVhbiB0aGF0IHRoaW5ncyBjYW4ndCBiZSBjaGFuZ2VkLgpVbnRpbCB3
ZSByZWxlYXNlIDYuMyB3ZSBoYXZlIHRpbWUuCgpUaGFua3MsCi8vcmljaGFyZAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBs
aXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
