Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FA5C4332F
	for <linux-um@archiver.kernel.org>; Tue, 29 Nov 2022 09:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=89vPLgpLS+iTPiewn3wYso3LW/SD9yx/rDBIAvdxYk0=; b=ehNEd7cTzdVs96
	kfudd3baL5noe1dq4CT8FaZ/cXjpmrOh+3J8AvSskKbcDntkfe8tJSHhxMfkrzsFJAw3U8TE4g+Ty
	3Vt6z+zp6tBNVFcY6fO6QmlhfCuaLIdmbiMTQR4WQ8YliXZAnuZAzprktFQgp1aXXus92poYyBTtu
	L11Z4pbh3ukM1ZteeLMLIdt0oNzMK2uFJYZUnEHxVLZ2/yIwmMbBr/x1b1LzlDW+qG8v/zXEPZphU
	DPhdId8YiL2tZaIUBwptQvcc8jb8jkwS86viVSuSNqmN7lCGmAoIPfVb0IzTBKz8L+dq/TcB/pH0x
	er5RLcom0hGwGO0T2ENA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozwiC-007k3g-Fn; Tue, 29 Nov 2022 09:15:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozwi9-007jzd-C4
	for linux-um@lists.infradead.org; Tue, 29 Nov 2022 09:15:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669713326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kLZwFc2T16+VzxzvdeqP7dZ+DZAGfAAiD+u0EUrSQ8s=;
	b=OvXTU6p0Ct0GG3VEsw6AOZSjwusuY/Ng6cuNku1asLSrx9F6Mc66uLvd7qxMRAZbOAL+J5
	Q8DdnyjmltiPLfDTqjLE3SaozLtbjrW5pWS5w+X7WF2iZ/48KkE540YFRqNv9Zfo0kmyyh
	pze47cOZYmn8QXjChvz5wyc79I3BaI4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-133-pKr36060M6WChhDgxBW4Fg-1; Tue, 29 Nov 2022 04:15:24 -0500
X-MC-Unique: pKr36060M6WChhDgxBW4Fg-1
Received: by mail-wr1-f70.google.com with SMTP id q13-20020adfab0d000000b002420132f543so2514925wrc.19
        for <linux-um@lists.infradead.org>; Tue, 29 Nov 2022 01:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLZwFc2T16+VzxzvdeqP7dZ+DZAGfAAiD+u0EUrSQ8s=;
        b=aHZjgtjuYEy4iKBoBeQbJBi2om2QGQwu67jImcWNv03+1tjjQyfh9cv5+OnX0DqDxh
         iLgw7AZOMMypGQz232g5vAAmEIjd9QM4vDmU76yOo0aElG1aq8xot/SCxATuNYdXXeqn
         W3PycFJGWL4AbF3fqWDbv7HjbmoxuWYchBRyznAOy8OpyD10rnDHeFnrTf0asAI1KUiT
         XtEHXQp8v45Aq4RnSXfwM3OQ/3VOZr23G/RL1W1OjotxU0lbmKt7lQ3Jx4UynkgqsYWv
         +pd5hZXa1wMRZn6Oy1E9FrZln4Z5s93RzwNEK53cFNbUVzsnwZQXp+lZDweclNGSnfm4
         puOA==
X-Gm-Message-State: ANoB5pmfs26afkNbqXNyfBALe78JnT78nA90V9pQcmZhqWt5WocfRNVG
	a38CHWqSa6/pYV6y1ZVRqN3obbmPjWVAGUDaCPlQ1DqFxHeaMnvTIUuBWgIb3OoVSLHrxVq4au0
	q46EPUTvdY7DhH0BgSMaUSahN
X-Received: by 2002:a05:600c:430c:b0:3cf:8ed7:7124 with SMTP id p12-20020a05600c430c00b003cf8ed77124mr42243412wme.140.1669713323598;
        Tue, 29 Nov 2022 01:15:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5aMoFyhfTZRz6WGw0GcgDkcONZAiRyZAh+e0PFHXmVnEtFtgvwKaxuOXbIxhdoVgI1OB8H+Q==
X-Received: by 2002:a05:600c:430c:b0:3cf:8ed7:7124 with SMTP id p12-20020a05600c430c00b003cf8ed77124mr42243382wme.140.1669713323266;
        Tue, 29 Nov 2022 01:15:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:ca00:3fb8:c253:3bf7:b60e? (p200300cbc705ca003fb8c2533bf7b60e.dip0.t-ipconnect.de. [2003:cb:c705:ca00:3fb8:c253:3bf7:b60e])
        by smtp.gmail.com with ESMTPSA id n26-20020a05600c3b9a00b003c6b70a4d69sm1498998wms.42.2022.11.29.01.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 01:15:22 -0800 (PST)
Message-ID: <abcba252-13a0-50aa-79ec-28b649c892cd@redhat.com>
Date: Tue, 29 Nov 2022 10:15:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH mm-unstable v1 16/20] mm/frame-vector: remove FOLL_FORCE
 usage
To: Hans Verkuil <hverkuil@xs4all.nl>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
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
 <9d0bf98a-3d6a-1082-e992-1338e1525935@redhat.com>
 <20221128145927.df895bf1966cfa125cae9668@linux-foundation.org>
 <22b1107b-0acc-5772-a883-8f3c4682eb1b@redhat.com>
 <c2681582-1e24-7ed9-e4fb-e2dd17a93aed@xs4all.nl>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <c2681582-1e24-7ed9-e4fb-e2dd17a93aed@xs4all.nl>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_011529_655261_607BE183 
