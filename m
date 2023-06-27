Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0371CEB64DC
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 21:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y1T945U5wjRoFAi6M5zR1TQLxbYYU8oE+AJhANr2L3g=; b=jqfVBzOWoYTECt
	B5yh45ccxPUZUTd5R2mVELOQYkzATXuWslseLy1i2VuDXQ6k3eiage6UOOdL2ZKRpe+rseA9nJKyF
	XYanFUTO5BytyBTF/BFSmjXJiVeFkyBRKmQSHxlYbC7jmBTCMVhMOwh/zFpIpR82c9sqZX9p0q3Zz
	PD0FVzJEUo2stNSnOB8AKX3DwLXr90tKcG+b8cPAtqZw6328MDr7f9flq6ctYwZUoAmqak2ppzjuH
	wlBq1ALs5WDwjdgZdK9206EX93ii+4dDVwg9Pz1QL0tNYIEADocJ/B2xvxxfF1PKFScd0WbhkGLg9
	4UxNnD4toYhhqaUyckIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEGhG-00EGMs-1r;
	Tue, 27 Jun 2023 21:58:02 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEGhB-00EGKc-0o;
	Tue, 27 Jun 2023 21:57:59 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-67ef5af0ce8so775018b3a.2;
        Tue, 27 Jun 2023 14:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687903076; x=1690495076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=t1QqN2jdF+WL3G2Fn2F+gnSyyU4sNUKe3JWXuNtILlE=;
        b=g+t5RbdhRiaLoYyDKYrUABIe+H7AyRcVTK6Ps8KX11dLH3rVyHHxTIp4jo1F1MLfJ/
         7iNHUg8lMtHSGaBwqfjHucjm6wwc/jl78+I2QtBt+NVF52zFOTO8iGbXC2EXZcfaizxp
         syPg/dBUX2hToZvcUTpD+czYfrRw5crN2vey7CoePIDlxvhbRn4jKEtVasFgYbYadRKT
         uIII/cayZYqptv+yRMmyM+Wfpd5/UPoabOL1LFJ6elItbp/e6VHQDna35ucIS9DgJdAS
         QwUA3GiJRf5dQk/OTJ3hXfUBDFz7VSwh76MedBtdvOPKN3bvoe9PwVVR6Es4OllczpXD
         WRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687903076; x=1690495076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1QqN2jdF+WL3G2Fn2F+gnSyyU4sNUKe3JWXuNtILlE=;
        b=QT0iH/Pgvtyoseu8FcPHdiCEZLBqzIy1vU1swqLyjvHUQ1JJNJdAZeuuRADS3wAaAr
         +9xBY034IxAA5Vg/fTO3RItHg7OOFLkj3BK3PvlOvEmHFzpzySqTMZg6PURsnKugSpvl
         3FzrDDojr8HnVH8L2+UZG6Z7Y00CUeWi0IqIQKPrwMrp9sRjNtjYkXk4kX75bzjwkyjN
         iNbcMi6he8JwzzMxN51uPag3eTfobhOlKKLZ+pL16MD4pXPMOVAt4cHmC27qkjjdEcIT
         MIgwnB1yFW/RitinOPhoRDTQsJHMmT/BAM8k4H+4UzUICf9xiAM/HWGZJHtTgVuqTtkv
         0CDg==
X-Gm-Message-State: AC+VfDyDBMWiRIxWQGE4NfCdNOc6DlMbcL5JKWMFwq15BsfN0hwcSKkU
	Opvn7QaRUD6rDHn5/ZBQJ8inM4nZgfo=
X-Google-Smtp-Source: ACHHUZ6lN48OedTSkLTDBhYcXWegZDranrwbL7k9xhFTjM3m37Ei4jw/mCpSF8qmoSte/cwaCNHhUw==
X-Received: by 2002:a17:902:c407:b0:1ac:8717:d436 with SMTP id k7-20020a170902c40700b001ac8717d436mr14008978plk.60.1687903075769;
        Tue, 27 Jun 2023 14:57:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b001b69303db65sm6438851plh.26.2023.06.27.14.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 14:57:55 -0700 (PDT)
