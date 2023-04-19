Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7873EC77B78
	for <linux-um@archiver.kernel.org>; Wed, 19 Apr 2023 07:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:Subject:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CAAssKNrHQSMfZx1k1u4AnxMO1dPG/93F3E0Q5XyAP8=; b=hIMS2iAHZmZaA9
	tMhAswDIDG/psWLP9o78TTsT/mYRWOHMEVtrYTnoxFoxG5ccB0b7pXoXRgmdSdUFhQYcdgyCeTmmm
	4Z+1aTN2Ux3Ibt+vlgXBcEAh/7p2RlvX81ckgNQBxlI+ul5tZNhHCRu5mVFjKByOreIcGCh8F3ldo
	2yRJqZV0Zl2582PGL2a8YZRkrXD9BYSyElOu6vOPIwnUJ0/vf/WXpgQeD+8I11faK2oHQmmoB7GN8
	8q0xYlarof26DRPQCwiGp3SWcORTp9Ad1x+G7n1lOEBYZ4jzQBVl0b7VIwCkd3RXuMgXmlczBTdam
	O/g/JAfpWh1+koYs6t5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp2dt-004V9D-2R;
	Wed, 19 Apr 2023 07:54:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp2dq-004V72-0B
	for linux-um@lists.infradead.org;
	Wed, 19 Apr 2023 07:54:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681890853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ku4/Si8D6xrlYmDkiBxBM7QW/Zhm4h1GUH6h0hqbhBo=;
	b=Cla5vpMiSIZ5MOM+7UGd9nWVvOXptu0l43jeZGrATas6+8FjMyfn14Fgp7gvTt+0hIes+w
	QwdHtUYCx8CYOVcExcScBGm2t3vI3VvievgQXPz05kwqAR2Czo4iMDt3qZlIugSxHfVorL
	lvG0B2ZsjbTX60EegYqc9foEfZM6B10=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-QcE0dor6PAOPLJmQr7QtOw-1; Wed, 19 Apr 2023 03:54:09 -0400
X-MC-Unique: QcE0dor6PAOPLJmQr7QtOw-1
Received: by mail-wm1-f69.google.com with SMTP id n39-20020a05600c3ba700b003f1732a2cbcso817353wms.8
        for <linux-um@lists.infradead.org>; Wed, 19 Apr 2023 00:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681890849; x=1684482849;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ku4/Si8D6xrlYmDkiBxBM7QW/Zhm4h1GUH6h0hqbhBo=;
        b=Oxokt1MPptiylOPmzAPKcsyqAmHbNp3HHkSCVdf3WjJmoMnQEB0i5GwcnYjeNkE2yZ
         KCU3VPV4+YutlDiqhJSD8qHDNP1lIgAn8uM7tkD20H0fd6M4vQtpEX7ge7xSqA31vHWy
         OQ52myU9wZy65VUEGxsMdh7xTMyWEEXzn3GuGeI1UcZlU5L8uR6kKQeZoXxhUXnyvi3O
         701/EMW4t+WLg2ThDZTC45p56OFFa0Jw46is08hbpOCarelTPBTSIdzzIT9Dfpw9UsyR
         3X6BkD2jDdfcNGAPMkHVPMg9JFJ1ISdYTR8MfC13J1UPg/R8FjJLeZI90iJkJiuudl5L
         KgJA==
X-Gm-Message-State: AAQBX9fvu09iCbenavfs8a+VvVUxPI505KrSR2h/rnmQoPozJoDw5eSp
	gmxdpPcFgm1AjTC6NsREACd4f+aaiYx6dK9TCHJlGP5IakHssJj2EBomgdvAn4+aTZcmHj5q/EV
	jNUvEQ8DPRtJ+lt3RBBHQZiBx
