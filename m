Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC052C7EE29
	for <linux-um@archiver.kernel.org>; Thu, 25 May 2023 18:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1N7yKhAULhULv5AT4jUMjW8HBbM9pST4gdy+vlVUutE=; b=KBAOM/nZM0kqrV
	6pb1WvNxVS95hPgwmP55jZq7us4T2/jEqRy9HCYbGvKZJ75GZrlpt2MumBSIxOgKzZhj5zCfxwCHC
	q3bgpPPqLd0PeY4j/NC56rS/PGmZjqjtfYF1N2p8xpPsWP+RsRjaggIhTEYrVrAdzhoXd/SS4ZneJ
	g32igeBSyH/aVcaRnQ86wC5yLpbz6PH8yhxprxkctmfFO/xcA+AEJRFubwCtOHM+az+SGtkHyMeq5
	S1dh/xFFnBDNo7iJEhMk8fnZSnlfKbuwl3KeSYjiI8+hJyNdo2WpS5bdnc7JsB81UFkbQh1hgdBkj
	xTvGjfp2mlXMUeemXxlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FKR-00HKTw-2G;
	Thu, 25 May 2023 18:04:47 +0000
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FKL-00HKRJ-1h;
	Thu, 25 May 2023 18:04:45 +0000
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-ba878d5e75fso1224375276.3;
        Thu, 25 May 2023 11:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685037879; x=1687629879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHz1MnM6TYYio2C+7LZLfrVXy67ugaabkk4Lxt+VEKA=;
        b=NoHSm+P+R3f9P1hTtI0Aa2538QwCPLtSoQPrBLURQdxmp107FQ1F0pBnbEQWwggzlT
         fiTACnc6uzA/OAWqwR1JVWYYICkwBDdnIXj4ERwntlgZc/Oij0dm8rv+0LrV+CltMo3B
         fKyXLHfkdRh4xQKVcMe8OCp5giU3Tnn12LZCznOtQl1pIuAziPLT4fePeWe5Cvh7ZNzP
         bRQ3kdfBju0tbpe4F8kOJL6Oz3PfBgKD+/0uu8kOUyKFxwwoV5gkGDAbnMcHEgSeCLSi
         HSGZ+QgYvXiydUgpNmaTWLnoPbGEK3dVe0T9hw+SN0OStPQTocdixTet+7JhvERZXcH+
         xYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685037879; x=1687629879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHz1MnM6TYYio2C+7LZLfrVXy67ugaabkk4Lxt+VEKA=;
        b=GWMCeJHaHdMatC6u3xTfvwoPdajrYQzN9tbOdo+4ad9eOXqjyK7qDlSqX3vpY3gTLk
         jeUadRZdV2Ma1FAirjtKCpybimz3bD8EfYJzRyQzDPHhoV6tDkgq8DAHh24626J6g9gi
         TZh/9zHUH9T7EM6Y0RLHRNtbsHnIDjfpopBOdg1a8Pbg8KPKHKkXfiz1DUVdFYPBYJ/Y
         wDDEfpfC4tKMYhbgHjBNrQlzeQxK9YEyseYO6UVJTcslDgC3U37zVTOv4xSV+OAlxtLX
         rAYwYFnCO/Vai5jVcdPLd+xpNOUw5yjQl4eaaWvkBJb49PtHdSUe2k01n1to3mYxpXUW
         GYfg==
X-Gm-Message-State: AC+VfDz0Jbkvu81J7pvdA29tfNq1YQKa380fxfyui6O5Y2l/3o8rE5Wr
	Zv1pWC4qcwbDLD4Aaso4ghhA0iBgK1PMq1w/Olw=
X-Google-Smtp-Source: ACHHUZ7leu3e42UYud7EgWJZoN6PW1XGYdS9PCBG/tq5rzS7YnuUSWzFoklHW8B2kAANtPb/IRvLBp1ufSDbPWAmKj4=
X-Received: by 2002:a25:7493:0:b0:ba8:15a3:f2e4 with SMTP id
 p141-20020a257493000000b00ba815a3f2e4mr4848492ybc.0.1685037879336; Thu, 25
 May 2023 11:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-6-vishal.moola@gmail.com> <20230525090956.GX4967@kernel.org>
