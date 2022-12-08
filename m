Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24776C4332F
	for <linux-um@archiver.kernel.org>; Thu,  8 Dec 2022 08:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:Subject:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OCsZxBi3pvwIJGYhbBkzNroTkIZS108aXxQYwXuV6NU=; b=TZ6tS/5lQDKGMT
	2LYzTD880upD+vH10GNoHXvVwf3Dn2tqeqMJVR7Yw2dY/8YsW+1Xo0LwvQvbr6q4hQxECPbcFe3CI
	GnNXJ2RZYpEknMwfdJk1I7xZllUe/XNuUlnl8J3gsDAr6KfKNYhNSYYthhiqKhXK3cNliFP6c4YKb
	rnf2a1EM98zaA464kQJYTjnkLLLkG6cd+fOEC3rKK17b/by35TrhjfQKA0pVW9+36esvyr0/7Ndbr
	PHhNWKJlbmd+HDvGsx0MDTtjD46QgchaTqRjlg0f7nNysaVNdJRVxQ/c2ai05HpqrNSwIchSz4BSx
	3bcLzT9PyBsb2VEoXiOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3CjF-00ATFB-0Z; Thu, 08 Dec 2022 08:58:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3CeR-00AOej-Ky
	for linux-um@lists.infradead.org; Thu, 08 Dec 2022 08:53:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670489582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WtVANh0eBS7cuUnAJkHyLAHfwCxkRrG12+slAtG+/Kc=;
	b=OLICTvYRAWvZClShRUAIwD9mWbKVNaKMOB8J9S+fnVKvTFPyAa8mca61v0jvrn2pNrgplw
	esCvIowYvc4M7IljieXbhfyoYPG0fxXHUWHmOSSvNGmbG8YL1adq+9tzuEJbcudSURHbnV
	lVWjNrKKcKHlaIIMUGRrq/NaSERw2FE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-47-lW5YHqXrOT6bygInVns-rA-1; Thu, 08 Dec 2022 03:53:01 -0500
X-MC-Unique: lW5YHqXrOT6bygInVns-rA-1
Received: by mail-wm1-f72.google.com with SMTP id h9-20020a1c2109000000b003cfd37aec58so514607wmh.1
        for <linux-um@lists.infradead.org>; Thu, 08 Dec 2022 00:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WtVANh0eBS7cuUnAJkHyLAHfwCxkRrG12+slAtG+/Kc=;
        b=u9lR7awP/9XybBDdfqwv4+IlisEPCXahiuvKWMLL7GkR/7ySvCH6axGoNrpK/uHlV6
         /OLkGF50Zg80U/nHlixMX4wvuc3pl+jDZFFho3E46kj5Zl6yzqwlArMbTofrrunpedqE
         A1FRMKz9ghR0tl6NSsUIT5nX3e2IgQ3Y+32Mn51gJQbjWRbEPPFoQcCnZ707iQOGE67T
         6kWoFozRRvEjN5S3Kc4RMgzF2Oezt/GS6zCLyOEuWfLZtPbxDh8KSiYTLk/ISM0QHYIt
         OcRTMojXzi/WcF0FA5Q2loEddZkrAgOCWWRq9mrt34Sl1lYXAD0Df+oMnAFKTDhIkfEM
         s6fw==
X-Gm-Message-State: ANoB5plFNXiaB2e2+Y6ogM7ePaWhckoHGSH8gbof4MOUl+z8s2aWh6Ku
	QfIlnhgY8a51km99Zw1XMQsHenC1VFZ7fkVeZBqvZQcDrLaSaaIYyzSCtoXDIlOA5Ykfpw/xY9L
	IcRCgwJokcI7TaQu1MeELRXNc
X-Received: by 2002:a7b:c3d3:0:b0:3d1:cec6:75a8 with SMTP id t19-20020a7bc3d3000000b003d1cec675a8mr10610859wmj.206.1670489580100;
        Thu, 08 Dec 2022 00:53:00 -0800 (PST)
X-Google-Smtp-Source: AA0mqf43lyCBCnse73L4nmQgwKX2lVPb0zDtRkTV00eD7UM2rHA9mTsLvJ7fK1IaCMRkleIpPTdzzg==
X-Received: by 2002:a7b:c3d3:0:b0:3d1:cec6:75a8 with SMTP id t19-20020a7bc3d3000000b003d1cec675a8mr10610851wmj.206.1670489579743;
        Thu, 08 Dec 2022 00:52:59 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id h1-20020a05600c350100b003a2f2bb72d5sm5810986wmq.45.2022.12.08.00.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 00:52:59 -0800 (PST)