X-Received: by 2002:a05:600c:2305:b0:3f1:728a:1881 with SMTP id 5-20020a05600c230500b003f1728a1881mr7565080wmo.31.1681890848810;
        Wed, 19 Apr 2023 00:54:08 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZGeCzv8hHHPCLoBp3+kn6wkQN0cMnv6OhMvvwsxXxMwENw712YUrmrVhvIskYHJBvgTLUksw==
X-Received: by 2002:a05:600c:2305:b0:3f1:728a:1881 with SMTP id 5-20020a05600c230500b003f1728a1881mr7565048wmo.31.1681890848428;
        Wed, 19 Apr 2023 00:54:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:7b00:7c52:a5fa:8004:96fd? (p200300cbc70b7b007c52a5fa800496fd.dip0.t-ipconnect.de. [2003:cb:c70b:7b00:7c52:a5fa:8004:96fd])
        by smtp.gmail.com with ESMTPSA id l26-20020a1ced1a000000b003eeb1d6a470sm1327085wmh.13.2023.04.19.00.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 00:54:08 -0700 (PDT)
Message-ID: <e0c0ad67-f23f-ff35-80bf-841dcfd43d99@redhat.com>
Date: Wed, 19 Apr 2023 09:54:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Vishal Moola <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org
References: <20230417205048.15870-1-vishal.moola@gmail.com>
 <20230417205048.15870-2-vishal.moola@gmail.com>
 <da600570-51c7-8088-b46b-7524c9e66e5d@redhat.com>
 <CAOzc2pwpRhNoFbdzdzuvrqbZdf2OsrTvBGs40QCZJjA5fS_q1A@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 01/33] s390: Use _pt_s390_gaddr for gmap address tracking
In-Reply-To: <CAOzc2pwpRhNoFbdzdzuvrqbZdf2OsrTvBGs40QCZJjA5fS_q1A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230419_005414_166877_B3634E60 
X-CRM114-Status: GOOD (  23.81  )
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