In-Reply-To: <20230525090956.GX4967@kernel.org>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Thu, 25 May 2023 11:04:28 -0700
Message-ID: <CAOzc2pxSH6GhBnAoSOjvYJk2VdMDFZi3H_1qGC5Cdyp3j4AzPQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/34] mm: add utility functions for ptdesc
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_110441_563979_B181FAA4 
X-CRM114-Status: GOOD (  28.22  )
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

T24gVGh1LCBNYXkgMjUsIDIwMjMgYXQgMjoxMOKAr0FNIE1pa2UgUmFwb3BvcnQgPHJwcHRAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4KPiBPbiBNb24sIE1heSAwMSwgMjAyMyBhdCAxMjoyODowMFBNIC0w
NzAwLCBWaXNoYWwgTW9vbGEgKE9yYWNsZSkgd3JvdGU6Cj4gPiBJbnRyb2R1Y2UgdXRpbGl0eSBm
dW5jdGlvbnMgc2V0dGluZyB0aGUgZm91bmRhdGlvbiBmb3IgcHRkZXNjcy4gVGhlc2UKPiA+IHdp
bGwgYWxzbyBhc3Npc3QgaW4gdGhlIHNwbGl0dGluZyBvdXQgb2YgcHRkZXNjIGZyb20gc3RydWN0
IHBhZ2UuCj4gPgo+ID4gcHRkZXNjX2FsbG9jKCkgaXMgZGVmaW5lZCB0byBhbGxvY2F0ZSBuZXcg
cHRkZXNjIHBhZ2VzIGFzIGNvbXBvdW5kCj4gPiBwYWdlcy4gVGhpcyBpcyB0byBzdGFuZGFyZGl6
ZSBwdGRlc2NzIGJ5IGFsbG93aW5nIGZvciBvbmUgYWxsb2NhdGlvbgo+ID4gYW5kIG9uZSBmcmVl
IGZ1bmN0aW9uLCBpbiBjb250cmFzdCB0byAyIGFsbG9jYXRpb24gYW5kIDIgZnJlZSBmdW5jdGlv
bnMuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogVmlzaGFsIE1vb2xhIChPcmFjbGUpIDx2aXNoYWwu
bW9vbGFAZ21haWwuY29tPgo+ID4gLS0tCj4gPiAgaW5jbHVkZS9hc20tZ2VuZXJpYy90bGIuaCB8
IDExICsrKysrKysrKysKPiA+ICBpbmNsdWRlL2xpbnV4L21tLmggICAgICAgIHwgNDQgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiAgaW5jbHVkZS9saW51eC9wZ3Rh
YmxlLmggICB8IDEyICsrKysrKysrKysrCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA2NyBpbnNlcnRp
b25zKCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvdGxiLmggYi9p
bmNsdWRlL2FzbS1nZW5lcmljL3RsYi5oCj4gPiBpbmRleCBiNDY2MTcyMDdjOTMuLjZiYWRlOWUw
ZTc5OSAxMDA2NDQKPiA+IC0tLSBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvdGxiLmgKPiA+ICsrKyBi
L2luY2x1ZGUvYXNtLWdlbmVyaWMvdGxiLmgKPiA+IEBAIC00ODEsNiArNDgxLDE3IEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCB0bGJfcmVtb3ZlX3BhZ2Uoc3RydWN0IG1tdV9nYXRoZXIgKnRsYiwgc3Ry
dWN0IHBhZ2UgKnBhZ2UpCj4gPiAgICAgICByZXR1cm4gdGxiX3JlbW92ZV9wYWdlX3NpemUodGxi
LCBwYWdlLCBQQUdFX1NJWkUpOwo+ID4gIH0KPiA+Cj4gPiArc3RhdGljIGlubGluZSB2b2lkIHRs
Yl9yZW1vdmVfcHRkZXNjKHN0cnVjdCBtbXVfZ2F0aGVyICp0bGIsIHZvaWQgKnB0KQo+ID4gK3sK
PiA+ICsgICAgIHRsYl9yZW1vdmVfdGFibGUodGxiLCBwdCk7Cj4gPiArfQo+ID4gKwo+ID4gKy8q
IExpa2UgdGxiX3JlbW92ZV9wdGRlc2MsIGJ1dCBmb3IgcGFnZS1saWtlIHBhZ2UgZGlyZWN0b3Jp
ZXMuICovCj4gPiArc3RhdGljIGlubGluZSB2b2lkIHRsYl9yZW1vdmVfcGFnZV9wdGRlc2Moc3Ry
dWN0IG1tdV9nYXRoZXIgKnRsYiwgc3RydWN0IHB0ZGVzYyAqcHQpCj4gPiArewo+ID4gKyAgICAg
dGxiX3JlbW92ZV9wYWdlKHRsYiwgcHRkZXNjX3BhZ2UocHQpKTsKPiA+ICt9Cj4gPiArCj4gPiAg
c3RhdGljIGlubGluZSB2b2lkIHRsYl9jaGFuZ2VfcGFnZV9zaXplKHN0cnVjdCBtbXVfZ2F0aGVy
ICp0bGIsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1bnNpZ25lZCBpbnQgcGFnZV9zaXplKQo+ID4gIHsKPiA+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L21tLmggYi9pbmNsdWRlL2xpbnV4L21tLmgKPiA+IGluZGV4IGIxODg0OGFlN2Uy
Mi4uMjU4ZjNiNzMwMzU5IDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9tbS5oCj4gPiAr
KysgYi9pbmNsdWRlL2xpbnV4L21tLmgKPiA+IEBAIC0yNzQ0LDYgKzI3NDQsNDUgQEAgc3RhdGlj
IGlubGluZSBwbWRfdCAqcG1kX2FsbG9jKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCBwdWRfdCAqcHVk
LCB1bnNpZ25lZCBsb25nIGEKPiA+ICB9Cj4gPiAgI2VuZGlmIC8qIENPTkZJR19NTVUgKi8KPiA+
Cj4gPiArc3RhdGljIGlubGluZSBzdHJ1Y3QgcHRkZXNjICp2aXJ0X3RvX3B0ZGVzYyhjb25zdCB2
b2lkICp4KQo+ID4gK3sKPiA+ICsgICAgIHJldHVybiBwYWdlX3B0ZGVzYyh2aXJ0X3RvX2hlYWRf
cGFnZSh4KSk7Cj4KPiBEbyB3ZSBldmVyIHVzZSBjb21wb3VuZCBwYWdlcyBmb3IgcGFnZSB0YWJs
ZXM/CgpNaXBzIGFuZCBzMzkwIGNyc3QgdGFibGVzIHVzZSBtdWx0aS1vcmRlciAoYnV0IG5vdCBj
b21wb3VuZCkgcGFnZXMuClRoZSBwdGRlc2MgYXBpICpzaG91bGQqIGNoYW5nZSB0aGF0LCBidXQg
dW50aWwgYWxsIHRoZSBhbGxvY2F0aW9uL2ZyZWUgcGF0aHMKYXJlIGNoYW5nZWQgaXQgbWF5IGNh
dXNlIHByb2JsZW1zLgpUaGFua3MgZm9yIGNhdGNoaW5nIHRoYXQsIEknbGwgY2hhbmdlIGl0IGlu
IHYzLgoKPiA+ICt9Cj4gPiArCj4gPiArc3RhdGljIGlubGluZSB2b2lkICpwdGRlc2NfdG9fdmly
dChjb25zdCBzdHJ1Y3QgcHRkZXNjICpwdCkKPiA+ICt7Cj4gPiArICAgICByZXR1cm4gcGFnZV90
b192aXJ0KHB0ZGVzY19wYWdlKHB0KSk7Cj4gPiArfQo+ID4gKwo+ID4gK3N0YXRpYyBpbmxpbmUg
dm9pZCAqcHRkZXNjX2FkZHJlc3MoY29uc3Qgc3RydWN0IHB0ZGVzYyAqcHQpCj4gPiArewo+ID4g
KyAgICAgcmV0dXJuIGZvbGlvX2FkZHJlc3MocHRkZXNjX2ZvbGlvKHB0KSk7Cj4gPiArfQo+ID4g
Kwo+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCBwdGRlc2NfaXNfcmVzZXJ2ZWQoc3RydWN0IHB0ZGVz
YyAqcHQpCj4gPiArewo+ID4gKyAgICAgcmV0dXJuIGZvbGlvX3Rlc3RfcmVzZXJ2ZWQocHRkZXNj
X2ZvbGlvKHB0KSk7Cj4gPiArfQo+ID4gKwo+ID4gK3N0YXRpYyBpbmxpbmUgc3RydWN0IHB0ZGVz
YyAqcHRkZXNjX2FsbG9jKGdmcF90IGdmcCwgdW5zaWduZWQgaW50IG9yZGVyKQo+ID4gK3sKPiA+
ICsgICAgIHN0cnVjdCBwYWdlICpwYWdlID0gYWxsb2NfcGFnZXMoZ2ZwIHwgX19HRlBfQ09NUCwg
b3JkZXIpOwo+ID4gKwo+ID4gKyAgICAgcmV0dXJuIHBhZ2VfcHRkZXNjKHBhZ2UpOwo+ID4gK30K
PiA+ICsKPiA+ICtzdGF0aWMgaW5saW5lIHZvaWQgcHRkZXNjX2ZyZWUoc3RydWN0IHB0ZGVzYyAq
cHQpCj4gPiArewo+ID4gKyAgICAgc3RydWN0IHBhZ2UgKnBhZ2UgPSBwdGRlc2NfcGFnZShwdCk7
Cj4gPiArCj4gPiArICAgICBfX2ZyZWVfcGFnZXMocGFnZSwgY29tcG91bmRfb3JkZXIocGFnZSkp
Owo+ID4gK30KPgo+IFRoZSBwdGRlc2Nfe2FsbG9jLGZyZWV9IEFQSSBkb2VzIG5vdCBzb3VuZCBy
aWdodCB0byBtZS4gVGhlIG5hbWUKPiBwdGRlc2NfYWxsb2MoKSBpbXBsaWVzIHRoZSBhbGxvY2F0
aW9uIG9mIHRoZSBwdGRlc2MgaXRzZWxmLCByYXRoZXIgdGhhbgo+IGFsbG9jYXRpb24gb2YgcGFn
ZSB0YWJsZSBwYWdlLiBUaGUgc2FtZSBnb2VzIGZvciBmcmVlLgoKSSdtIG5vdCBzdXJlIEkgc2Vl
IHRoZSBkaWZmZXJlbmNlLiBDb3VsZCB5b3UgZWxhYm9yYXRlPwoKPiA+ICsKPiA+ICtzdGF0aWMg
aW5saW5lIHZvaWQgcHRkZXNjX2NsZWFyKHZvaWQgKngpCj4gPiArewo+ID4gKyAgICAgY2xlYXJf
cGFnZSh4KTsKPiA+ICt9Cj4gPiArCj4gPiAgI2lmIFVTRV9TUExJVF9QVEVfUFRMT0NLUwo+ID4g
ICNpZiBBTExPQ19TUExJVF9QVExPQ0tTCj4gPiAgdm9pZCBfX2luaXQgcHRsb2NrX2NhY2hlX2lu
aXQodm9pZCk7Cj4gPiBAQCAtMjk3MCw2ICszMDA5LDExIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBt
YXJrX3BhZ2VfcmVzZXJ2ZWQoc3RydWN0IHBhZ2UgKnBhZ2UpCj4gPiAgICAgICBhZGp1c3RfbWFu
YWdlZF9wYWdlX2NvdW50KHBhZ2UsIC0xKTsKPiA+ICB9Cj4gPgo+ID4gK3N0YXRpYyBpbmxpbmUg
dm9pZCBmcmVlX3Jlc2VydmVkX3B0ZGVzYyhzdHJ1Y3QgcHRkZXNjICpwdCkKPiA+ICt7Cj4gPiAr
ICAgICBmcmVlX3Jlc2VydmVkX3BhZ2UocHRkZXNjX3BhZ2UocHQpKTsKPiA+ICt9Cj4gPiArCj4g
PiAgLyoKPiA+ICAgKiBEZWZhdWx0IG1ldGhvZCB0byBmcmVlIGFsbCB0aGUgX19pbml0IG1lbW9y
eSBpbnRvIHRoZSBidWRkeSBzeXN0ZW0uCj4gPiAgICogVGhlIGZyZWVkIHBhZ2VzIHdpbGwgYmUg
cG9pc29uZWQgd2l0aCBwYXR0ZXJuICJwb2lzb24iIGlmIGl0J3Mgd2l0aGluCj4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9wZ3RhYmxlLmggYi9pbmNsdWRlL2xpbnV4L3BndGFibGUuaAo+
ID4gaW5kZXggNWUwZjUxMzA4NzI0Li5iMDY3YWMxMGYzZGQgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNs
dWRlL2xpbnV4L3BndGFibGUuaAo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9wZ3RhYmxlLmgKPiA+
IEBAIC0xMDQxLDYgKzEwNDEsMTggQEAgVEFCTEVfTUFUQ0gocHRsLCBwdGwpOwo+ID4gICN1bmRl
ZiBUQUJMRV9NQVRDSAo+ID4gIHN0YXRpY19hc3NlcnQoc2l6ZW9mKHN0cnVjdCBwdGRlc2MpIDw9
IHNpemVvZihzdHJ1Y3QgcGFnZSkpOwo+ID4KPiA+ICsjZGVmaW5lIHB0ZGVzY19wYWdlKHB0KSAg
ICAgICAgICAgICAgICAgICAgICAoX0dlbmVyaWMoKHB0KSwgICAgICAgICAgICAgICAgIFwKPiA+
ICsgICAgIGNvbnN0IHN0cnVjdCBwdGRlc2MgKjogICAgICAgICAgKGNvbnN0IHN0cnVjdCBwYWdl
ICopKHB0KSwgICAgICBcCj4gPiArICAgICBzdHJ1Y3QgcHRkZXNjICo6ICAgICAgICAgICAgICAg
IChzdHJ1Y3QgcGFnZSAqKShwdCkpKQo+ID4gKwo+ID4gKyNkZWZpbmUgcHRkZXNjX2ZvbGlvKHB0
KSAgICAgICAgICAgICAoX0dlbmVyaWMoKHB0KSwgICAgICAgICAgICAgICAgIFwKPiA+ICsgICAg
IGNvbnN0IHN0cnVjdCBwdGRlc2MgKjogICAgICAgICAgKGNvbnN0IHN0cnVjdCBmb2xpbyAqKShw
dCksICAgICBcCj4gPiArICAgICBzdHJ1Y3QgcHRkZXNjICo6ICAgICAgICAgICAgICAgIChzdHJ1
Y3QgZm9saW8gKikocHQpKSkKPiA+ICsKPiA+ICsjZGVmaW5lIHBhZ2VfcHRkZXNjKHApICAgICAg
ICAgICAgICAgICAgICAgICAoX0dlbmVyaWMoKHApLCAgICAgICAgICAgICAgICAgIFwKPiA+ICsg
ICAgIGNvbnN0IHN0cnVjdCBwYWdlICo6ICAgICAgICAgICAgKGNvbnN0IHN0cnVjdCBwdGRlc2Mg
KikocCksICAgICBcCj4gPiArICAgICBzdHJ1Y3QgcGFnZSAqOiAgICAgICAgICAgICAgICAgIChz
dHJ1Y3QgcHRkZXNjICopKHApKSkKPiA+ICsKPiA+ICAvKgo+ID4gICAqIE5vLW9wIG1hY3JvcyB0
aGF0IGp1c3QgcmV0dXJuIHRoZSBjdXJyZW50IHByb3RlY3Rpb24gdmFsdWUuIERlZmluZWQgaGVy
ZQo+ID4gICAqIGJlY2F1c2UgdGhlc2UgbWFjcm9zIGNhbiBiZSB1c2VkIGV2ZW4gaWYgQ09ORklH
X01NVSBpcyBub3QgZGVmaW5lZC4KPiA+IC0tCj4gPiAyLjM5LjIKPiA+Cj4gPgo+Cj4gLS0KPiBT
aW5jZXJlbHkgeW91cnMsCj4gTWlrZS4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtdW0K
