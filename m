Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDD7EB64DA
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 20:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/Rs8xd/AKa/wFCnsC7LbacQv4PkyHPGz+HxEDVnxUGM=; b=WnjUDjrS386iIGdqwsDNa2/z6Z
	25rFUeVtKYj3zpTU+s4y2rOpmILifL19Fb0PID2GG90o3uyE/lm06cFft7Qs7R84ujc0RYCzQNuw7
	wh0Nuq5R3rZT6gb+PTrfxajl6r8tR9am9SJrJgHIJfGB2vKpbH9Z0ZhkwpOcHQRWlyM4cTfk4jwpl
	9jZhVft5ZI6awaJInxvHyD8l8ONidronsgTEnY7Cm4rtHjLZ5Dj941eTPkAW1QmLxcW3nrPpoQfOT
	wxt4+dHzG3VESBD64zSLB8Uis1CMUT9Y35ce0RhWSOK6g8SCp/PBVqLurWot8hJ5AQuIQTa2DW33x
	tD6YnkTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCQqE-001eFZ-1N;
	Thu, 22 Jun 2023 20:23:42 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCQqA-001eEK-0H
	for linux-um@lists.infradead.org;
	Thu, 22 Jun 2023 20:23:41 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 05E8F616B2CC;
	Thu, 22 Jun 2023 22:23:32 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id r-yUtuVyJPGc; Thu, 22 Jun 2023 22:23:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0743B616B2D1;
	Thu, 22 Jun 2023 22:23:31 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dmTJe5PJXMir; Thu, 22 Jun 2023 22:23:30 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id DA20D616B2CC;
	Thu, 22 Jun 2023 22:23:30 +0200 (CEST)
Date: Thu, 22 Jun 2023 22:23:30 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Johannes Berg <johannes@sipsolutions.net>, robh <robh@kernel.org>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	linux-um <linux-um@lists.infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <889626017.12829920.1687465410834.JavaMail.zimbra@nod.at>
In-Reply-To: <69707b721698594f96899c050871bcbb3594a9a1.camel@sipsolutions.net>
References: <20230622192247.GA2278576-robh@kernel.org> <dc5704a5d452f7432313170ed900975b2b72354f.camel@sipsolutions.net> <69707b721698594f96899c050871bcbb3594a9a1.camel@sipsolutions.net>
Subject: Re: UML for arm64
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: UML for arm64
Thread-Index: 4a05EORgIqHsqnfNy6e+Z1IWlktT3g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_132338_295757_F9175859 
X-CRM114-Status: GOOD (  15.94  )
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

