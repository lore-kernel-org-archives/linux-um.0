Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45607EB64D7
	for <linux-um@archiver.kernel.org>; Fri, 16 Jun 2023 21:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uVbpMsdxZxHSQe/E3BcXQieaPsq4uGiu9QvGhBL6780=; b=Mq50+NcrtvhNwj
	VZcin9Vjhq7DVwis6DrXFkj5X6+xKzv9RjY9Wm6Da7YL4uc4o2QI2pRyXE54ghCOAMb+60vChKvMt
	gkcZ/1C8t+1iwjbcemA35xN90YiKypAKY/qHjwzKGamEut/re4Z1z38XnepBgoFS+3t6pFDurRfa9
	pBPCkpOINFuNC4PiHyIy+93JgW2VwVhZ+lkqkNyCyg2nyVzMNq4RZDNZflttBZIQumc6Rzwm7C5Ep
	z6FRajYam300dta5wIDhHAGAAVreYcghEbFNsCtornyPEJku/Kmb3u8UKq+9CaVNOJRXTbBzL0vCJ
	oUTXyt8Ct99FQ5nZjknw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qAH0B-001u8j-0j;
	Fri, 16 Jun 2023 21:29:03 +0000
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qAH06-001u6K-2m;
	Fri, 16 Jun 2023 21:29:00 +0000
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-570114e1feaso14301367b3.3;
        Fri, 16 Jun 2023 14:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686950935; x=1689542935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8f4Qp7cwj4O2kdf7qLqLnrTRkxhB0m+8FmgrZaxSBc=;
        b=kDqKbU7P9edSk/BgMH9xSstpKqVCZCkotk48bdhsv9CQedo7tgzNx594G7ZL6GQuxg
         jA1o2JPcz0QDYMp8Gk7IfVIBu/Qb0pO39azZ5F7HLfZC1IgCGAp3b3idtV3rR/BwTQDN
         x0xETay6eu3ghZcxBbeBHYOXCm+0UdQ18fM+kmxKxAuiYRqF/zWkw4LlfaXk/Ol9POup
         f5e5C/WGoi8jmqXjJwP7rx3T/q8TLMKNW53qsepy7E0u9eKRuHWvS7CgQ60QFJLvcMrS
         P+YDUzuxecN+sqBu1rA+X9cuH9CB9q1H/97ksOSagJnc4ZVXc8JgbNn89oLF/7saT6Tn
         z99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686950935; x=1689542935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8f4Qp7cwj4O2kdf7qLqLnrTRkxhB0m+8FmgrZaxSBc=;
        b=iykddw8yHoUtvxcb+T/B7pO0HTGnjfFxgrQuTQaZVWN+QlkqSCozszMNQj3v/zGxSD
         osYmgKQPIjS/d69pIo+K77CgDSaouZJ3wlxE24sikyWq0jQKQp5JGUdDw8v+WFlLJtWr
         ZWVRPoH6EQO3hCCNonihUPTYchG7XFvBINip0V5TpIhsC7VlkIH4FCBFtCNwiincUnMS
         NVN7i8oGfVGCWNss9f7ehyLCf7UQwg1jX29h2vICgLVsGSyCAD48e2Za6N94a0AkqQrF
         QH7iD1460L3jDw+q/wVQJXQ+YqWmR4C7doYzVdQl9xtzLpGguTws3nAoC/+Sn7Yneedh
         ZY2A==
X-Gm-Message-State: AC+VfDzltu+BkN3TZ77TO62+6EfcgL6lWWKYaoKMbdccMRv3yC/dHFcz
	73+OrMgjrEHv+Xcp7wvbWiXUDrynqTS/tbcIUE4=
X-Google-Smtp-Source: ACHHUZ7/iv7DGmrSbI7dWoycmh8dvViREYGBrKV5KnrTS1VkZy/HhcudLLxyAMIf5U1P44XX8eoY39CR0V8jmRNeXMA=
X-Received: by 2002:a81:6c02:0:b0:56c:f684:b4f0 with SMTP id
 h2-20020a816c02000000b0056cf684b4f0mr2990065ywc.27.1686950935072; Fri, 16 Jun
 2023 14:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-5-vishal.moola@gmail.com> <fd63179-6ad6-fd86-79d6-2833c91111f8@google.com>
