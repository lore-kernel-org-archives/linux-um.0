Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B61AC77B75
	for <linux-um@archiver.kernel.org>; Tue, 18 Apr 2023 21:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GuoQC/T0uSKUc0XyPTceUix+zOzNYYHx1i6r6ha8M7s=; b=RluRymjmvt0Lqz
	3wJVTj2zbx9FRrxT3yVERXE0sBycc813eNS7tLRh844wylqcNvmbwZ62PI1WsSZ4B6c1FqkMIwR+2
	bg3SLFBe1vhU5Ce6AfsA67Ik84Zez6DexuPOoYDwfe2ESeIw1LH4xSI3SAJiBIuNrbantlL5YRF5B
	eb6cyqB7bc/aN4jHWbNbE1Gs1u2ZTTUpOP7ZOiEN9QVX6G1QcvbdIL7VdJXg8J3/AlHS2qd7zsrCq
	iS8t6m5x3FjbYITjnUCuVsP+yKfe/7t/oI8fwhljepfXsPFhWszgu+jDHm4XjHw6zcyE0ZvWAeOCx
	2FWOflnVheoQQalxVswQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1posx3-003OS5-0g;
	Tue, 18 Apr 2023 21:33:25 +0000
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poswy-003OPy-1V;
	Tue, 18 Apr 2023 21:33:22 +0000
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fe3cd445aso170378217b3.5;
        Tue, 18 Apr 2023 14:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681853598; x=1684445598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZ+faik75720SnLDzvntxl1cmAaRHsLQ7oOmPoVPf3o=;
        b=fBPSS93aalbav0LUzUejRt2NjbHpBJmNsHVPRRbsF+jG5Nu8WjfWT+weSiXFGrkEbN
         Bl+EcMNC7lpcawm/MuwqggHfJmNk7zAK9haLpnJV08P367c5YohyB4lPm9ubYCuINJZG
         pmhBTFu6UKlSFmyU0QWGBEDpdg/7xojdmyIrq4CWcHgeoPLavovDZAMaCmQm5Tmi+PdF
         awAr9pJ9qRfL4qAoU/GIaaVF0Yb/A9oc1EXdyleFSucNiyAMBSWiFjcubi/Cl7MqSDQT
         LqfYl5LxNuy3TqKDTGZky+Cx6fyOI9+XqrTm2mW88NG+xvACaI/puCphU95FqO3MwFDd
         on2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681853598; x=1684445598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZ+faik75720SnLDzvntxl1cmAaRHsLQ7oOmPoVPf3o=;
        b=Ak3rfdx26bRn5U5zp1xErYOJ1yT5kV0xEC7xAQjACCbIM3WBBtoCainoXsc0PPPj9O
         NCzI+Qwx184kWvkdM+66EGUUS0mCiW11islZ4/CvYfMG2/yxUo1yzdYHw68NXwtZ9D5B
         Wx3e2d+wJElTlv4vMRH+sxCCem180bN4F7xqvaSya7BmHIdlFPFhyqEgdJqEiT+moAaU
         uT5CZiIJz5aVYPkqkRaF8WwOMIxWjVWkRSpR+0SWua3hsujox8zgazERfB3O9ojR24EQ
         bHYo4eVecijlXy0kwai1EXPJiUzt4d/0vo1wZjQiUFMWGJuH9lph4fHWwvCqStcsa2KL
         GQhA==
X-Gm-Message-State: AAQBX9calCaxQ+q469DCejapBiZVRWnMrlszN87WBnG5ZqSsKh2uDEeQ
	f2cp5BOYS1SJvqocXSBdiuA+2DrazKKsq9TYVDP+7sEVy4jJkQ==