Message-ID: <a7e61e75-cc94-9771-4b56-d1a7c35c13f2@roeck-us.net>
Date: Tue, 27 Jun 2023 14:57:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Content-Language: en-US
To: Dinh Nguyen <dinguyen@kernel.org>, Vishal Moola <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
 <20230622205745.79707-27-vishal.moola@gmail.com>
 <13bab37c-0f0a-431a-8b67-4379bf4dc541@roeck-us.net>
 <CAOzc2px6VutRkMUTn+M5LFLf1YbRVZFgJ=q7StaApwYRxUWqQA@mail.gmail.com>
 <cc954b15-63ab-9d9f-2d37-1aea78b7f65f@roeck-us.net>
 <b6a5753b-8874-6465-f690-094ee753e038@roeck-us.net>
 <CAOzc2pxdqeaRjYLfOqvMW-AEobTzD9xOP+MyP9nxgEbi1T2r7Q@mail.gmail.com>
 <c3751051-7fc7-7129-b9a7-ead71c576ace@kernel.org>
 <2b7e8b1d-1697-6a25-434d-352f95e6fff2@roeck-us.net>
 <70776142-a778-9c20-5594-835ed6f7e7a2@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <70776142-a778-9c20-5594-835ed6f7e7a2@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_145757_290577_F9AD0FEE 
X-CRM114-Status: GOOD (  21.46  )
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