In-Reply-To: <fd63179-6ad6-fd86-79d6-2833c91111f8@google.com>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Fri, 16 Jun 2023 14:28:44 -0700
Message-ID: <CAOzc2pwhoF=XNCoe-+w2Z5MRoRJGvTfSr56HV00OGitEBMtPcw@mail.gmail.com>
Subject: Re: [PATCH v4 04/34] pgtable: Create struct ptdesc
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Heiko Carstens <hca@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, 
	kvm@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230616_142858_923565_89882DA7 
X-CRM114-Status: GOOD (  40.43  )
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

T24gVGh1LCBKdW4gMTUsIDIwMjMgYXQgMTI6NTfigK9BTSBIdWdoIERpY2tpbnMgPGh1Z2hkQGdv
b2dsZS5jb20+IHdyb3RlOgo+Cj4gT24gTW9uLCAxMiBKdW4gMjAyMywgVmlzaGFsIE1vb2xhIChP
cmFjbGUpIHdyb3RlOgo+Cj4gPiBDdXJyZW50bHksIHBhZ2UgdGFibGUgaW5mb3JtYXRpb24gaXMg
c3RvcmVkIHdpdGhpbiBzdHJ1Y3QgcGFnZS4gQXMgcGFydAo+ID4gb2Ygc2ltcGxpZnlpbmcgc3Ry
dWN0IHBhZ2UsIGNyZWF0ZSBzdHJ1Y3QgcHRkZXNjIGZvciBwYWdlIHRhYmxlCj4gPiBpbmZvcm1h
dGlvbi4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBWaXNoYWwgTW9vbGEgKE9yYWNsZSkgPHZpc2hh
bC5tb29sYUBnbWFpbC5jb20+Cj4KPiBWaXNoYWwsIGFzIEkgdGhpbmsgeW91IGhhdmUgYWxyZWFk
eSBndWVzc2VkLCB5b3VyIHB0ZGVzYyBzZXJpZXMgYW5kCj4gbXkgcHRlX2ZyZWVfZGVmZXIoKSAi
bW06IGZyZWUgcmV0cmFjdGVkIHBhZ2UgdGFibGUgYnkgUkNVIiBzZXJpZXMgYXJlCj4gb24gYSBj
b2xsaXNpb24gY291cnNlLgo+Cj4gUHJvYmFibHkganVzdCB0cml2aWFsIGNvbGxpc2lvbnMgaW4g
bW9zdCBhcmNoaXRlY3R1cmVzLCB3aGljaCBlaXRoZXIKPiBvZiB1cyBjYW4gZWFzaWx5IGFkanVz
dCB0byB0aGUgb3RoZXI7IHBvd2VycGMgbGlrZWx5IHRvIGJlIG1vcmUgYXdrd2FyZCwKPiBidXQg
ZmFpcmx5IGVhc2lseSByZXNvbHZlZDsgczM5MCBxdWl0ZSBhIHByb2JsZW0uCj4KPiBJJ3ZlIHNv
IGZhciBiZWVuIHVuYWJsZSB0byBwb3N0IGEgdjIgb2YgbXkgc2VyaWVzIChhbmQgcG93ZXJwYyBh
bmQgczM5MAo+IHdlcmUgc3R1cGlkbHkgd3JvbmcgaW4gdGhlIHYxKSwgYmVjYXVzZSBhIGdvb2Qg
czM5MCBwYXRjaCBpcyBub3QgeWV0Cj4gZGVjaWRlZCAtIEdlcmFsZCBTY2hhZWZlciBhbmQgSSBh
cmUgY3VycmVudGx5IHdvcmtpbmcgb24gdGhhdCwgb24gdGhlCj4gczM5MCBsaXN0IChJIHRvb2sg
b2ZmIG1vc3QgQ2NzIHVudGlsIHdlIGFyZSBzZXR0bGVkIGFuZCBJIGNhbiBwb3N0IHYyKS4KPgo+
IEFzIHlvdSBoYXZlIG5vIGRvdWJ0IGZvdW5kIHlvdXJzZWxmLCBzMzkwIGhhcyBzb3BoaXN0aWNh
dGVkIGhhbmRsaW5nIG9mCj4gZnJlZSBoYWxmLXBhZ2VzIGFscmVhZHksIGFuZCBJIG5lZWQgdG8g
YWRkIHJjdV9oZWFkIHVzYWdlIGluIHRoZXJlIHRvbzoKPiBpdCdzIHRyaWNreSB0byBzcXVlZXpl
IGl0IGFsbCBpbiwgYW5kIHB0ZGVzYyBkb2VzIG5vdCBhcHBlYXIgdG8gaGVscCB1cwo+IGluIGFu
eSB3YXkgKHRob3VnaCBtb3N0bHkgaXQncyBqdXN0IGNoYW5naW5nIHNvbWUgZmllbGQgbmFtZXMs
IG9rYXkpLgo+Cj4gSWYgcHRkZXNjIHdlcmUgYWN0dWFsbHkgYWxsb3dpbmcgYSBmbGV4aWJsZSBz
dHJ1Y3R1cmUgd2hpY2ggYXJjaGl0ZWN0dXJlcwo+IGNvdWxkIGFkZCBpbnRvLCB0aGF0IHdvdWxk
IChpbiBzb21lIGZ1dHVyZSkgYmUgbmljZTsgYnV0IG9mIGNvdXJzZSBhdAo+IHByZXNlbnQgaXQn
cyBzdGlsbCBmaXR0aW5nIGl0IGFsbCBpbnRvIG9uZSBzdHJ1Y3QgcGFnZSwgYW5kIG1hbmRhdGlu
Zwo+IG5ldyByZXN0cmljdGlvbnMgd2hpY2gganVzdCBtYWtlIGFuIGFyY2hpdGVjdHVyZSdzIGpv
YiBoYXJkZXIuCgpBIGdvYWwgb2YgcHRkZXNjcyBpcyB0byBtYWtlIGFyY2hpdGVjdHVyZSdzIGpv
YnMgc2ltcGxlciBhbmQgc3RhbmRhcmRpemVkLgpVbmZvcnR1bmF0ZWx5LCBwdGRlc2NzIGFyZSBu
b3doZXJlIG5lYXIgaXNvbGF0ZWQgZnJvbSBzdHJ1Y3QgcGFnZSB5ZXQuClRoaXMgdmVyc2lvbiBv
ZiBzdHJ1Y3QgcHRkZXNjIGNvbnRhaW5zIHRoZSBleGFjdCBudW1iZXIgb2YgZmllbGRzIGFyY2hp
dGVjdHVyZXMKbmVlZCByaWdodCBub3csIGp1c3QgcmVvcmdhbml6ZWQgdG8gYmUgbG9jYXRlZCBu
ZXh0IHRvIGVhY2ggb3RoZXIuIEl0ICpwcm9iYWJseSoKc2hvdWxkbid0IG1ha2UgYW4gYXJjaGl0
ZWN0dXJlcyBqb2IgaGFyZGVyLCBhc2lkZSBmcm9tIGRpc2NvdXJhZ2luZyB0aGVpciB1c2UKb2Yg
eWV0IGV2ZW4gbW9yZSBtZW1iZXJzIG9mIHN0cnVjdCBwYWdlLgoKPiBTb21lIG5vdGVzIG9uIHBy
b2JsZW1hdGljIGZpZWxkcyBiZWxvdyBGWUkuCj4KPiA+IC0tLQo+ID4gIGluY2x1ZGUvbGludXgv
cGd0YWJsZS5oIHwgNTEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysK
PiA+ICAxIGZpbGUgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L3BndGFibGUuaCBiL2luY2x1ZGUvbGludXgvcGd0YWJsZS5oCj4gPiBp
bmRleCBjNWE1MTQ4MWJiYjkuLjMzMGRlOTZlYmZkNiAxMDA2NDQKPiA+IC0tLSBhL2luY2x1ZGUv
bGludXgvcGd0YWJsZS5oCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3BndGFibGUuaAo+ID4gQEAg
LTk3NSw2ICs5NzUsNTcgQEAgc3RhdGljIGlubGluZSB2b2lkIHB0ZXBfbW9kaWZ5X3Byb3RfY29t
bWl0KHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLAo+ID4gICNlbmRpZiAvKiBfX0hBVkVfQVJD
SF9QVEVQX01PRElGWV9QUk9UX1RSQU5TQUNUSU9OICovCj4gPiAgI2VuZGlmIC8qIENPTkZJR19N
TVUgKi8KPiA+Cj4gPiArCj4gPiArLyoqCj4gPiArICogc3RydWN0IHB0ZGVzYyAtIE1lbW9yeSBk
ZXNjcmlwdG9yIGZvciBwYWdlIHRhYmxlcy4KPiA+ICsgKiBAX19wYWdlX2ZsYWdzOiBTYW1lIGFz
IHBhZ2UgZmxhZ3MuIFVudXNlZCBmb3IgcGFnZSB0YWJsZXMuCj4gPiArICogQHB0X2xpc3Q6IExp
c3Qgb2YgdXNlZCBwYWdlIHRhYmxlcy4gVXNlZCBmb3IgczM5MCBhbmQgeDg2Lgo+ID4gKyAqIEBf
cHRfcGFkXzE6IFBhZGRpbmcgdGhhdCBhbGlhc2VzIHdpdGggcGFnZSdzIGNvbXBvdW5kIGhlYWQu
Cj4gPiArICogQHBtZF9odWdlX3B0ZTogUHJvdGVjdGVkIGJ5IHB0ZGVzYy0+cHRsLCB1c2VkIGZv
ciBUSFBzLgo+ID4gKyAqIEBfcHRfczM5MF9nYWRkcjogQWxpYXNlcyB3aXRoIHBhZ2UncyBtYXBw
aW5nLiBVc2VkIGZvciBzMzkwIGdtYXAgb25seS4KPiA+ICsgKiBAcHRfbW06IFVzZWQgZm9yIHg4
NiBwZ2RzLgo+ID4gKyAqIEBwdF9mcmFnX3JlZmNvdW50OiBGb3IgZnJhZ21lbnRlZCBwYWdlIHRh
YmxlIHRyYWNraW5nLiBQb3dlcnBjIGFuZCBzMzkwIG9ubHkuCj4gPiArICogQHB0bDogTG9jayBm
b3IgdGhlIHBhZ2UgdGFibGUuCj4gPiArICoKPiA+ICsgKiBUaGlzIHN0cnVjdCBvdmVybGF5cyBz
dHJ1Y3QgcGFnZSBmb3Igbm93LiBEbyBub3QgbW9kaWZ5IHdpdGhvdXQgYSBnb29kCj4gPiArICog
dW5kZXJzdGFuZGluZyBvZiB0aGUgaXNzdWVzLgo+ID4gKyAqLwo+ID4gK3N0cnVjdCBwdGRlc2Mg
ewo+ID4gKyAgICAgdW5zaWduZWQgbG9uZyBfX3BhZ2VfZmxhZ3M7Cj4gPiArCj4gPiArICAgICB1
bmlvbiB7Cj4gPiArICAgICAgICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgcHRfbGlzdDsKPgo+IEkg
c2hhbGwgYmUgbmVlZGluZyBzdHJ1Y3QgcmN1X2hlYWQgcmN1X2hlYWQgKG9yIHB0X3JjdV9oZWFk
IG9yIHdoYXRldmVyLAo+IGlmIHlvdSBwcmVmZXIpIGluIHRoaXMgdW5pb24gdG9vLiAgU2hhcmlu
ZyB0aGUgbHJ1IG9yIHB0X2xpc3Qgd2l0aCByY3VfaGVhZAo+IGlzIHdoYXQncyBkaWZmaWN1bHQg
dG8gZ2V0IHJpZ2h0IGFuZCBlZmZpY2llbnQgb24gczM5MCAtIGFuZCBpZiBwdGRlc2MgZ2F2ZQo+
IHVzIGFuIGluZGVwZW5kZW50IHJjdV9oZWFkIGZvciBlYWNoIHBhZ2UgdGFibGUsIHRoYXQgd291
bGQgYmUgYSBibGVzc2luZyEKPiBidXQgc2FkbHkgbm90LCBpdCBzdGlsbCBoYXMgdG8gc3F1ZWV6
ZSBpbnRvIGEgc3RydWN0IHBhZ2UuCgpJIGNhbiBhZGQgYSBwdF9yY3VfaGVhZCBhbG9uZyB3aXRo
IGEgY29tbWVudCB0byBkZXRlciBhbGlhc2luZyBpc3N1ZXMgOikKSW5kZXBlbmRlbnQgcmN1X2hl
YWRzIGFyZW4ndCBjb21pbmcgYW55IHRpbWUgc29vbiB0aG91Z2ggOigKCj4gPiArICAgICAgICAg
ICAgIHN0cnVjdCB7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBfcHRf
cGFkXzE7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgcGd0YWJsZV90IHBtZF9odWdlX3B0ZTsK
PiA+ICsgICAgICAgICAgICAgfTsKPiA+ICsgICAgIH07Cj4gPiArICAgICB1bnNpZ25lZCBsb25n
IF9wdF9zMzkwX2dhZGRyOwo+ID4gKwo+ID4gKyAgICAgdW5pb24gewo+ID4gKyAgICAgICAgICAg
ICBzdHJ1Y3QgbW1fc3RydWN0ICpwdF9tbTsKPiA+ICsgICAgICAgICAgICAgYXRvbWljX3QgcHRf
ZnJhZ19yZWZjb3VudDsKPgo+IFdoZXRoZXIgczM5MCB3aWxsIHdhbnQgcHRfbW0gaXMgbm90IHll
dCBkZWNpZGVkOiBJIHdhbnQgdG8gdXNlIGl0LAo+IEdlcmFsZCBwcmVmZXJzIHRvIGdvIHdpdGhv
dXQgaXQ7IGJ1dCBpZiB3ZSBkbyBlbmQgdXAgdXNpbmcgaXQsCj4gdGhlbiBwdF9mcmFnX3JlZmNv
dW50IGlzIGEgbHV4dXJ5IHdlIHdvdWxkIGhhdmUgdG8gZ2l2ZSB1cC4KCkkgZG9uJ3QgbGlrZSB0
aGUgdXNlIG9mIHB0X21tIGZvciBzMzkwIGVpdGhlci4gczM5MCB1c2VzIHNwYWNlIGVxdWl2YWxl
bnQKdG8gYWxsIGZpdmUgd29yZHMgYWxsb2NhdGVkIGluIHRoZSBwYWdlIHRhYmxlIHN0cnVjdCAo
YWxiZWl0IGluIHZhcmlvdXMgcGxhY2VzCm9mIHN0cnVjdCBwYWdlKS4gVXNpbmcgZXh0cmEgc3Bh
Y2UgKGVzcGVjaWFsbHkgYWxsb2NhdGVkIGZvciB1bnJlbGF0ZWQKcmVhc29ucykganVzdCBiZWNh
dXNlIGl0IGV4aXN0cyBtYWtlcyB0aGluZ3MgbW9yZSBjb21wbGljYXRlZCBhbmQKY29uZnVzaW5n
LCBhbmQgczM5MCBpcyBhbHJlYWR5IGNvbmZ1c2luZyBlbm91Z2ggYXMgYSByZXN1bHQgb2YgdGhh
dC4KCklmIGhhdmluZyBhY2Nlc3MgdG8gcHRfbW0gaXMgbmVjZXNzYXJ5IEkgY2FuIGRyb3AgdGhl
CnB0X2ZyYWdfcmVmY291bnQgcGF0Y2gsIGJ1dCBJJ2QgcmF0aGVyIGF2b2lkIGl0LgoKPiBzMzkw
IGRvZXMgdmVyeSB3ZWxsIGFscmVhZHkgd2l0aCBpdHMgX3JlZmNvdW50IHRyaWNrcywgYW5kIEkn
ZCBleHBlY3QKPiBwb3dlcnBjJ3Mgc2ltcGxlciBidXQgbW9yZSB3YXN0ZWZ1bCBpbXBsZW1lbnRh
dGlvbiB0byB3b3JrIGFzIHdlbGwKPiB3aXRoIF9yZWZjb3VudCB0b28gLSBJIGtub3cgdGhhdCBh
IGZldyB5ZWFycyBiYWNrLCBwb3dlcnBjIGRpZCBtaXN1c2UKPiBfcmVmY291bnQgKGl0IGRpZCBu
b3QgYWxsb3cgZm9yIHNwZWN1bGF0aXZlIGFjY2Vzc2VzLCB0aG91Z2h0IGl0IGhhZAo+IHNvbGUg
b3duZXJzaGlwIG9mIHRoYXQgZmllbGQpOyBidXQgczM5MCBjb3BlcyB3ZWxsIHdpdGggdGhhdCwg
YW5kIEkKPiBleHBlY3QgcG93ZXJwYyBjYW4gZG8gc28gdG9vLCB3aXRob3V0IHRoZSBsdXh1cnkg
b2YgcHRfZnJhZ19yZWZjb3VudC4KPgo+IEJ1dCBJJ3ZlIG5vIGRlc2lyZSB0byB1bmRvIHBvd2Vy
cGMncyB1c2Ugb2YgcHRfZnJhZ19yZWZjb3VudDoKPiBqdXN0IHdhcm5pbmcgdGhhdCB3ZSBtYXkg
d2FudCB0byB1bmRvIGFueSB1c2Ugb2YgaXQgaW4gczM5MC4KPgo+IEkgdGhvdWdodCBJIGhhZCBt
b3JlIGlzc3VlcyB0byBtZW50aW9uLCBwcm9iYWJseSBHZXJhbGQgd2lsbAo+IHJlbWluZCBtZSBv
ZiBhIHdob2xlIG5ldyB1bmV4cGxvcmVkIGRpbWVuc2lvbiEgZ21hcCBwZXJoYXBzLgo+Cj4gSHVn
aAo+Cj4gPiArICAgICB9Owo+ID4gKwo+ID4gKyNpZiBBTExPQ19TUExJVF9QVExPQ0tTCj4gPiAr
ICAgICBzcGlubG9ja190ICpwdGw7Cj4gPiArI2Vsc2UKPiA+ICsgICAgIHNwaW5sb2NrX3QgcHRs
Owo+ID4gKyNlbmRpZgo+ID4gK307Cj4gPiArCj4gPiArI2RlZmluZSBUQUJMRV9NQVRDSChwZywg
cHQpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAo+ID4gKyAgICAg
c3RhdGljX2Fzc2VydChvZmZzZXRvZihzdHJ1Y3QgcGFnZSwgcGcpID09IG9mZnNldG9mKHN0cnVj
dCBwdGRlc2MsIHB0KSkKPiA+ICtUQUJMRV9NQVRDSChmbGFncywgX19wYWdlX2ZsYWdzKTsKPiA+
ICtUQUJMRV9NQVRDSChjb21wb3VuZF9oZWFkLCBwdF9saXN0KTsKPiA+ICtUQUJMRV9NQVRDSChj
b21wb3VuZF9oZWFkLCBfcHRfcGFkXzEpOwo+ID4gK1RBQkxFX01BVENIKHBtZF9odWdlX3B0ZSwg
cG1kX2h1Z2VfcHRlKTsKPiA+ICtUQUJMRV9NQVRDSChtYXBwaW5nLCBfcHRfczM5MF9nYWRkcik7
Cj4gPiArVEFCTEVfTUFUQ0gocHRfbW0sIHB0X21tKTsKPiA+ICtUQUJMRV9NQVRDSChwdGwsIHB0
bCk7Cj4gPiArI3VuZGVmIFRBQkxFX01BVENICj4gPiArc3RhdGljX2Fzc2VydChzaXplb2Yoc3Ry
dWN0IHB0ZGVzYykgPD0gc2l6ZW9mKHN0cnVjdCBwYWdlKSk7Cj4gPiArCj4gPiAgLyoKPiA+ICAg
KiBOby1vcCBtYWNyb3MgdGhhdCBqdXN0IHJldHVybiB0aGUgY3VycmVudCBwcm90ZWN0aW9uIHZh
bHVlLiBEZWZpbmVkIGhlcmUKPiA+ICAgKiBiZWNhdXNlIHRoZXNlIG1hY3JvcyBjYW4gYmUgdXNl
ZCBldmVuIGlmIENPTkZJR19NTVUgaXMgbm90IGRlZmluZWQuCj4gPiAtLQo+ID4gMi40MC4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBt
YWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