W0NDJ2luZyBBbF0KCi0tLS0tIFVyc3Byw7xuZ2xpY2hlIE1haWwgLS0tLS0KPiBWb246ICJCZW5q
YW1pbiBCZXJnIiA8YmVuamFtaW5Ac2lwc29sdXRpb25zLm5ldD4KPiBBbjogIkpvaGFubmVzIEJl
cmciIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0PiwgInJvYmgiIDxyb2JoQGtlcm5lbC5vcmc+
LCAicmljaGFyZCIgPHJpY2hhcmRAbm9kLmF0PiwgImFudG9uIGl2YW5vdiIKPiA8YW50b24uaXZh
bm92QGNhbWJyaWRnZWdyZXlzLmNvbT4KPiBDQzogImxpbnV4LXVtIiA8bGludXgtdW1AbGlzdHMu
aW5mcmFkZWFkLm9yZz4KPiBHZXNlbmRldDogRG9ubmVyc3RhZywgMjIuIEp1bmkgMjAyMyAyMjox
Mzo1Ngo+IEJldHJlZmY6IFJlOiBVTUwgZm9yIGFybTY0Cgo+IEhpLAo+IAo+IE9uIFRodSwgMjAy
My0wNi0yMiBhdCAyMTo0MSArMDIwMCwgSm9oYW5uZXMgQmVyZyB3cm90ZToKPj4gT24gVGh1LCAy
MDIzLTA2LTIyIGF0IDEzOjIyIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToKPj4gPiBJJ20gaW50
ZXJlc3RlZCBpbiBnZXR0aW5nIFVNTCB3b3JraW5nIG9uIEFybS4gSXMgYW55b25lIGF3YXJlIG9m
IGFueQo+PiA+IGVmZm9ydHMgdG8gZG8gdGhpcyBhbHJlYWR5Pwo+PiAKPj4gTm90IG1lIC4uLiBC
dXQgeWVhaCwgYWdyZWUgdGhhdCBpdCBzZWVtcyBsaWtlbHkgdG8gcmVxdWlyZSBzb21lCj4+IHJl
ZmFjdG9yaW5nLCBldmVuIGlmIF9zb21lXyBkZWdyZWUgb2YgYXR0ZW1wdHMgd2VyZSBtYWRlIHRv
IGtlZXAgYXJjaC0KPj4gc3BlY2lmaWMgdGhpbmdzIHRoZXJlIC4uLgo+PiAKPj4gVGhlcmUgbWln
aHQgYmUgYSB0b24gb2YgYXJjaC1zcGVjaWZpYyB0aGluZ3MgaW4gdGhlIHB0cmFjZSBjb2RlIHRv
bwoKSSB0aGluayBBbCBkaWQgc29tZSB3b3JrIGluIHRoZSBwYXN0IHRvIHN1cHBvcnQgYXJjaHMg
b3RoZXIgdGhhbiB4ODYuCkl0IHdhcyBub3QgYXJtNjQsIHRob3VnaC4gcHBjIG9yIHNwYXJjIElJ
UkMuIE1heWJlIGhlIGhhcyBzb21lIGlucHV0LgogCj4gQXQgbGVhc3QgYSBsb3Qgb2YgdGhlIHJl
Z2lzdGVyIGhhbmRsaW5nLCBidXQgdGhhdCB3aWxsIGFsd2F5cyBiZQo+IHNvbWV3aGF0IGFyY2hp
dGVjdHVyZSBzcGVjaWZpYy4KPiAKPj4gLi4uICwgc28gcGVyaGFwcyBpdCdkIGJlIGVhc2llciB0
byBzdGFydCB3aXRoIHRoZSBzZWNjb21wLWJhc2VkIG1vZGVsOgo+PiAKPj4gaHR0cHM6Ly9wYXRj
aHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4LXVtL2xpc3QvP3Nlcmllcz0zMjk0NjYKPj4g
Cj4+IEJ1dCB0aGF0J3Mgbm90IHJlYWxseSBkb25lIHlldCBlaXRoZXIuCj4gCj4gWWVzLCB0aG91
Z2ggSSBoYXZlIHF1aXRlIHNvbWUgdXBkYXRlcyBsb2NhbGx5IHRoYXQgc29sdmUgdGhlIHNlY3Vy
aXR5Cj4gaXNzdWVzIChpLmUuIHByZXZlbnQgaG9zdCBzeXNjYWxscyBmcm9tIHVzZXJzcGFjZSku
IFNvLCBpdCBkb2VzIG5lZWQKPiByZWJhc2luZyBhbmQgSSBhbSBzdXJlIGJ1Z2ZpeGVzLCBidXQg
SSB0aGluayBpdCBpcyBnZXR0aW5nIGludG8gYQo+IHByZXR0eSBnb29kIHNoYXBlIG92ZXJhbGwu
Cj4gCj4gRWl0aGVyIHdheSwgdGhlIG9sZCBwYXRjaHNldCB3aWxsIGdpdmUgeW91IGEgZ29vZCBp
ZGVhIGFib3V0IGhvdyBpdCBhbGwKPiB3b3JrcywgdGhlIGNoYW5nZXMgYXJlIG1vc3RseSBpbiB0
aGUgZGV0YWlscy4gSSBhbSBoYXBweSB0byBwdXNoIG91dCBhCj4gbmV3IHZlcnNpb24gc29vbmVy
IHJhdGhlciB0aGFuIGxhdGVyIGlmIGl0IG1pZ2h0IGhlbHAgd2l0aCBhbnkgZWZmb3J0cwo+IG9u
IHlvdXIgc2lkZS4KCkkgdGhpbmsgcmV2aXZpbmcgdGhlIHNlY2NvbXAgcGF0Y2ggc2V0IGlzIGEg
Z29vZCBpZGVhIGluIGFueSBjYXNlLgpNYXliZSBpdCBpcyBldmVuIGEgd2F5IHRvIGFsbG93IFNN
UCBzdXBwb3J0LgoKVGhhbmtzLAovL3JpY2hhcmQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtdW0K