Message-ID: <0b5b1303-8bcb-c19d-5f63-0e4a3517fea5@redhat.com>
Date: Thu, 8 Dec 2022 09:52:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@linux.ibm.com>,
 Yang Shi <shy828301@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
 Nadav Amit <namit@vmware.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Peter Xu <peterx@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
References: <20221206144730.163732-1-david@redhat.com>
 <20221206144730.163732-18-david@redhat.com>
 <8be167b6-3836-25c3-9f69-b8b3916ee5b4@csgroup.eu>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH mm-unstable RFC 17/26] powerpc/mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 32bit book3s
In-Reply-To: <8be167b6-3836-25c3-9f69-b8b3916ee5b4@csgroup.eu>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221208_005307_810318_4F5A2D50 
X-CRM114-Status: GOOD (  16.68  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

T24gMDcuMTIuMjIgMTQ6NTUsIENocmlzdG9waGUgTGVyb3kgd3JvdGU6Cj4gCj4gCj4gTGUgMDYv
MTIvMjAyMiDDoCAxNTo0NywgRGF2aWQgSGlsZGVuYnJhbmQgYSDDqWNyaXTCoDoKPj4gV2UgYWxy
ZWFkeSBpbXBsZW1lbnRlZCBzdXBwb3J0IGZvciA2NGJpdCBib29rM3MgaW4gY29tbWl0IGJmZjli
ZWFhMmU4MAo+PiAoInBvd2VycGMvcGd0YWJsZTogc3VwcG9ydCBfX0hBVkVfQVJDSF9QVEVfU1dQ
X0VYQ0xVU0lWRSBmb3IgYm9vazNzIikKPj4KPj4gTGV0J3Mgc3VwcG9ydCBfX0hBVkVfQVJDSF9Q
VEVfU1dQX0VYQ0xVU0lWRSBhbHNvIGluIDMyYml0IGJ5IHJldXNpbmcgeWV0Cj4+IHVudXNlZCBM
U0IgMiAvIE1TQiAyOS4gVGhlcmUgc2VlbXMgdG8gYmUgbm8gcmVhbCByZWFzb24gd2h5IHRoYXQg
Yml0IGNhbm5vdAo+PiBiZSB1c2VkLCBhbmQgcmV1c2luZyBpdCBhdm9pZHMgaGF2aW5nIHRvIHN0
ZWFsIG9uZSBiaXQgZnJvbSB0aGUgc3dhcAo+PiBvZmZzZXQuCj4+Cj4+IFdoaWxlIGF0IGl0LCBt
YXNrIHRoZSB0eXBlIGluIF9fc3dwX2VudHJ5KCkuCj4+Cj4+IENjOiBNaWNoYWVsIEVsbGVybWFu
IDxtcGVAZWxsZXJtYW4uaWQuYXU+Cj4+IENjOiBOaWNob2xhcyBQaWdnaW4gPG5waWdnaW5AZ21h
aWwuY29tPgo+PiBDYzogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3Vw
LmV1Pgo+PiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNv
bT4KPj4gLS0tCj4+ICAgIGFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9ib29rM3MvMzIvcGd0YWJs
ZS5oIHwgMzggKysrKysrKysrKysrKysrKystLS0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDMzIGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2Vy
cGMvaW5jbHVkZS9hc20vYm9vazNzLzMyL3BndGFibGUuaCBiL2FyY2gvcG93ZXJwYy9pbmNsdWRl
L2FzbS9ib29rM3MvMzIvcGd0YWJsZS5oCj4+IGluZGV4IDc1ODIzZjM5ZTA0Mi4uODEwNzgzNWIz
OGMxIDEwMDY0NAo+PiAtLS0gYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzMyL3Bn
dGFibGUuaAo+PiArKysgYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzMyL3BndGFi
bGUuaAo+PiBAQCAtNDIsNiArNDIsOSBAQAo+PiAgICAjZGVmaW5lIF9QTURfUFJFU0VOVF9NQVNL
IChQQUdFX01BU0spCj4+ICAgICNkZWZpbmUgX1BNRF9CQUQJKH5QQUdFX01BU0spCj4+ICAgIAo+
PiArLyogV2UgYm9ycm93IHRoZSBfUEFHRV9VU0VSIGJpdCB0byBzdG9yZSB0aGUgZXhjbHVzaXZl
IG1hcmtlciBpbiBzd2FwIFBURXMuICovCj4+ICsjZGVmaW5lIF9QQUdFX1NXUF9FWENMVVNJVkUJ
X1BBR0VfVVNFUgo+PiArCj4+ICAgIC8qIEFuZCBoZXJlIHdlIGluY2x1ZGUgY29tbW9uIGRlZmlu
aXRpb25zICovCj4+ICAgIAo+PiAgICAjZGVmaW5lIF9QQUdFX0tFUk5FTF9STwkJMAo+PiBAQCAt
MzYzLDE3ICszNjYsNDIgQEAgc3RhdGljIGlubGluZSB2b2lkIF9fcHRlcF9zZXRfYWNjZXNzX2Zs
YWdzKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLAo+PiAgICAjZGVmaW5lIHBtZF9wYWdlKHBt
ZCkJCXBmbl90b19wYWdlKHBtZF9wZm4ocG1kKSkKPj4gICAgCj4+ICAgIC8qCj4+IC0gKiBFbmNv
ZGUgYW5kIGRlY29kZSBhIHN3YXAgZW50cnkuCj4+IC0gKiBOb3RlIHRoYXQgdGhlIGJpdHMgd2Ug
dXNlIGluIGEgUFRFIGZvciByZXByZXNlbnRpbmcgYSBzd2FwIGVudHJ5Cj4+IC0gKiBtdXN0IG5v
dCBpbmNsdWRlIHRoZSBfUEFHRV9QUkVTRU5UIGJpdCBvciB0aGUgX1BBR0VfSEFTSFBURSBiaXQg
KGlmIHVzZWQpLgo+PiAtICogICAtLSBwYXVsdXMKPj4gKyAqIEVuY29kZS9kZWNvZGUgc3dhcCBl
bnRyaWVzIGFuZCBzd2FwIFBURXMuIFN3YXAgUFRFcyBhcmUgYWxsIFBURXMgdGhhdAo+PiArICog
YXJlICFwdGVfbm9uZSgpICYmICFwdGVfcHJlc2VudCgpLgo+PiArICoKPj4gKyAqIEZvcm1hdCBv
ZiBzd2FwIFBURXMgKDMyYml0IFBURXMpOgo+PiArICoKPj4gKyAqICAgICAgICAgICAgICAgICAg
ICAgICAgIDEgMSAxIDEgMSAxIDEgMSAxIDIgMiAyIDIgMiAyIDIgMiAyIDIgMyAzCj4+ICsgKiAg
IDAgMSAyIDMgNCA1IDYgNyA4IDkgMCAxIDIgMyA0IDUgNiA3IDggOSAwIDEgMiAzIDQgNSA2IDcg
OCA5IDAgMQo+PiArICogICBFIEggUCA8LSB0eXBlIC0tPiA8LS0tLS0tLS0tLS0tLS0tLS0gb2Zm
c2V0IC0tLS0tLS0tLS0tLS0tLS0tLT4KPiAKPiBUaGF0J3MgaW4gcmV2ZXJzZWQgb3JkZXIuIF9Q
QUdFX0hBU0hQVEUgaXMgYml0IDMwIGFuZCBzaG91bGQgYmUgb24gdGhlCj4gcmlnaHQgaGFuZCBz
aWRlLiBFdGMgLi4uCgpVZ2gsIG1lc3NlZCBpdCB1cCB3aGlsZSBjb252ZXJ0aW5nIGJhY2sgYW5k
IGZvcnRoIGJldHdlZW4gTFNCIDAgYW5kIE1TQiAwLgoKLyoKICAqIEZvcm1hdCBvZiBzd2FwIFBU
RXMgKDMyYml0IFBURXMpOgogICoKICAqICAgICAgICAgICAgICAgICAgICAgICAgIDEgMSAxIDEg
MSAxIDEgMSAxIDIgMiAyIDIgMiAyIDIgMiAyIDIgMyAzCiAgKiAgIDAgMSAyIDMgNCA1IDYgNyA4
IDkgMCAxIDIgMyA0IDUgNiA3IDggOSAwIDEgMiAzIDQgNSA2IDcgOCA5IDAgMQogICogICA8LS0t
LS0tLS0tLS0tLS0tLS0gb2Zmc2V0IC0tLS0tLS0tLS0tLS0tLS0tLT4gPC0gdHlwZSAtLT4gRSBI
IFAKCgpOb3cgdGhlIHBhdGNoIGRlc2NyaXB0aW9uICgidW51c2VkIExTQiAyIC8gTVNCIDI5Iikg
bWFrZXMgc2Vuc2UuCgpUaGFua3MhCgpBbnkgZmVlZGJhY2sgaWYgdGhlIGJpdCBjb3VsZCBiZSBw
cm9ibGVtYXRpYz8KCi0tIApUaGFua3MsCgpEYXZpZCAvIGRoaWxkZW5iCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0
CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
