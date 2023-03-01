Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8769BC64ED6
	for <linux-um@archiver.kernel.org>; Wed,  1 Mar 2023 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:Subject:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yPfKYB1tvnlDDOwaxckPMtaJsaJ2pOmOgohd1WP6LoY=; b=bzY8VprT+zt1Ox
	P5q3v2iKgagkp/1xwFZb72fgrxz+jwIXwjUR3fm4Vre7cS228gteeEqQrIv3FvDwR9Al9BGbX+YnZ
	w6S8cxSdL/lR2Kqvqau6Tmi5pMzaI/qhW0Rh2Egj4jRWp76YzIcbeJ83wuj5GVOxMG+cYipXdjoJB
	Z2N59ZqLdgscD999yprOqv1u74JMxwJyNza1A3b0qLrbvXo306NbDxaMCqcNbJ5Eirt3SbEsMseTf
	uBBSanoI1I1EnRh5zmjESUU652kZSM8OCRkPDv2iSgBGsjBVf91iEndTyzW9C+P86fpLtcnJHfVD4
	gnhVsStekI04GnhypVzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXHdK-00FQfd-IF; Wed, 01 Mar 2023 08:16:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXHdE-00FQcb-Mu
	for linux-um@lists.infradead.org; Wed, 01 Mar 2023 08:16:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677658571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQIo0hNE1IdmdTJeAfVSWSJHdp/A2L81MbqwgQGi7/s=;
	b=Lgx4494Ki92A8P7KBec9GZ+oniD/so9S6s376pXCBfwIZbpFryYzm7VuUbDCudOmPpuazJ
	BZlYjiR+awKb7+/obJJdaVaNJPlnbEr8EXFHhRoDxhAjgvdnre76/wb2aZFcUicW5ld7qE
	AjRVQKfqtaApCJ9VvbYhapBkNy2Iiis=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-399-AyAZdZdrNsmoxgnH9vIUig-1; Wed, 01 Mar 2023 03:16:10 -0500
X-MC-Unique: AyAZdZdrNsmoxgnH9vIUig-1
Received: by mail-wm1-f70.google.com with SMTP id m28-20020a05600c3b1c00b003e7d4662b83so8026188wms.0
        for <linux-um@lists.infradead.org>; Wed, 01 Mar 2023 00:16:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQIo0hNE1IdmdTJeAfVSWSJHdp/A2L81MbqwgQGi7/s=;
        b=ve9evRITv1iCiwjyzg/XtrQR6JorNNjMey8uMI/9nxjxziUZnICWZVA2cSkV8vBOi4
         bkZNhZZChYjbUvzlbWf3mWelVWKbchdOnuoKZSQsLQMwcCjCUbHfQ0JEVsjgNPV2b/9p
         WBiANNzl5K4cpzpgvAjcm4FKn8sG7A9vU6AgGPwTlOVlrgFy4D2/KyNH9QXgVd5RFE+o
         E8cYcBMODdXkVSDkGkbESGSlcNC5tsrU9A3d4m0orp65IJ9vejZkfbx4wdsxSK2+AT5Y
         BNxjKLSWSfCfEhqkEDpG10lFtj/5tUr7deXZ/Jj2/azhKfnWMfaqyDgB6gdmzEednLLa
         QFTA==
X-Gm-Message-State: AO0yUKVGU/6ANnjc0/Kdc6lOJx/W+FnyqUP9ar22rZgxi17A2DSQvjpC
	di3J2WwjIzMR6HbxL91uYnp/LJAt36V369/K9hXpFjDnSh90glzZvKBOFD06ad+U9yR4zgwyB1N
	ZlgPUoB3nA4UU+WvM5ywAftkU
X-Received: by 2002:adf:fa42:0:b0:2c8:9cfe:9e29 with SMTP id y2-20020adffa42000000b002c89cfe9e29mr3673907wrr.38.1677658569265;
        Wed, 01 Mar 2023 00:16:09 -0800 (PST)
