Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DD3C88CB4
	for <linux-um@archiver.kernel.org>; Tue, 13 Jun 2023 12:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gls/0UuG5mHBsifXmjfoxC/99eEpuQhUk0SVPi/fgs0=; b=qQ8ItnygY+GUe9
	Yx7KOzaREc+D1qPrx88mlUeVyBooYHkok5QDOHg3WDofRB6lx0mzGr70cMq4FVXzRuRRP1vRu0pD6
	eFAYyqKIFAuPHMHSM2Pk1Y0VQvwBXgHaizGYqp/X16uGpzGix4FqllAnluZ9BKsdqwWHsapvSR3qy
	dIg0/4CTB99la6uh2BdABArSBd7B8B3qQ9KE7cJnKD7ooxBR8/Qi1RzNFVHUsHZGbHAheABtIDuqp
	tnYvOCS/mApqIqzzlLknq81oxdl18U+XyGEJJ3zihR/9I5iUIdKYjS4sUKs3mKBDvM/PMLAaudhv/
	SJoHgJaQGGripmWflOaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9370-00831l-2z;
	Tue, 13 Jun 2023 12:27:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q936x-0082zz-33
	for linux-um@lists.infradead.org;
	Tue, 13 Jun 2023 12:27:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686659219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x4X42epITHEmHx9Rdq7WZvtJt4reSEJsGpXTx4uakPs=;
	b=XnHIVU90C9TJ+dH5iLKcGln4N+lzVrbOu5uj9N85J15wwf4z10nruD+dGMcniFwEbHmk7J
	lHqVWWDwwSjfFAlkhuZEh3i956u4PWyXakr9CaL1RFFbLTbOyagldGAbMpSdR0WEY9Ty6Z
	P0oxgRVuraXBH5frWwz/MY1wNqSs+/s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-LXkCsOl6MUGU_KFnkD0ZSg-1; Tue, 13 Jun 2023 08:26:57 -0400
X-MC-Unique: LXkCsOl6MUGU_KFnkD0ZSg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30fc67636a2so779580f8f.0
        for <linux-um@lists.infradead.org>; Tue, 13 Jun 2023 05:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686659217; x=1689251217;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x4X42epITHEmHx9Rdq7WZvtJt4reSEJsGpXTx4uakPs=;
        b=KvDZAdV3NMDSsmGTEYGO12+Jv/bfOq9JzpbkaEfhJMVHu/YKYh9K4MvI+GKLBn29/E
         W9Ngw5XjePf37DAvLyqCJTxsF2sF2TDBiYi9Yp0DVDJAKda00LaPzKBA1lgd7/MKEtf8
         2pwlGwKGHJPXwej71HqKUE1n/Bul68kNLXMLmQdyZr4FTYOQHRKTsEUKjP2Tl7X8AeEr
         PZQsXOPS8FVM+UVNl3lZaXPIZPy4tKgqtsUPJ7Pgb7XFsKvJsYLks+XYvhJggnct4r8L
         VEJuWCrw+Zq0Uu4YY3oDr2EtiN/KSaqutBQBWncdU2udPZ4K+19vxXbsFnwSBBo1jD0g
         0eKg==
X-Gm-Message-State: AC+VfDwdPE4jn1XiVorxt6YL7ZZFS45C1oI8DKJ1pTahB5iLoRfoFTmR
	dXOCLrplYXhu9BOg5h9FMISI+AvEtcs+PiKoS5AFF5GId4i8oh/Qa1OVDFu9MJXbGXq6qEEow5t
	1L0+0RP8cqUkrN67Y+rjRrEeP
X-Received: by 2002:a5d:6acd:0:b0:30f:b7b4:3e55 with SMTP id u13-20020a5d6acd000000b0030fb7b43e55mr6371759wrw.19.1686659216773;
        Tue, 13 Jun 2023 05:26:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4yteTIZOrnVCopzRkUBsfyPnfoDVYPpW9xv2sO4EBsmO+rg3naLzU0Pz+CwjSuscU8Zw+bFQ==
X-Received: by 2002:a5d:6acd:0:b0:30f:b7b4:3e55 with SMTP id u13-20020a5d6acd000000b0030fb7b43e55mr6371694wrw.19.1686659216382;
        Tue, 13 Jun 2023 05:26:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:ff00:1a06:80f:733a:e8c6? (p200300cbc710ff001a06080f733ae8c6.dip0.t-ipconnect.de. [2003:cb:c710:ff00:1a06:80f:733a:e8c6])
        by smtp.gmail.com with ESMTPSA id i1-20020adff301000000b002f28de9f73bsm15275419wro.55.2023.06.13.05.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 05:26:55 -0700 (PDT)