T24gMTguMDQuMjMgMjM6MzMsIFZpc2hhbCBNb29sYSB3cm90ZToKPiBPbiBUdWUsIEFwciAxOCwg
MjAyMyBhdCA4OjQ14oCvQU0gRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+IHdy
b3RlOgo+Pgo+PiBPbiAxNy4wNC4yMyAyMjo1MCwgVmlzaGFsIE1vb2xhIChPcmFjbGUpIHdyb3Rl
Ogo+Pj4gczM5MCB1c2VzIHBhZ2UtPmluZGV4IHRvIGtlZXAgdHJhY2sgb2YgcGFnZSB0YWJsZXMg
Zm9yIHRoZSBndWVzdCBhZGRyZXNzCj4+PiBzcGFjZS4gSW4gYW4gYXR0ZW1wdCB0byBjb25zb2xp
ZGF0ZSB0aGUgdXNhZ2Ugb2YgcGFnZSBmaWVsZHMgaW4gczM5MCwKPj4+IHJlcGxhY2UgX3B0X3Bh
ZF8yIHdpdGggX3B0X3MzOTBfZ2FkZHIgdG8gcmVwbGFjZSBwYWdlLT5pbmRleCBpbiBnbWFwLgo+
Pj4KPj4+IFRoaXMgd2lsbCBoZWxwIHdpdGggdGhlIHNwbGl0dGluZyBvZiBzdHJ1Y3QgcHRkZXNj
IGZyb20gc3RydWN0IHBhZ2UsIGFzCj4+PiB3ZWxsIGFzIGFsbG93IHMzOTAgdG8gdXNlIF9wdF9m
cmFnX3JlZmNvdW50IGZvciBmcmFnbWVudGVkIHBhZ2UgdGFibGUKPj4+IHRyYWNraW5nLgo+Pj4K
Pj4+IFNpbmNlIHBhZ2UtPl9wdF9zMzkwX2dhZGRyIGFsaWFzZXMgd2l0aCBtYXBwaW5nLCBlbnN1
cmUgaXRzIHNldCB0byBOVUxMCj4+PiBiZWZvcmUgZnJlZWluZyB0aGUgcGFnZXMgYXMgd2VsbC4K
Pj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBWaXNoYWwgTW9vbGEgKE9yYWNsZSkgPHZpc2hhbC5tb29s
YUBnbWFpbC5jb20+Cj4+PiAtLS0KPj4KPj4gWy4uLl0KPj4KPj4+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L21tX3R5cGVzLmggYi9pbmNsdWRlL2xpbnV4L21tX3R5cGVzLmgKPj4+IGluZGV4
IDNmYzllNjgwZjE3NC4uMjYxNmQ2NGMwZThjIDEwMDY0NAo+Pj4gLS0tIGEvaW5jbHVkZS9saW51
eC9tbV90eXBlcy5oCj4+PiArKysgYi9pbmNsdWRlL2xpbnV4L21tX3R5cGVzLmgKPj4+IEBAIC0x
NDQsNyArMTQ0LDcgQEAgc3RydWN0IHBhZ2Ugewo+Pj4gICAgICAgICAgICAgICAgc3RydWN0IHsg
ICAgICAgIC8qIFBhZ2UgdGFibGUgcGFnZXMgKi8KPj4+ICAgICAgICAgICAgICAgICAgICAgICAg
dW5zaWduZWQgbG9uZyBfcHRfcGFkXzE7ICAgICAgICAvKiBjb21wb3VuZF9oZWFkICovCj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgIHBndGFibGVfdCBwbWRfaHVnZV9wdGU7IC8qIHByb3RlY3Rl
ZCBieSBwYWdlLT5wdGwgKi8KPj4+IC0gICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25n
IF9wdF9wYWRfMjsgICAgICAgIC8qIG1hcHBpbmcgKi8KPj4+ICsgICAgICAgICAgICAgICAgICAg
ICB1bnNpZ25lZCBsb25nIF9wdF9zMzkwX2dhZGRyOyAgIC8qIG1hcHBpbmcgKi8KPj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgdW5pb24gewo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHN0cnVjdCBtbV9zdHJ1Y3QgKnB0X21tOyAvKiB4ODYgcGdkcyBvbmx5ICovCj4+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgYXRvbWljX3QgcHRfZnJhZ19yZWZjb3VudDsgLyog
cG93ZXJwYyAqLwo+Pgo+PiBUaGUgY29uZnVzaW5nIHBhcnQgaXMsIHRoYXQgdGhlc2UgZ21hcCBw
YWdlIHRhYmxlcyBhcmUgbm90IG9yZGluYXJ5Cj4+IHByb2Nlc3MgcGFnZSB0YWJsZXMgdGhhdCB3
ZSB3b3VsZCBvcmRpbmFyaWx5IHBsYWNlIGludG8gdGhpcyBzZWN0aW9uCj4+IGhlcmUuIFRoYXQn
cyB3aHkgdGhleSBhcmUgYWxzbyBub3QgYWxsb2NhdGVkL2ZyZWVkIHVzaW5nIHRoZSB0eXBpY2Fs
Cj4+IHBhZ2UgdGFibGUgY29uc3RydWN0b3IvZGVzdHJ1Y3RvciAuLi4KPiAKPiBJIGluaXRpYWxs
eSB0aG91Z2h0IHRoZSBzYW1lLCBzbyBJIHdhcyBxdWl0ZSBjb25mdXNlZCB3aGVuIEkgc2F3Cj4g
X19nbWFwX3NlZ21lbnRfZ2FkZHIgd2FzIHVzaW5nIHBtZF9wZ3RhYmxlX3BhZ2UoKS4KPiAKPiBB
bHRob3VnaCB0aGV5IGFyZSBub3Qgb3JkaW5hcnkgcHJvY2VzcyBwYWdlIHRhYmxlcywgc2luY2Ug
d2UKPiBldmVudHVhbGx5IHdhbnQgdG8gbW92ZSB0aGVtIG91dCBvZiBzdHJ1Y3QgcGFnZSwgSSB0
aGluayBzaGlmdGluZyB0aGVtCj4gdG8gYmUgaW4gcHRkZXNjcywgYmVpbmcgYSBtZW1vcnkgZGVz
Y3JpcHRvciBmb3IgcGFnZSB0YWJsZXMsIG1ha2VzCj4gdGhlIG1vc3Qgc2Vuc2UuCgpTZWVpbmcg
dXRpbGl0aWVzIGxpa2UgdGxiX3JlbW92ZV9wYWdlX3B0ZGVzYygpIHRoYXQgZG9uJ3QgcmVhbGx5
IGFwcGx5IAp0byBzdWNoIHBhZ2UgdGFibGVzLCBJIHdvbmRlciBpZiB3ZSBzaG91bGQgbXVjaCBy
YXRoZXIgdHJlYXQgc3VjaCAKc2hhZG93L2F1eGlsaWFyeS8uLi4gcGFnZSB0YWJsZXMgKGp1c3Qg
bGlrZSBvdGhlciBhcmNoaXRlY3R1cmVzIGxpa2UgCng4NiwgYXJtLCAuLi4gZW1wbG95IGFzIHdl
bGwpIGFzIGEgZGlzdGluY3QgdHlwZS4KCkFuZCBoYXZlIHB0ZGVzYyBiZSB0aGUgY29tbW9uIHR5
cGUgZm9yIGFsbCBwcm9jZXNzIHBhZ2UgdGFibGVzLgoKPiAKPiBBbm90aGVyIG9wdGlvbiBpcyB0
byBsZWF2ZSBwbWRfcGd0YWJsZV9wYWdlKCkgYXMgaXMganVzdCBmb3IgdGhpcyBjYXNlLgo+IE9y
IHdlIGNhbiByZXZlcnQgY29tbWl0IDdlMjVkZTc3YmM1ZWEgd2hpY2ggdXNlcyB0aGUgZnVuY3Rp
b24gaGVyZQo+IHRoZW4gZmlndXJlIG91dCB3aGVyZSB0aGVzZSBnbWFwIHBhZ2VzIHRhYmxlIHBh
Z2VzIHdpbGwgZ28gbGF0ZXIuCgpJJ20gYWx3YXlzIGNvbmZ1c2VkIHdoZW4gcmVhZGluZyBnbWFw
IGNvZGUsIHNvIGxldCBtZSBoYXZlIGFub3RoZXIgbG9vayA6KQoKVGhlIGNvbmZ1c2luZyBwYXJ0
IGlzIHRoYXQgczM5MHggc2hhcmVzIHRoZSBsb3dlc3QgbGV2ZWwgcGFnZSB0YWJsZXMgCihQVEUg
dGFibGVzKSBiZXR3ZWVuIHRoZSBwcm9jZXNzIGFuZCBnbWFwICgiZ3Vlc3QgbWFwcGluZyIsIHNp
bWlsYXIgdG8gCkVQVCBvbiB4ODYtNjQpLiBJdCBtYXBzIHRoZXNlIHByb2Nlc3MgUFRFIHRhYmxl
cyAoY292ZXJpbmcgMSBNaUIpIGludG8gCmdtYXAtc3BlY2lmaWMgUE1EIHRhYmxlcy4KCnBtZF9w
Z3RhYmxlX3BhZ2UoKSBzaG91bGQgaW5kZWVkIGFsd2F5cyBnaXZlIHVzIGEgZ21hcC1zcGVjaWZp
YyAKUE1ELXRhYmxlLiBJbiBmYWN0LCBzb21ldGhpbmcgYWxsb2NhdGVkIHZpYSBnbWFwX2FsbG9j
X3RhYmxlKCkuCgpEZWNvdXBsaW5nIGJvdGggY29uY2VwdHMgc291bmRzIGxpa2UgYSBnb29kIGlk
ZWEuCgotLSAKVGhhbmtzLAoKRGF2aWQgLyBkaGlsZGVuYgoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11
bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtdW0K