X-Google-Smtp-Source: AK7set/Zcp0KDYd3P+ttMa1nxfZFskB2aS7FMY5A6AFDn91vWMJGTRwO0n5U4FI/yi5+QKrlOm4zVQ==
X-Received: by 2002:adf:fa42:0:b0:2c8:9cfe:9e29 with SMTP id y2-20020adffa42000000b002c89cfe9e29mr3673883wrr.38.1677658568881;
        Wed, 01 Mar 2023 00:16:08 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id m15-20020a5d6a0f000000b002c707785da4sm11739026wru.107.2023.03.01.00.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 00:16:08 -0800 (PST)
Message-ID: <550c6035-6dd0-d215-226b-1a82dafa05d6@redhat.com>
Date: Wed, 1 Mar 2023 09:16:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, "x86@kernel.org"
 <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
 Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>,
 Cyrill Gorcunov <gorcunov@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
 Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
 Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>,
 Weijiang Yang <weijiang.yang@intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 John Allen <john.allen@amd.com>, "kcc@google.com" <kcc@google.com>,
 "eranian@google.com" <eranian@google.com>, "rppt@kernel.org"
 <rppt@kernel.org>,
 "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
 "dethoma@microsoft.com" <dethoma@microsoft.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "Andrew.Cooper3@citrix.com" <Andrew.Cooper3@citrix.com>,
 "christina.schimpe@intel.com" <christina.schimpe@intel.com>,
 "debug@rivosinc.com" <debug@rivosinc.com>
Cc: "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-14-rick.p.edgecombe@intel.com>
 <1f8b78b6-9f34-b646-68f2-eac62136b9f4@csgroup.eu>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 13/41] mm: Make pte_mkwrite() take a VMA
In-Reply-To: <1f8b78b6-9f34-b646-68f2-eac62136b9f4@csgroup.eu>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230301_001612_880786_2419DF46 
X-CRM114-Status: GOOD (  20.18  )
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