X-Google-Smtp-Source: AKy350Zg9/w1pIq1h9Mfl98gkIvdjlXYVLE/yxlCrmuaudFEJKPjKGaCNnj1KVCOnrcLYZjlnD0Q2KC4cnvL5HhzBhY=
X-Received: by 2002:a81:8443:0:b0:54f:8af3:6488 with SMTP id
 u64-20020a818443000000b0054f8af36488mr1215032ywf.23.1681853598073; Tue, 18
 Apr 2023 14:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230417205048.15870-1-vishal.moola@gmail.com>
 <20230417205048.15870-2-vishal.moola@gmail.com> <da600570-51c7-8088-b46b-7524c9e66e5d@redhat.com>
In-Reply-To: <da600570-51c7-8088-b46b-7524c9e66e5d@redhat.com>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Tue, 18 Apr 2023 14:33:06 -0700
Message-ID: <CAOzc2pwpRhNoFbdzdzuvrqbZdf2OsrTvBGs40QCZJjA5fS_q1A@mail.gmail.com>
Subject: Re: [PATCH 01/33] s390: Use _pt_s390_gaddr for gmap address tracking
To: David Hildenbrand <david@redhat.com>
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
X-CRM114-CacheID: sfid-20230418_143320_511468_F7AC30A2 
X-CRM114-Status: GOOD (  21.99  )
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