X-CRM114-Status: GOOD (  18.41  )
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

T24gMjkuMTEuMjIgMTA6MDgsIEhhbnMgVmVya3VpbCB3cm90ZToKPiBPbiAyOS8xMS8yMDIyIDA5
OjQ4LCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToKPj4gT24gMjguMTEuMjIgMjM6NTksIEFuZHJl
dyBNb3J0b24gd3JvdGU6Cj4+PiBPbiBNb24sIDI4IE5vdiAyMDIyIDA5OjE4OjQ3ICswMTAwIERh
dmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPiB3cm90ZToKPj4+Cj4+Pj4+IExlc3Mg
Y2hhbmNlcyBvZiB0aGluZ3MgZ29pbmcgd3JvbmcgdGhhdCB3YXkuCj4+Pj4+Cj4+Pj4+IEp1c3Qg
bWVudGlvbiBpbiB0aGUgdjIgY292ZXIgbGV0dGVyIHRoYXQgdGhlIGZpcnN0IHBhdGNoIHdhcyBh
ZGRlZCB0bwo+Pj4+PiBtYWtlIGl0IGVhc3kgdG8gYmFja3BvcnQgdGhhdCBmaXggd2l0aG91dCBi
ZWluZyBoYW1wZXJlZCBieSBtZXJnZQo+Pj4+PiBjb25mbGljdHMgaWYgaXQgd2FzIGFkZGVkIGFm
dGVyIHlvdXIgZnJhbWVfdmVjdG9yLmMgcGF0Y2guCj4+Pj4KPj4+PiBZZXMsIHRoYXQncyB0aGUg
d2F5IEkgd291bGQgbmF0dXJhbGx5IGRvLCBpdCwgaG93ZXZlciwgQW5kcmV3IHByZWZlcnMKPj4+
PiBkZWx0YSB1cGRhdGVzIGZvciBtaW5vciBjaGFuZ2VzLgo+Pj4+Cj4+Pj4gQEFuZHJldywgd2hh
dGV2ZXIgeW91IHByZWZlciEKPj4+Cj4+PiBJJ20gaW5jbGluZWQgdG8gbGV0IHRoaW5ncyBzaXQg
YXMgdGhleSBhcmUuwqAgQ3Jvc3MtdHJlZSBjb25mbGljdHMKPj4+IGhhcHBlbiwgYW5kIExpbnVz
IGhhbmRsZXMgdGhlbS7CoCBJJ2xsIGZsYWcgdGhpcyAodmVyeSBzaW1wbGUpIGNvbmZsaWN0Cj4+
PiBpbiB0aGUgcHVsbCByZXF1ZXN0LCBpZiBNTSBtZXJnZXMgc2Vjb25kLsKgIElmIHY0bCBtZXJn
ZXMgc2Vjb25kIHRoZW4KPj4+IGhvcGVmdWxseSB0aGV5IHdpbGwgZG8gdGhlIHNhbWUuwqAgQnV0
IHRoaXMgb25lIGlzIHNvIHNpbXBsZSB0aGF0IExpbnVzCj4+PiBoYXJkbHkgbmVlZHMgb3VyIGhl
bHAuCj4gCj4gSXQncyBub3QgYWJvdXQgY3Jvc3MtdHJlZSBjb25mbGljdHMsIGl0J3MgYWJvdXQg
dGhlIGZhY3QgdGhhdCBteSBwYXRjaCBpcwo+IGEgZml4IHRoYXQgbmVlZHMgdG8gYmUgYmFja3Bv
cnRlZCB0byBvbGRlciBrZXJuZWxzLiBJdCBzaG91bGQgYXBwbHkgY2xlYW5seQo+IHRvIHRob3Nl
IG9sZGVyIGtlcm5lbHMgaWYgbXkgcGF0Y2ggZ29lcyBpbiBmaXJzdCwgYnV0IGlmIGl0IGlzIHRo
ZSBvdGhlciB3YXkKPiBhcm91bmQgSSB3b3VsZCBoYXZlIHRvIG1ha2UgYSBuZXcgcGF0Y2ggZm9y
IHRoZSBzdGFibGUga2VybmVscy4KCklJVUMsIHRoZSBjb25mbGljdCB3aWxsIGJlIHJlc29sdmVk
IGF0IG1lcmdlIHRpbWUgYW5kIHRoZSBtZXJnZSAKcmVzb2x1dGlvbiB3aWxsIGJlIHBhcnQgb2Yg
dGhlIG1lcmdlIGNvbW1pdC4gSXQgZG9lc24ndCBtYXR0ZXIgaW4gd2hpY2ggCm9yZGVyIHRoZSBw
YXRjaGVzIGdvIHVwc3RyZWFtLCB0aGUgbWVyZ2UgY29tbWl0IHJlc29sdmVzIHRoZSBwcm9ibGVt
YXRpYyAKb3ZlcmxhcC4KClNvIHlvdXIgcGF0Y2ggd2lsbCBiZSB1cHN0cmVhbSBhcyBpbnRlbmRl
ZCwgd2hlcmUgaXQgY2FuIGJlIGNsZWFubHkgCmJhY2twb3J0ZWQuCgpIb3BlIEkgYW0gbm90IHR3
aXN0aW5nIHJlYWxpdHkgOykKCi0tIApUaGFua3MsCgpEYXZpZCAvIGRoaWxkZW5iCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGlu
ZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
