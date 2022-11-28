Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B27C433FE
	for <linux-um@archiver.kernel.org>; Mon, 28 Nov 2022 08:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xRwnNPQ4uPakKuFp8WxI+BSzU8vhcOB8zMpcZXjfHUE=; b=X0fNwgU5gFyNej
	l643Q+C9gB3zn6kVQKTl7AvwEUEcoFYF6ZHoL8NKlT2R8anaMBtF3bDiuet1id7rManxLW5qxDdn9
	MG+IKNer+t+r/Yd1W+NhjEy1fIbnyJL7uQ531nuQ9M+PIP0OFkJikxnLF/7Hc7284fQVFTJJUaiP9
	nZ36iIVER3t7McSR+UwGW/v1fNmF7NgUo4EGvxJtk3dj5/3Dl8FIrEup/aF1BDeRDRnVtK3Nl5avg
	4tfa42PYED8yJqrHedgy1wmQ2D5Q1Y/Wl2XtDBQHw7SMa8lglJ3a/eEE9o/Q21RRV3GajFD1vNR+y
	RBCYVaupxl6dbRjkF9jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozZMC-0009KI-PR; Mon, 28 Nov 2022 08:19:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozZLr-00097I-T7
	for linux-um@lists.infradead.org; Mon, 28 Nov 2022 08:19:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669623533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ueiNL/RrPlD3vRod9MDAxJpgFwmJj0Jyg8USWk7yPz8=;
	b=S+oFkjKVP3mckzd7VBbvH1QuZTZol0q9wTWffdsPiXu+2nmhjaLmPhu8ziCyV0KCioRPJI
	5JQ7Ka6QTT7w/TcDd4C3+oasgr3fATIDGVWRdSU8qp6A71RrRGJewLWoV59J4JHfMOQ3z1
	2VHUt/gcI6faTsrG8illEYtRpXcU/30=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-70-kpzA0OpRODKmP3S2TrwH8w-1; Mon, 28 Nov 2022 03:18:51 -0500
X-MC-Unique: kpzA0OpRODKmP3S2TrwH8w-1
Received: by mail-wm1-f71.google.com with SMTP id v188-20020a1cacc5000000b003cf76c4ae66so8275581wme.7
        for <linux-um@lists.infradead.org>; Mon, 28 Nov 2022 00:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ueiNL/RrPlD3vRod9MDAxJpgFwmJj0Jyg8USWk7yPz8=;
        b=JktD0PmPwXWD9vuVA9/v9rBePvWjc+L4BY9TMw3q+PQJ/IS0ldZuBnGacLxpMqkfWQ
         oX0wBlVaSOz4I3zUWv1Hno8NFoyG7HCMR2IR2Enl4jzOL6pQUFjV697d3b5cQMZVC1Xu
         IOFJ1YC8q2/gmEXeFEDIUhRJrKQx9tn/RYXW+a0gHaFxvoCcwEhAE5frTvrAmjErlJJX
         secT9PD0iOlUaZPnt5Lqc353VEHBshH69A74ZBOjzv/pQmZVFU7UYt6JcyO0im/Ehqh2
         XoXzLL2a4GHA7RM9YN6hk7FCKgBE3JEezJh09YRSHsuxv1WJdwT4BVl/1ZeBDuntK5V/
         4XKw==
X-Gm-Message-State: ANoB5pk5jQZIe3a1xwZk2tAKaIk2g7YHBK29Xb0hgvjjf/suiqQmPGGi
	cFTS1poDSZprk1aRMvlGbzuc6HZxA9Viz3H7Yd/tFjdovNyCHNVPBt2PmvjgwXrf7jnmj0GYVtW
	Lmr22dCx27KMwRbv+KXSxcy1u
X-Received: by 2002:a05:600c:3587:b0:3cf:a9c2:2b04 with SMTP id p7-20020a05600c358700b003cfa9c22b04mr36262275wmq.152.1669623530577;
        Mon, 28 Nov 2022 00:18:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5KFgnMS9OgeX6iNUgB1p0xskb3yOxviUW4FnLaUffslFm3du7Shktyf0rRUHCATZ7f+3nFJA==
X-Received: by 2002:a05:600c:3587:b0:3cf:a9c2:2b04 with SMTP id p7-20020a05600c358700b003cfa9c22b04mr36262220wmq.152.1669623530122;
        Mon, 28 Nov 2022 00:18:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:9000:3d6:e434:f8b4:80cf? (p200300cbc702900003d6e434f8b480cf.dip0.t-ipconnect.de. [2003:cb:c702:9000:3d6:e434:f8b4:80cf])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b003a2f2bb72d5sm22518102wmo.45.2022.11.28.00.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 00:18:49 -0800 (PST)