T24gVHVlLCBBcHIgMTgsIDIwMjMgYXQgODo0NeKAr0FNIERhdmlkIEhpbGRlbmJyYW5kIDxkYXZp
ZEByZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIDE3LjA0LjIzIDIyOjUwLCBWaXNoYWwgTW9vbGEg
KE9yYWNsZSkgd3JvdGU6Cj4gPiBzMzkwIHVzZXMgcGFnZS0+aW5kZXggdG8ga2VlcCB0cmFjayBv
ZiBwYWdlIHRhYmxlcyBmb3IgdGhlIGd1ZXN0IGFkZHJlc3MKPiA+IHNwYWNlLiBJbiBhbiBhdHRl
bXB0IHRvIGNvbnNvbGlkYXRlIHRoZSB1c2FnZSBvZiBwYWdlIGZpZWxkcyBpbiBzMzkwLAo+ID4g
cmVwbGFjZSBfcHRfcGFkXzIgd2l0aCBfcHRfczM5MF9nYWRkciB0byByZXBsYWNlIHBhZ2UtPmlu
ZGV4IGluIGdtYXAuCj4gPgo+ID4gVGhpcyB3aWxsIGhlbHAgd2l0aCB0aGUgc3BsaXR0aW5nIG9m
IHN0cnVjdCBwdGRlc2MgZnJvbSBzdHJ1Y3QgcGFnZSwgYXMKPiA+IHdlbGwgYXMgYWxsb3cgczM5
MCB0byB1c2UgX3B0X2ZyYWdfcmVmY291bnQgZm9yIGZyYWdtZW50ZWQgcGFnZSB0YWJsZQo+ID4g
dHJhY2tpbmcuCj4gPgo+ID4gU2luY2UgcGFnZS0+X3B0X3MzOTBfZ2FkZHIgYWxpYXNlcyB3aXRo
IG1hcHBpbmcsIGVuc3VyZSBpdHMgc2V0IHRvIE5VTEwKPiA+IGJlZm9yZSBmcmVlaW5nIHRoZSBw
YWdlcyBhcyB3ZWxsLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFZpc2hhbCBNb29sYSAoT3JhY2xl
KSA8dmlzaGFsLm1vb2xhQGdtYWlsLmNvbT4KPiA+IC0tLQo+Cj4gWy4uLl0KPgo+ID4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvbW1fdHlwZXMuaCBiL2luY2x1ZGUvbGludXgvbW1fdHlwZXMu
aAo+ID4gaW5kZXggM2ZjOWU2ODBmMTc0Li4yNjE2ZDY0YzBlOGMgMTAwNjQ0Cj4gPiAtLS0gYS9p
bmNsdWRlL2xpbnV4L21tX3R5cGVzLmgKPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvbW1fdHlwZXMu
aAo+ID4gQEAgLTE0NCw3ICsxNDQsNyBAQCBzdHJ1Y3QgcGFnZSB7Cj4gPiAgICAgICAgICAgICAg
IHN0cnVjdCB7ICAgICAgICAvKiBQYWdlIHRhYmxlIHBhZ2VzICovCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgdW5zaWduZWQgbG9uZyBfcHRfcGFkXzE7ICAgICAgICAvKiBjb21wb3VuZF9oZWFk
ICovCj4gPiAgICAgICAgICAgICAgICAgICAgICAgcGd0YWJsZV90IHBtZF9odWdlX3B0ZTsgLyog
cHJvdGVjdGVkIGJ5IHBhZ2UtPnB0bCAqLwo+ID4gLSAgICAgICAgICAgICAgICAgICAgIHVuc2ln
bmVkIGxvbmcgX3B0X3BhZF8yOyAgICAgICAgLyogbWFwcGluZyAqLwo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgIHVuc2lnbmVkIGxvbmcgX3B0X3MzOTBfZ2FkZHI7ICAgLyogbWFwcGluZyAqLwo+
ID4gICAgICAgICAgICAgICAgICAgICAgIHVuaW9uIHsKPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCBtbV9zdHJ1Y3QgKnB0X21tOyAvKiB4ODYgcGdkcyBvbmx5ICovCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhdG9taWNfdCBwdF9mcmFnX3JlZmNvdW50
OyAvKiBwb3dlcnBjICovCj4KPiBUaGUgY29uZnVzaW5nIHBhcnQgaXMsIHRoYXQgdGhlc2UgZ21h
cCBwYWdlIHRhYmxlcyBhcmUgbm90IG9yZGluYXJ5Cj4gcHJvY2VzcyBwYWdlIHRhYmxlcyB0aGF0
IHdlIHdvdWxkIG9yZGluYXJpbHkgcGxhY2UgaW50byB0aGlzIHNlY3Rpb24KPiBoZXJlLiBUaGF0
J3Mgd2h5IHRoZXkgYXJlIGFsc28gbm90IGFsbG9jYXRlZC9mcmVlZCB1c2luZyB0aGUgdHlwaWNh
bAo+IHBhZ2UgdGFibGUgY29uc3RydWN0b3IvZGVzdHJ1Y3RvciAuLi4KCkkgaW5pdGlhbGx5IHRo
b3VnaHQgdGhlIHNhbWUsIHNvIEkgd2FzIHF1aXRlIGNvbmZ1c2VkIHdoZW4gSSBzYXcKX19nbWFw
X3NlZ21lbnRfZ2FkZHIgd2FzIHVzaW5nIHBtZF9wZ3RhYmxlX3BhZ2UoKS4KCkFsdGhvdWdoIHRo
ZXkgYXJlIG5vdCBvcmRpbmFyeSBwcm9jZXNzIHBhZ2UgdGFibGVzLCBzaW5jZSB3ZQpldmVudHVh
bGx5IHdhbnQgdG8gbW92ZSB0aGVtIG91dCBvZiBzdHJ1Y3QgcGFnZSwgSSB0aGluayBzaGlmdGlu
ZyB0aGVtCnRvIGJlIGluIHB0ZGVzY3MsIGJlaW5nIGEgbWVtb3J5IGRlc2NyaXB0b3IgZm9yIHBh
Z2UgdGFibGVzLCBtYWtlcwp0aGUgbW9zdCBzZW5zZS4KCkFub3RoZXIgb3B0aW9uIGlzIHRvIGxl
YXZlIHBtZF9wZ3RhYmxlX3BhZ2UoKSBhcyBpcyBqdXN0IGZvciB0aGlzIGNhc2UuCk9yIHdlIGNh
biByZXZlcnQgY29tbWl0IDdlMjVkZTc3YmM1ZWEgd2hpY2ggdXNlcyB0aGUgZnVuY3Rpb24gaGVy
ZQp0aGVuIGZpZ3VyZSBvdXQgd2hlcmUgdGhlc2UgZ21hcCBwYWdlcyB0YWJsZSBwYWdlcyB3aWxs
IGdvIGxhdGVyLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