Message-ID: <497e571e-e4de-7634-7da6-683599a4bbba@redhat.com>
Date: Tue, 13 Jun 2023 14:26:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v9 01/42] mm: Rename arch pte_mkwrite()'s to
 pte_mkwrite_novma()
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
 Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
 Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>,
 Weijiang Yang <weijiang.yang@intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 John Allen <john.allen@amd.com>, kcc@google.com, eranian@google.com,
 rppt@kernel.org, jamorris@linux.microsoft.com, dethoma@microsoft.com,
 akpm@linux-foundation.org, Andrew.Cooper3@citrix.com,
 christina.schimpe@intel.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
 torvalds@linux-foundation.org, broonie@kernel.org
Cc: linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
 linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, Linus Torvalds <torvalds@linuxfoundation.org>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_052700_058633_F3F0C78F 
X-CRM114-Status: GOOD (  29.95  )
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

T24gMTMuMDYuMjMgMDI6MTAsIFJpY2sgRWRnZWNvbWJlIHdyb3RlOgo+IFRoZSB4ODYgU2hhZG93
IHN0YWNrIGZlYXR1cmUgaW5jbHVkZXMgYSBuZXcgdHlwZSBvZiBtZW1vcnkgY2FsbGVkIHNoYWRv
dwo+IHN0YWNrLiBUaGlzIHNoYWRvdyBzdGFjayBtZW1vcnkgaGFzIHNvbWUgdW51c3VhbCBwcm9w
ZXJ0aWVzLCB3aGljaCByZXF1aXJlcwo+IHNvbWUgY29yZSBtbSBjaGFuZ2VzIHRvIGZ1bmN0aW9u
IHByb3Blcmx5Lgo+IAo+IE9uZSBvZiB0aGVzZSB1bnVzdWFsIHByb3BlcnRpZXMgaXMgdGhhdCBz
aGFkb3cgc3RhY2sgbWVtb3J5IGlzIHdyaXRhYmxlLAo+IGJ1dCBvbmx5IGluIGxpbWl0ZWQgd2F5
cy4gVGhlc2UgbGltaXRzIGFyZSBhcHBsaWVkIHZpYSBhIHNwZWNpZmljIFBURQo+IGJpdCBjb21i
aW5hdGlvbi4gTmV2ZXJ0aGVsZXNzLCB0aGUgbWVtb3J5IGlzIHdyaXRhYmxlLCBhbmQgY29yZSBt
bSBjb2RlCj4gd2lsbCBuZWVkIHRvIGFwcGx5IHRoZSB3cml0YWJsZSBwZXJtaXNzaW9ucyBpbiB0
aGUgdHlwaWNhbCBwYXRocyB0aGF0Cj4gY2FsbCBwdGVfbWt3cml0ZSgpLiBGdXR1cmUgcGF0Y2hl
cyB3aWxsIG1ha2UgcHRlX21rd3JpdGUoKSB0YWtlIGEgVk1BLCBzbwo+IHRoYXQgdGhlIHg4NiBp
bXBsZW1lbnRhdGlvbiBvZiBpdCBjYW4ga25vdyB3aGV0aGVyIHRvIGNyZWF0ZSByZWd1bGFyCj4g
d3JpdGFibGUgbWVtb3J5IG9yIHNoYWRvdyBzdGFjayBtZW1vcnkuCj4gCj4gQnV0IHRoZXJlIGFy
ZSBhIGNvdXBsZSBvZiBjaGFsbGVuZ2VzIHRvIHRoaXMuIE1vZGlmeWluZyB0aGUgc2lnbmF0dXJl
cyBvZgo+IGVhY2ggYXJjaCBwdGVfbWt3cml0ZSgpIGltcGxlbWVudGF0aW9uIHdvdWxkIGJlIGVy
cm9yIHByb25lIGJlY2F1c2Ugc29tZQo+IGFyZSBnZW5lcmF0ZWQgd2l0aCBtYWNyb3MgYW5kIHdv
dWxkIG5lZWQgdG8gYmUgcmUtaW1wbGVtZW50ZWQuIEFsc28sIHNvbWUKPiBwdGVfbWt3cml0ZSgp
IGNhbGxlcnMgb3BlcmF0ZSBvbiBrZXJuZWwgbWVtb3J5IHdpdGhvdXQgYSBWTUEuCj4gCj4gU28g
dGhpcyBjYW4gYmUgZG9uZSBpbiBhIHRocmVlIHN0ZXAgcHJvY2Vzcy4gRmlyc3QgcHRlX21rd3Jp
dGUoKSBjYW4gYmUKPiByZW5hbWVkIHRvIHB0ZV9ta3dyaXRlX25vdm1hKCkgaW4gZWFjaCBhcmNo
LCB3aXRoIGEgZ2VuZXJpYyBwdGVfbWt3cml0ZSgpCj4gYWRkZWQgdGhhdCBqdXN0IGNhbGxzIHB0
ZV9ta3dyaXRlX25vdm1hKCkuIE5leHQgY2FsbGVycyB3aXRob3V0IGEgVk1BIGNhbgo+IGJlIG1v
dmVkIHRvIHB0ZV9ta3dyaXRlX25vdm1hKCkuIEFuZCBsYXN0bHksIHB0ZV9ta3dyaXRlKCkgYW5k
IGFsbCBjYWxsZXJzCj4gY2FuIGJlIGNoYW5nZWQgdG8gdGFrZS9wYXNzIGEgVk1BLgo+IAo+IFN0
YXJ0IHRoZSBwcm9jZXNzIGJ5IHJlbmFtaW5nIHB0ZV9ta3dyaXRlKCkgdG8gcHRlX21rd3JpdGVf
bm92bWEoKSBhbmQKPiBhZGRpbmcgdGhlIHB0ZV9ta3dyaXRlKCkgd3JhcHBlciBpbiBsaW51eC9w
Z3RhYmxlLmguIEFwcGx5IHRoZSBzYW1lCj4gcGF0dGVybiBmb3IgcG1kX21rd3JpdGUoKS4gU2lu
Y2Ugbm90IGFsbCBhcmNocyBoYXZlIGEgcG1kX21rd3JpdGVfbm92bWEoKSwKPiBjcmVhdGUgYSBu
ZXcgYXJjaCBjb25maWcgSEFTX0hVR0VfUEFHRSB0aGF0IGNhbiBiZSB1c2VkIHRvIHRlbGwgaWYK
PiBwbWRfbWt3cml0ZSgpIHNob3VsZCBiZSBkZWZpbmVkLiBPdGhlcndpc2UgaW4gdGhlICFIQVNf
SFVHRV9QQUdFIGNhc2VzIHRoZQo+IGNvbXBpbGVyIHdvdWxkIG5vdCBiZSBhYmxlIHRvIGZpbmQg
cG1kX21rd3JpdGVfbm92bWEoKS4KPiAKPiBObyBmdW5jdGlvbmFsIGNoYW5nZS4KPiAKPiBDYzog
bGludXgtZG9jQHZnZXIua2VybmVsLm9yZwo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnCj4gQ2M6IGxpbnV4LWFscGhhQHZnZXIua2VybmVsLm9yZwo+IENjOiBsaW51eC1zbnBzLWFy
Y0BsaXN0cy5pbmZyYWRlYWQub3JnCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwo+IENjOiBsaW51eC1jc2t5QHZnZXIua2VybmVsLm9yZwo+IENjOiBsaW51eC1oZXhh
Z29uQHZnZXIua2VybmVsLm9yZwo+IENjOiBsaW51eC1pYTY0QHZnZXIua2VybmVsLm9yZwo+IENj
OiBsb29uZ2FyY2hAbGlzdHMubGludXguZGV2Cj4gQ2M6IGxpbnV4LW02OGtAbGlzdHMubGludXgt
bTY4ay5vcmcKPiBDYzogTWljaGFsIFNpbWVrIDxtb25zdHJAbW9uc3RyLmV1Pgo+IENjOiBEaW5o
IE5ndXllbiA8ZGluZ3V5ZW5Aa2VybmVsLm9yZz4KPiBDYzogbGludXgtbWlwc0B2Z2VyLmtlcm5l
bC5vcmcKPiBDYzogb3BlbnJpc2NAbGlzdHMubGlicmVjb3Jlcy5vcmcKPiBDYzogbGludXgtcGFy
aXNjQHZnZXIua2VybmVsLm9yZwo+IENjOiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwo+
IENjOiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnCj4gQ2M6IGxpbnV4LXMzOTBAdmdl
ci5rZXJuZWwub3JnCj4gQ2M6IGxpbnV4LXNoQHZnZXIua2VybmVsLm9yZwo+IENjOiBzcGFyY2xp
bnV4QHZnZXIua2VybmVsLm9yZwo+IENjOiBsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCj4g
Q2M6IGxpbnV4LWFyY2hAdmdlci5rZXJuZWwub3JnCj4gQ2M6IGxpbnV4LW1tQGt2YWNrLm9yZwo+
IFN1Z2dlc3RlZC1ieTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4Zm91bmRhdGlvbi5v
cmc+Cj4gU2lnbmVkLW9mZi1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50
ZWwuY29tPgo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvQ0FIay09d2laalN1
N2M5c0ZZWmIzcTA0MTA4c3RnSGZmMndmYm9rR0NDZ1c3cml6KzhRQG1haWwuZ21haWwuY29tLwo+
IC0tLQo+IEhpIE5vbi14ODYgQXJjaOKAmXMsCj4gCj4geDg2IGhhcyBhIGZlYXR1cmUgdGhhdCBh
bGxvd3MgZm9yIHRoZSBjcmVhdGlvbiBvZiBhIHNwZWNpYWwgdHlwZSBvZgo+IHdyaXRhYmxlIG1l
bW9yeSAoc2hhZG93IHN0YWNrKSB0aGF0IGlzIG9ubHkgd3JpdGFibGUgaW4gbGltaXRlZCBzcGVj
aWZpYwo+IHdheXMuIFByZXZpb3VzbHksIGNoYW5nZXMgd2VyZSBwcm9wb3NlZCB0byBjb3JlIE1N
IGNvZGUgdG8gdGVhY2ggaXQgdG8KPiBkZWNpZGUgd2hlbiB0byBjcmVhdGUgbm9ybWFsbHkgd3Jp
dGFibGUgbWVtb3J5IG9yIHRoZSBzcGVjaWFsIHNoYWRvdyBzdGFjawo+IHdyaXRhYmxlIG1lbW9y
eSwgYnV0IERhdmlkIEhpbGRlbmJyYW5kIHN1Z2dlc3RlZFswXSB0byBjaGFuZ2UKPiBwWFhfbWt3
cml0ZSgpIHRvIHRha2UgYSBWTUEsIHNvIGF3YXJlbmVzcyBvZiBzaGFkb3cgc3RhY2sgbWVtb3J5
IGNhbiBiZQo+IG1vdmVkIGludG8geDg2IGNvZGUuIExhdGVyIExpbnVzIHN1Z2dlc3RlZCBhIGxl
c3MgZXJyb3ItcHJvbmUgd2F5WzFdIHRvIGdvCj4gYWJvdXQgdGhpcyBhZnRlciB0aGUgZmlyc3Qg
YXR0ZW1wdCBoYWQgYSBidWcuCj4gCj4gU2luY2UgcFhYX21rd3JpdGUoKSBpcyBkZWZpbmVkIGlu
IGV2ZXJ5IGFyY2gsIGl0IHJlcXVpcmVzIHNvbWUgdHJlZS13aWRlCj4gY2hhbmdlcy4gU28gdGhh
dCBpcyB3aHkgeW91IGFyZSBzZWVpbmcgc29tZSBwYXRjaGVzIG91dCBvZiBhIGJpZyB4ODYKPiBz
ZXJpZXMgcG9wIHVwIGluIHlvdXIgYXJjaCBtYWlsaW5nIGxpc3QuIFRoZXJlIGlzIG5vIGZ1bmN0
aW9uYWwgY2hhbmdlLgo+IEFmdGVyIHRoaXMgcmVmYWN0b3IsIHRoZSBzaGFkb3cgc3RhY2sgc2Vy
aWVzIGdvZXMgb24gdG8gdXNlIHRoZSBhcmNoCj4gaGVscGVycyB0byBwdXNoIGFyY2ggbWVtb3J5
IGRldGFpbHMgaW5zaWRlIGFyY2gveDg2IGFuZCBvdGhlciBhcmNoJ3MKPiB3aXRoIHVwY29taW5n
IHNoYWRvdyBzdGFjayBmZWF0dXJlcy4KPiAKPiBUZXN0aW5nIHdhcyBqdXN0IDAtZGF5IGJ1aWxk
IHRlc3RpbmcuCj4gCj4gSG9wZWZ1bGx5IHRoYXQgaXMgZW5vdWdoIGNvbnRleHQuIFRoYW5rcyEK
PiAKPiBbMF0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8wZTI5YTJkMC0wOGQ4LWJjZDYt
ZmYyNi00YmVhMGU0MDM3YjBAcmVkaGF0LmNvbS8KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGttbC9DQUhrLT13aVpqU3U3YzlzRllaYjNxMDQxMDhzdGdIZmYyd2Zib2tHQ0NnVzdyaXor
OFFAbWFpbC5nbWFpbC5jb20vCj4gLS0tCgpBY2tlZC1ieTogRGF2aWQgSGlsZGVuYnJhbmQgPGRh
dmlkQHJlZGhhdC5jb20+CgotLSAKQ2hlZXJzLAoKRGF2aWQgLyBkaGlsZGVuYgoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcg
bGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