T24gMDEuMDMuMjMgMDg6MDMsIENocmlzdG9waGUgTGVyb3kgd3JvdGU6Cj4gCj4gCj4gTGUgMjcv
MDIvMjAyMyDDoCAyMzoyOSwgUmljayBFZGdlY29tYmUgYSDDqWNyaXTCoDoKPj4gVGhlIHg4NiBD
b250cm9sLWZsb3cgRW5mb3JjZW1lbnQgVGVjaG5vbG9neSAoQ0VUKSBmZWF0dXJlIGluY2x1ZGVz
IGEgbmV3Cj4+IHR5cGUgb2YgbWVtb3J5IGNhbGxlZCBzaGFkb3cgc3RhY2suIFRoaXMgc2hhZG93
IHN0YWNrIG1lbW9yeSBoYXMgc29tZQo+PiB1bnVzdWFsIHByb3BlcnRpZXMsIHdoaWNoIHJlcXVp
cmVzIHNvbWUgY29yZSBtbSBjaGFuZ2VzIHRvIGZ1bmN0aW9uCj4+IHByb3Blcmx5Lgo+Pgo+PiBP
bmUgb2YgdGhlc2UgdW51c3VhbCBwcm9wZXJ0aWVzIGlzIHRoYXQgc2hhZG93IHN0YWNrIG1lbW9y
eSBpcyB3cml0YWJsZSwKPj4gYnV0IG9ubHkgaW4gbGltaXRlZCB3YXlzLiBUaGVzZSBsaW1pdHMg
YXJlIGFwcGxpZWQgdmlhIGEgc3BlY2lmaWMgUFRFCj4+IGJpdCBjb21iaW5hdGlvbi4gTmV2ZXJ0
aGVsZXNzLCB0aGUgbWVtb3J5IGlzIHdyaXRhYmxlLCBhbmQgY29yZSBtbSBjb2RlCj4+IHdpbGwg
bmVlZCB0byBhcHBseSB0aGUgd3JpdGFibGUgcGVybWlzc2lvbnMgaW4gdGhlIHR5cGljYWwgcGF0
aHMgdGhhdAo+PiBjYWxsIHB0ZV9ta3dyaXRlKCkuCj4+Cj4+IEluIGFkZGl0aW9uIHRvIFZNX1dS
SVRFLCB0aGUgc2hhZG93IHN0YWNrIFZNQSdzIHdpbGwgaGF2ZSBhIGZsYWcgZGVub3RpbmcKPj4g
dGhhdCB0aGV5IGFyZSBzcGVjaWFsIHNoYWRvdyBzdGFjayBmbGF2b3Igb2Ygd3JpdGFibGUgbWVt
b3J5LiBTbyBtYWtlCj4+IHB0ZV9ta3dyaXRlKCkgdGFrZSBhIFZNQSwgc28gdGhhdCB0aGUgeDg2
IGltcGxlbWVudGF0aW9uIG9mIGl0IGNhbiBrbm93IHRvCj4+IGNyZWF0ZSByZWd1bGFyIHdyaXRh
YmxlIG1lbW9yeSBvciBzaGFkb3cgc3RhY2sgbWVtb3J5Lgo+Pgo+PiBBcHBseSB0aGUgc2FtZSBj
aGFuZ2VzIGZvciBwbWRfbWt3cml0ZSgpIGFuZCBodWdlX3B0ZV9ta3dyaXRlKCkuCj4gCj4gSSdt
IG5vdCBzdXJlIGl0IGlzIGEgZ29vZCBpZGVhIHRvIGFkZCBhIHNlY29uZCBhcmd1bWVudCB0bwo+
IHB0ZV9ta3dyaXRlKCkuIEFsbCBwdGVfbWt4eHh4KCkgb25seSB0YWtlIGEgcHRlIGFuZCBub3Ro
aW5nIGVsc2UuCgpXZSB0b3VjaGVkIG9uIHRoaXMgaW4gcHJldmlvdXMgcmV2aXNpb25zIGFuZCBz
byBmYXIgdGhlcmUgd2FzIG5vIHN0cm9uZyAKcHVzaCBiYWNrLiBUaGlzIHR1cm5lZCBvdXQgdG8g
YmUgY2xlYW5lciBhbmQgZWFzaWVyIHRoYW4gdGhlIAphbHRlcm5hdGl2ZXMgd2UgZXZhbHVhdGVk
LgoKcHRlX21vZGlmeSgpLCBmb3IgZXhhbXBsZSwgdGFrZXMgYW5vdGhlciBhcmd1bWVudC4gU3Vy
ZSwgd2UgY291bGQgdHJ5IAp0aGlua2luZyBhYm91dCBwYXNzaW5nIHNvbWV0aGluZyBlbHNlIHRo
YW4gYSBWTUEgdG8gaWRlbnRpZnkgdGhlIAp3cml0YWJpbGl0eSB0eXBlLCBidXQgSSBhbSBub3Qg
Y29udmluY2VkIHRoYXQgd2lsbCBsb29rIHBhcnRpY3VsYXJseSBiZXR0ZXIuCgo+IAo+IEkgdGhp
bmsgeW91IHNob3VsZCBkbyB0aGUgc2FtZSBhcyBjb21taXQgZDllZDlmYWFjMjgzICgibW06IGFk
ZCBuZXcKPiBhcmNoX21ha2VfaHVnZV9wdGUoKSBtZXRob2QgZm9yIHRpbGUgc3VwcG9ydCIpCj4g
CgpXZSBhbHJlYWR5IGhhdmUgMyBhcmNoaXRlY3R1cmVzIGludGVuZGluZyB0byBzdXBwb3J0IHNo
YWRvdyBzdGFja3MgaW4gCm9uZSB3YXkgb3IgdGhlIG90aGVyLiBSZXBsYWNpbmcgYWxsIHB0ZV9t
a3dyaXRlKCkgd2l0aCAKYXJjaF9wdGVfbWt3cml0ZSgpIGRvZXNuJ3Qgc291bmQgcGFydGljdWxh
cmx5IGFwcGVhbGluZyB0byBtZS4KCgotLSAKVGhhbmtzLAoKRGF2aWQgLyBkaGlsZGVuYgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1h
aWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