Message-ID: <9d0bf98a-3d6a-1082-e992-1338e1525935@redhat.com>
Date: Mon, 28 Nov 2022 09:18:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH mm-unstable v1 16/20] mm/frame-vector: remove FOLL_FORCE
 usage
To: Hans Verkuil <hverkuil@xs4all.nl>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrea Arcangeli <aarcange@redhat.com>,
 Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
 Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <songmuchun@bytedance.com>, Shuah Khan <shuah@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa
 <tfiga@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-17-david@redhat.com>
 <81fb0fa3-2e06-b765-56ac-a7d981194e59@redhat.com>
 <08b65ac6-6786-1080-18f8-d2be109c85fc@xs4all.nl>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <08b65ac6-6786-1080-18f8-d2be109c85fc@xs4all.nl>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_001856_162516_458FDA55 
X-CRM114-Status: GOOD (  24.79  )
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

T24gMjguMTEuMjIgMDk6MTcsIEhhbnMgVmVya3VpbCB3cm90ZToKPiBIaSBEYXZpZCwKPiAKPiBP
biAyNy8xMS8yMDIyIDExOjM1LCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToKPj4gT24gMTYuMTEu
MjIgMTE6MjYsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOgo+Pj4gRk9MTF9GT1JDRSBpcyByZWFs
bHkgb25seSBmb3IgcHRyYWNlIGFjY2Vzcy4gQWNjb3JkaW5nIHRvIGNvbW1pdAo+Pj4gNzA3OTQ3
MjQ3ZTk1ICgibWVkaWE6IHZpZGVvYnVmMi12bWFsbG9jOiBnZXRfdXNlcnB0cjogYnVmZmVycyBh
cmUgYWx3YXlzCj4+PiB3cml0YWJsZSIpLCBnZXRfdmFkZHJfZnJhbWVzKCkgY3VycmVudGx5IHBp
bnMgYWxsIHBhZ2VzIHdyaXRhYmxlIGFzIGEKPj4+IHdvcmthcm91bmQgZm9yIGlzc3VlcyB3aXRo
IHJlYWQtb25seSBidWZmZXJzLgo+Pj4KPj4+IEZPTExfRk9SQ0UsIGhvd2V2ZXIsIHNlZW1zIHRv
IGJlIGEgbGVnYWN5IGxlZnRvdmVyIGFzIGl0IHByZWRhdGVzCj4+PiBjb21taXQgNzA3OTQ3MjQ3
ZTk1ICgibWVkaWE6IHZpZGVvYnVmMi12bWFsbG9jOiBnZXRfdXNlcnB0cjogYnVmZmVycyBhcmUK
Pj4+IGFsd2F5cyB3cml0YWJsZSIpLiBMZXQncyBqdXN0IHJlbW92ZSBpdC4KPj4+Cj4+PiBPbmNl
IHRoZSByZWFkLW9ubHkgYnVmZmVyIGlzc3VlIGhhcyBiZWVuIHJlc29sdmVkLCBGT0xMX1dSSVRF
IGNvdWxkCj4+PiBhZ2FpbiBiZSBzZXQgZGVwZW5kaW5nIG9uIHRoZSBETUEgZGlyZWN0aW9uLgo+
Pj4KPj4+IENjOiBIYW5zIFZlcmt1aWwgPGh2ZXJrdWlsQHhzNGFsbC5ubD4KPj4+IENjOiBNYXJl
ayBTenlwcm93c2tpIDxtLnN6eXByb3dza2lAc2Ftc3VuZy5jb20+Cj4+PiBDYzogVG9tYXN6IEZp
Z2EgPHRmaWdhQGNocm9taXVtLm9yZz4KPj4+IENjOiBNYXJlayBTenlwcm93c2tpIDxtLnN6eXBy
b3dza2lAc2Ftc3VuZy5jb20+Cj4+PiBDYzogTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIDxtY2hlaGFi
QGtlcm5lbC5vcmc+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRA
cmVkaGF0LmNvbT4KPj4+IC0tLQo+Pj4gIMKgIGRyaXZlcnMvbWVkaWEvY29tbW9uL3ZpZGVvYnVm
Mi9mcmFtZV92ZWN0b3IuYyB8IDIgKy0KPj4+ICDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9j
b21tb24vdmlkZW9idWYyL2ZyYW1lX3ZlY3Rvci5jIGIvZHJpdmVycy9tZWRpYS9jb21tb24vdmlk
ZW9idWYyL2ZyYW1lX3ZlY3Rvci5jCj4+PiBpbmRleCA1NDJkZGU5ZDI2MDkuLjA2MmU5ODE0OGM1
MyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvbWVkaWEvY29tbW9uL3ZpZGVvYnVmMi9mcmFtZV92
ZWN0b3IuYwo+Pj4gKysrIGIvZHJpdmVycy9tZWRpYS9jb21tb24vdmlkZW9idWYyL2ZyYW1lX3Zl
Y3Rvci5jCj4+PiBAQCAtNTAsNyArNTAsNyBAQCBpbnQgZ2V0X3ZhZGRyX2ZyYW1lcyh1bnNpZ25l
ZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBpbnQgbnJfZnJhbWVzLAo+Pj4gIMKgwqDCoMKgwqAgc3Rh
cnQgPSB1bnRhZ2dlZF9hZGRyKHN0YXJ0KTsKPj4+ICDCoCDCoMKgwqDCoMKgIHJldCA9IHBpbl91
c2VyX3BhZ2VzX2Zhc3Qoc3RhcnQsIG5yX2ZyYW1lcywKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEZPTExfRk9SQ0UgfCBGT0xMX1dSSVRFIHwgRk9MTF9MT05HVEVSTSwK
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEZPTExfV1JJVEUgfCBGT0xM
X0xPTkdURVJNLAo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChz
dHJ1Y3QgcGFnZSAqKikodmVjLT5wdHJzKSk7Cj4+PiAgwqDCoMKgwqDCoCBpZiAocmV0ID4gMCkg
ewo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCB2ZWMtPmdvdF9yZWYgPSB0cnVlOwo+Pgo+Pgo+PiBI
aSBBbmRyZXcsCj4+Cj4+IHNlZSB0aGUgZGlzY3Vzc2lvbiBhdCBbMV0gcmVnYXJkaW5nIGEgY29u
ZmxpY3QgYW5kIGhvdyB0byBwcm9jZWVkIHdpdGgKPj4gdXBzdHJlYW1pbmcuIFRoZSBjb25mbGlj
dCB3b3VsZCBiZSBlYXN5IHRvIHJlc29sdmUsIGhvd2V2ZXIsIGFsc28KPj4gdGhlIHBhdGNoIGRl
c2NyaXB0aW9uIGRvZXNuJ3QgbWFrZSBzZW5zZSBhbnltb3JlIHdpdGggWzFdLgo+IAo+IE1pZ2h0
IGl0IGJlIGVhc2llciBhbmQgbGVzcyBjb25mdXNpbmcgaWYgeW91IHBvc3QgYSB2MiBvZiB0aGlz
IHNlcmllcwo+IHdpdGggbXkgcGF0Y2ggZmlyc3Q/IFRoYXQgd2F5IGl0IGlzIGNsZWFyIHRoYXQg
MSkgbXkgcGF0Y2ggaGFzIHRvIGNvbWUKPiBmaXJzdCwgYW5kIDIpIHRoYXQgaXQgaXMgcGFydCBv
ZiBhIHNpbmdsZSBzZXJpZXMgYW5kIHNob3VsZCBiZSBtZXJnZWQKPiBieSB0aGUgbW0gc3Vic3lz
dGVtLgo+IAo+IExlc3MgY2hhbmNlcyBvZiB0aGluZ3MgZ29pbmcgd3JvbmcgdGhhdCB3YXkuCj4g
Cj4gSnVzdCBtZW50aW9uIGluIHRoZSB2MiBjb3ZlciBsZXR0ZXIgdGhhdCB0aGUgZmlyc3QgcGF0
Y2ggd2FzIGFkZGVkIHRvCj4gbWFrZSBpdCBlYXN5IHRvIGJhY2twb3J0IHRoYXQgZml4IHdpdGhv
dXQgYmVpbmcgaGFtcGVyZWQgYnkgbWVyZ2UKPiBjb25mbGljdHMgaWYgaXQgd2FzIGFkZGVkIGFm
dGVyIHlvdXIgZnJhbWVfdmVjdG9yLmMgcGF0Y2guCgpZZXMsIHRoYXQncyB0aGUgd2F5IEkgd291
bGQgbmF0dXJhbGx5IGRvLCBpdCwgaG93ZXZlciwgQW5kcmV3IHByZWZlcnMgCmRlbHRhIHVwZGF0
ZXMgZm9yIG1pbm9yIGNoYW5nZXMuCgpAQW5kcmV3LCB3aGF0ZXZlciB5b3UgcHJlZmVyIQoKVGhh
bmtzIQoKLS0gClRoYW5rcywKCkRhdmlkIC8gZGhpbGRlbmIKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgt
dW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LXVtCg==