T24gNi8yNy8yMyAxNDo0NiwgRGluaCBOZ3V5ZW4gd3JvdGU6Cj4gCj4gCj4gT24gNi8yNy8yMyAx
NjowMSwgR3VlbnRlciBSb2VjayB3cm90ZToKPj4gT24gNi8yNy8yMyAxMzowNSwgRGluaCBOZ3V5
ZW4gd3JvdGU6Cj4+Pgo+Pj4KPj4+IE9uIDYvMjcvMjMgMTQ6NTYsIFZpc2hhbCBNb29sYSB3cm90
ZToKPj4+PiBPbiBUdWUsIEp1biAyNywgMjAyMyBhdCAxMjoxNOKAr1BNIEd1ZW50ZXIgUm9lY2sg
PGxpbnV4QHJvZWNrLXVzLm5ldD4gd3JvdGU6Cj4+Pj4+Cj4+Pj4+IE9uIDYvMjcvMjMgMTI6MTAs
IEd1ZW50ZXIgUm9lY2sgd3JvdGU6Cj4+Pj4+PiBPbiA2LzI3LzIzIDEwOjQyLCBWaXNoYWwgTW9v
bGEgd3JvdGU6Cj4+Pj4+Pj4gT24gTW9uLCBKdW4gMjYsIDIwMjMgYXQgMTA6NDfigK9QTSBHdWVu
dGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+IHdyb3RlOgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBP
biBUaHUsIEp1biAyMiwgMjAyMyBhdCAwMTo1NzozOFBNIC0wNzAwLCBWaXNoYWwgTW9vbGEgKE9y
YWNsZSkgd3JvdGU6Cj4+Pj4+Pj4+PiBQYXJ0IG9mIHRoZSBjb252ZXJzaW9ucyB0byByZXBsYWNl
IHBndGFibGUgY29uc3RydWN0b3IvZGVzdHJ1Y3RvcnMgd2l0aAo+Pj4+Pj4+Pj4gcHRkZXNjIGVx
dWl2YWxlbnRzLgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFZpc2hhbCBNb29s
YSAoT3JhY2xlKSA8dmlzaGFsLm1vb2xhQGdtYWlsLmNvbT4KPj4+Pj4+Pj4+IEFja2VkLWJ5OiBN
aWtlIFJhcG9wb3J0IChJQk0pIDxycHB0QGtlcm5lbC5vcmc+Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IFRo
aXMgcGF0Y2ggY2F1c2VzIGFsbCBuaW9zMiBidWlsZHMgdG8gZmFpbC4KPj4+Pj4+Pgo+Pj4+Pj4+
IEl0IGxvb2tzIGxpa2UgeW91IHRyaWVkIHRvIGFwcGx5IHRoaXMgcGF0Y2ggb24gaXRzIG93bi4g
VGhpcyBwYXRjaCBkZXBlbmRzCj4+Pj4+Pj4gb24gcGF0Y2hlcyAwMS0xMiBvZiB0aGlzIHBhdGNo
c2V0IHRvIGNvbXBpbGUgcHJvcGVybHkuIEkndmUgY3Jvc3MtY29tcGlsZWQKPj4+Pj4+PiB0aGlz
IGFyY2hpdGVjdHVyZSBhbmQgaXQgd29ya2VkLCBidXQgbGV0IG1lIGtub3cgaWYgc29tZXRoaW5n
IGZhaWxzCj4+Pj4+Pj4gd2hlbiBpdHMgYXBwbGllZCBvbiB0b3Agb2YgdGhvc2UgcGF0Y2hlcyAo
b3IgdGhlIHJlc3Qgb2YgdGhlIHBhdGNoc2V0KS4KPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gTm8sIEkg
ZGlkIG5vdCB0cnkgdG8gYXBwbHkgdGhpcyBwYXRjaCBvbiBpdHMgb3duLiBJIHRyaWVkIHRvIGJ1
aWxkIHllc3RlcmRheSdzCj4+Pj4+PiBwZW5kaW5nLWZpeGVzIGJyYW5jaCBvZiBsaW51eC1uZXh0
Lgo+Pj4+Pj4KPj4+Pj4KPj4+Pj4gQSBxdWljayBjaGVjayBzaG93cyB0aGF0IHRoZSBidWlsZCBm
YWlscyB3aXRoIG5leHQtMjAyMzA2MjcuIFNlZSBsb2cgYmVsb3cuCj4+Pj4KPj4+PiBBaCBpdCBs
b29rcyBsaWtlIHRoaXMgb25lIHNsaXBwZWQgaW50byAtbmV4dCBvbiBpdHMgb3duIHNvbWVob3c/
IFN0ZXBoZW4sIHBsZWFzZQo+Pj4+IGRyb3AgdGhpcyBwYXRjaCBmcm9tIC1uZXh0OyBpdCBzaG91
bGRuJ3QgYmUgaW4gd2l0aG91dCB0aGUgcmVzdCBvZiB0aGUKPj4+PiBwYXRjaHNldCB3aGljaAo+
Pj4+IEkgaW50ZW5kIHRvIGhhdmUgQW5kcmV3IHRha2UgdGhyb3VnaCB0aGUgbW0gdHJlZS4KPj4+
Pgo+Pj4KPj4+IEkgYXBvbG9naXplLCBidXQgSSBxdWV1ZSB0aGlzIHBhdGNoIHVwIGZvciBMaW51
cyBhbmQgaXQncyBiZWVuIHB1bGxlZCBmb3IgdGhpcyBtZXJnZSB3aW5kb3cuIEkgZGlkbid0IHJl
YWxpemUgeW91IHdlcmUgZ29pbmcgdG8gdGFrZSB0aGlzIHBhdGNoc2V0IHRocm91Z2ggYW5vdGhl
ciB0cmVlLgo+Pj4KPj4+IFNvcnJ5IGFib3V0IHRoYXQuCj4+Pgo+Pgo+PiBZZXMsIGluZGVlZCwg
SSBqdXN0IGNvbmZpcm1lZCB0aGF0IGFsbCBuaW9zMiBidWlsZHMgaW4gdGhlIG1haW5saW5lIGtl
cm5lbAo+PiBhcmUgbm93IGJyb2tlbi4KPj4KPiAKPiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91
IG5lZWQgdG8gZG8gYW55dGhpbmcuIEknbSBnb2luZyB0byBvdXQgZm9yIGEgd2VlayBzdGFydGlu
ZyB0b21vcnJvdy4KPiAKCk5vdCBzdXJlIEkgdW5kZXJzdGFuZC4gSXQgc2VlbXMgdG8gbWUgdGhh
dCBpdCB3b3VsZCBoYXZlIHRvIGJlIHlvdSB0byBkbyBzb21ldGhpbmcuCkFmdGVyIGFsbCwgeW91
IGFyZSB0aGUgbmlvczIgbWFpbnRhaW5lciwgYW5kIG5pb3MyIGJ1aWxkcyBpbiBtYWlubGluZSBh
cmUgbm93CmJyb2tlbi4gTWF5YmUgc2VuZCBhIHJldmVydCA/IEFtIEkgbWlzc2luZyBzb21ldGhp
bmcgPwoKR3VlbnRlcgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
