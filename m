Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23335C636CC
	for <linux-um@archiver.kernel.org>; Mon, 20 Feb 2023 11:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EipPW3nuZBEPUycECRJ1dx4a9z3ZnLWKhWs+5mOkJKc=; b=aVrp0yWvGgUNnC
	7txzsKCQCHQTSgCBOiYIOc+kt1Dxtg29GdyLpGIetrnEXkIC+re2TyBuhYWywnDCog17SirN5fpZG
	cJnRNhzhl1VYVCZtXeWLAuim4cXylR7aD9JZFRA/Mk3vRmdfCXxIjzfe5qwLg10nM+jhDFPbddxFa
	Xu9DyJFBY8zb+M4pz94m5fIoG6UWdP7qCTb7TJx3Re3pdb/5Y5SjNwwSI2xXB7oK5Lxv6CzZaKFPu
	QIDIcgwQgHruwQBgqxDG8BxYOUrabfo8VmrjuMdF1bp+78NGNRO9qs7/hc0e/Yp5E1jcP05S1EZcw
	2ZHpFaUDN3n9WuX2tEsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pU4Gm-003qnN-7b; Mon, 20 Feb 2023 11:23:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pU4Gd-003qji-BJ
	for linux-um@lists.infradead.org; Mon, 20 Feb 2023 11:23:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676892214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JGvEUYyDyInAU1qTOkUUwH1+5Pn5/FfAg09zLJh1EcU=;
	b=LJ4z/ydlreQO2yAtfBGq5VjJCLgp297eaAHVbIuZOwUBIi2Z0QExyTv6nd/ARNoqMqdjn1
	/zMysMRY0+wYzE6vrOvE/OCyAU5zz2zZy4+k6HBeuFrxSJpfHYMdYB4k5d6NnCqUnBPAwg
	e5+N+BoK+DPErZpuJFnQdtZCGVRIc3E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-540-vabHj3HrNUi08n4eqJuxKg-1; Mon, 20 Feb 2023 06:23:33 -0500
X-MC-Unique: vabHj3HrNUi08n4eqJuxKg-1
Received: by mail-wr1-f72.google.com with SMTP id bv22-20020a0560001f1600b002c559840c76so94862wrb.3
        for <linux-um@lists.infradead.org>; Mon, 20 Feb 2023 03:23:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGvEUYyDyInAU1qTOkUUwH1+5Pn5/FfAg09zLJh1EcU=;
        b=CNFQqgHG5r4O/2NgG/r4IrU+R+ELjooReCFG/3cpsANCAAyrP3tm/k8BAroOdk+Q82
         e7WIwAj453J3ic5zMT38RW0KMFn5kLE0b3wC8wUJmLVxDQCYApkUN9XXfQFOmX5yxpYE
         7qNlxA1JVyyPTc2x6h2SYxVIQ/EQsHLC0B8bUR1ZiqVgsNEjAM7QN/uUqTKgOt/XD5rb
         gbdmdR2NMqo9ZIlI2V1EGr5HwPW2AHro6paQ46an6EZXQsdfV1rFppTFwFOvfzqf8Ppv
         pfyaAic9mOy7licoVMCFuLB7/usjmbWA+xY77tgkz2eJjHBSIW3nhUQlO7sGwKYM7Qxh
         tVpg==
X-Gm-Message-State: AO0yUKUD6pbkrmyAgdA2fwIJ5AkYSOeoNPTs6lZ7mvUDGDgxJCPkHvuE
	o233rmxNFu3mqdRIOhcBscYv6R3Qsb6o0OltvT6ZBQUXVW8bY69w5b9yUwaFTqeNB/3+Gxwdgm5
	124aVJa0IscZx2Tkihw10yrSG
X-Received: by 2002:adf:e889:0:b0:2bf:ae19:d8e4 with SMTP id d9-20020adfe889000000b002bfae19d8e4mr1431262wrm.16.1676892211957;
        Mon, 20 Feb 2023 03:23:31 -0800 (PST)
X-Google-Smtp-Source: AK7set8MwtYqrZBvXsoQ9yPZN/bwu32QfvZtBFBM6ley7E2vAkMmUmM+SZmaWRHMAwPacrP/Dgjyyg==
X-Received: by 2002:adf:e889:0:b0:2bf:ae19:d8e4 with SMTP id d9-20020adfe889000000b002bfae19d8e4mr1431211wrm.16.1676892211619;
        Mon, 20 Feb 2023 03:23:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:8300:e519:4218:a8b5:5bec? (p200300cbc7058300e5194218a8b55bec.dip0.t-ipconnect.de. [2003:cb:c705:8300:e519:4218:a8b5:5bec])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d434d000000b002c55ec7f661sm154441wrr.5.2023.02.20.03.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 03:23:30 -0800 (PST)
Message-ID: <f50daeb7-7b41-0bed-73f0-b6358169521b@redhat.com>
Date: Mon, 20 Feb 2023 12:23:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v6 13/41] mm: Make pte_mkwrite() take a VMA
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
 christina.schimpe@intel.com, debug@rivosinc.com
Cc: linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
 linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, xen-devel@lists.xenproject.org
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-14-rick.p.edgecombe@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230218211433.26859-14-rick.p.edgecombe@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230220_032335_538537_EBE2E8E8 
X-CRM114-Status: GOOD (  27.05  )
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

T24gMTguMDIuMjMgMjI6MTQsIFJpY2sgRWRnZWNvbWJlIHdyb3RlOgo+IFRoZSB4ODYgQ29udHJv
bC1mbG93IEVuZm9yY2VtZW50IFRlY2hub2xvZ3kgKENFVCkgZmVhdHVyZSBpbmNsdWRlcyBhIG5l
dwo+IHR5cGUgb2YgbWVtb3J5IGNhbGxlZCBzaGFkb3cgc3RhY2suIFRoaXMgc2hhZG93IHN0YWNr
IG1lbW9yeSBoYXMgc29tZQo+IHVudXN1YWwgcHJvcGVydGllcywgd2hpY2ggcmVxdWlyZXMgc29t
ZSBjb3JlIG1tIGNoYW5nZXMgdG8gZnVuY3Rpb24KPiBwcm9wZXJseS4KPiAKPiBPbmUgb2YgdGhl
c2UgdW51c3VhbCBwcm9wZXJ0aWVzIGlzIHRoYXQgc2hhZG93IHN0YWNrIG1lbW9yeSBpcyB3cml0
YWJsZSwKPiBidXQgb25seSBpbiBsaW1pdGVkIHdheXMuIFRoZXNlIGxpbWl0cyBhcmUgYXBwbGll
ZCB2aWEgYSBzcGVjaWZpYyBQVEUKPiBiaXQgY29tYmluYXRpb24uIE5ldmVydGhlbGVzcywgdGhl
IG1lbW9yeSBpcyB3cml0YWJsZSwgYW5kIGNvcmUgbW0gY29kZQo+IHdpbGwgbmVlZCB0byBhcHBs
eSB0aGUgd3JpdGFibGUgcGVybWlzc2lvbnMgaW4gdGhlIHR5cGljYWwgcGF0aHMgdGhhdAo+IGNh
bGwgcHRlX21rd3JpdGUoKS4KPiAKPiBJbiBhZGRpdGlvbiB0byBWTV9XUklURSwgdGhlIHNoYWRv
dyBzdGFjayBWTUEncyB3aWxsIGhhdmUgYSBmbGFnIGRlbm90aW5nCj4gdGhhdCB0aGV5IGFyZSBz
cGVjaWFsIHNoYWRvdyBzdGFjayBmbGF2b3Igb2Ygd3JpdGFibGUgbWVtb3J5LiBTbyBtYWtlCj4g
cHRlX21rd3JpdGUoKSB0YWtlIGEgVk1BLCBzbyB0aGF0IHRoZSB4ODYgaW1wbGVtZW50YXRpb24g
b2YgaXQgY2FuIGtub3cgdG8KPiBjcmVhdGUgcmVndWxhciB3cml0YWJsZSBtZW1vcnkgb3Igc2hh
ZG93IHN0YWNrIG1lbW9yeS4KPiAKPiBBcHBseSB0aGUgc2FtZSBjaGFuZ2VzIGZvciBwbWRfbWt3
cml0ZSgpIGFuZCBodWdlX3B0ZV9ta3dyaXRlKCkuCj4gCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2Uu
Cj4gCj4gQ2M6IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmcKPiBDYzogbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZwo+IENjOiBsaW51eC1hbHBoYUB2Z2VyLmtlcm5lbC5vcmcKPiBDYzogbGlu
dXgtc25wcy1hcmNAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IENjOiBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKPiBDYzogbGludXgtY3NreUB2Z2VyLmtlcm5lbC5vcmcKPiBDYzog
bGludXgtaGV4YWdvbkB2Z2VyLmtlcm5lbC5vcmcKPiBDYzogbGludXgtaWE2NEB2Z2VyLmtlcm5l
bC5vcmcKPiBDYzogbG9vbmdhcmNoQGxpc3RzLmxpbnV4LmRldgo+IENjOiBsaW51eC1tNjhrQGxp
c3RzLmxpbnV4LW02OGsub3JnCj4gQ2M6IE1pY2hhbCBTaW1layA8bW9uc3RyQG1vbnN0ci5ldT4K
PiBDYzogRGluaCBOZ3V5ZW4gPGRpbmd1eWVuQGtlcm5lbC5vcmc+Cj4gQ2M6IGxpbnV4LW1pcHNA
dmdlci5rZXJuZWwub3JnCj4gQ2M6IG9wZW5yaXNjQGxpc3RzLmxpYnJlY29yZXMub3JnCj4gQ2M6
IGxpbnV4LXBhcmlzY0B2Z2VyLmtlcm5lbC5vcmcKPiBDYzogbGludXhwcGMtZGV2QGxpc3RzLm96
bGFicy5vcmcKPiBDYzogbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IENjOiBsaW51
eC1zMzkwQHZnZXIua2VybmVsLm9yZwo+IENjOiBsaW51eC1zaEB2Z2VyLmtlcm5lbC5vcmcKPiBD
Yzogc3BhcmNsaW51eEB2Z2VyLmtlcm5lbC5vcmcKPiBDYzogbGludXgtdW1AbGlzdHMuaW5mcmFk
ZWFkLm9yZwo+IENjOiB4ZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmcKPiBDYzogbGludXgt
YXJjaEB2Z2VyLmtlcm5lbC5vcmcKPiBDYzogbGludXgtbW1Aa3ZhY2sub3JnCj4gVGVzdGVkLWJ5
OiBQZW5nZmVpIFh1IDxwZW5nZmVpLnh1QGludGVsLmNvbT4KPiBTdWdnZXN0ZWQtYnk6IERhdmlk
IEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFJpY2sgRWRn
ZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4KPiAKPiAtLS0KPiBIaSBOb24teDg2
IEFyY2jigJlzLAo+IAo+IHg4NiBoYXMgYSBmZWF0dXJlIHRoYXQgYWxsb3dzIGZvciB0aGUgY3Jl
YXRpb24gb2YgYSBzcGVjaWFsIHR5cGUgb2YKPiB3cml0YWJsZSBtZW1vcnkgKHNoYWRvdyBzdGFj
aykgdGhhdCBpcyBvbmx5IHdyaXRhYmxlIGluIGxpbWl0ZWQgc3BlY2lmaWMKPiB3YXlzLiBQcmV2
aW91c2x5LCBjaGFuZ2VzIHdlcmUgcHJvcG9zZWQgdG8gY29yZSBNTSBjb2RlIHRvIHRlYWNoIGl0
IHRvCj4gZGVjaWRlIHdoZW4gdG8gY3JlYXRlIG5vcm1hbGx5IHdyaXRhYmxlIG1lbW9yeSBvciB0
aGUgc3BlY2lhbCBzaGFkb3cgc3RhY2sKPiB3cml0YWJsZSBtZW1vcnksIGJ1dCBEYXZpZCBIaWxk
ZW5icmFuZCBzdWdnZXN0ZWRbMF0gdG8gY2hhbmdlCj4gcFhYX21rd3JpdGUoKSB0byB0YWtlIGEg
Vk1BLCBzbyBhd2FyZW5lc3Mgb2Ygc2hhZG93IHN0YWNrIG1lbW9yeSBjYW4gYmUKPiBtb3ZlZCBp
bnRvIHg4NiBjb2RlLgo+IAo+IFNpbmNlIHBYWF9ta3dyaXRlKCkgaXMgZGVmaW5lZCBpbiBldmVy
eSBhcmNoLCBpdCByZXF1aXJlcyBzb21lIHRyZWUtd2lkZQo+IGNoYW5nZXMuIFNvIHRoYXQgaXMg
d2h5IHlvdSBhcmUgc2VlaW5nIHNvbWUgcGF0Y2hlcyBvdXQgb2YgYSBiaWcgeDg2Cj4gc2VyaWVz
IHBvcCB1cCBpbiB5b3VyIGFyY2ggbWFpbGluZyBsaXN0LiBUaGVyZSBpcyBubyBmdW5jdGlvbmFs
IGNoYW5nZS4KPiBBZnRlciB0aGlzIHJlZmFjdG9yLCB0aGUgc2hhZG93IHN0YWNrIHNlcmllcyBn
b2VzIG9uIHRvIHVzZSB0aGUgYXJjaAo+IGhlbHBlcnMgdG8gcHVzaCBzaGFkb3cgc3RhY2sgbWVt
b3J5IGRldGFpbHMgaW5zaWRlIGFyY2gveDg2Lgo+IAo+IFRlc3Rpbmcgd2FzIGp1c3QgMC1kYXkg
YnVpbGQgdGVzdGluZy4KPiAKPiBIb3BlZnVsbHkgdGhhdCBpcyBlbm91Z2ggY29udGV4dC4gVGhh
bmtzIQo+IAo+IFswXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzBlMjlhMmQwLTA4ZDgt
YmNkNi1mZjI2LTRiZWEwZTQwMzdiMEByZWRoYXQuY29tLyN0Cj4gCj4gdjY6Cj4gICAtIE5ldyBw
YXRjaAo+IC0tLQo+ICAgRG9jdW1lbnRhdGlvbi9tbS9hcmNoX3BndGFibGVfaGVscGVycy5yc3Qg
ICAgfCAgOSArKysrKystLS0KPiAgIGFyY2gvYWxwaGEvaW5jbHVkZS9hc20vcGd0YWJsZS5oICAg
ICAgICAgICAgIHwgIDYgKysrKystCj4gICBhcmNoL2FyYy9pbmNsdWRlL2FzbS9odWdlcGFnZS5o
ICAgICAgICAgICAgICB8ICAyICstCj4gICBhcmNoL2FyYy9pbmNsdWRlL2FzbS9wZ3RhYmxlLWJp
dHMtYXJjdjIuaCAgICB8ICA3ICsrKysrKy0KPiAgIGFyY2gvYXJtL2luY2x1ZGUvYXNtL3BndGFi
bGUtM2xldmVsLmggICAgICAgIHwgIDcgKysrKysrLQo+ICAgYXJjaC9hcm0vaW5jbHVkZS9hc20v
cGd0YWJsZS5oICAgICAgICAgICAgICAgfCAgMiArLQo+ICAgYXJjaC9hcm02NC9pbmNsdWRlL2Fz
bS9wZ3RhYmxlLmggICAgICAgICAgICAgfCAgNCArKy0tCj4gICBhcmNoL2Nza3kvaW5jbHVkZS9h
c20vcGd0YWJsZS5oICAgICAgICAgICAgICB8ICAyICstCj4gICBhcmNoL2hleGFnb24vaW5jbHVk
ZS9hc20vcGd0YWJsZS5oICAgICAgICAgICB8ICAyICstCj4gICBhcmNoL2lhNjQvaW5jbHVkZS9h
c20vcGd0YWJsZS5oICAgICAgICAgICAgICB8ICAyICstCj4gICBhcmNoL2xvb25nYXJjaC9pbmNs
dWRlL2FzbS9wZ3RhYmxlLmggICAgICAgICB8ICA0ICsrLS0KPiAgIGFyY2gvbTY4ay9pbmNsdWRl
L2FzbS9tY2ZfcGd0YWJsZS5oICAgICAgICAgIHwgIDIgKy0KPiAgIGFyY2gvbTY4ay9pbmNsdWRl
L2FzbS9tb3Rvcm9sYV9wZ3RhYmxlLmggICAgIHwgIDYgKysrKystCj4gICBhcmNoL202OGsvaW5j
bHVkZS9hc20vc3VuM19wZ3RhYmxlLmggICAgICAgICB8ICA2ICsrKysrLQo+ICAgYXJjaC9taWNy
b2JsYXplL2luY2x1ZGUvYXNtL3BndGFibGUuaCAgICAgICAgfCAgMiArLQo+ICAgYXJjaC9taXBz
L2luY2x1ZGUvYXNtL3BndGFibGUuaCAgICAgICAgICAgICAgfCAgNiArKystLS0KPiAgIGFyY2gv
bmlvczIvaW5jbHVkZS9hc20vcGd0YWJsZS5oICAgICAgICAgICAgIHwgIDIgKy0KPiAgIGFyY2gv
b3BlbnJpc2MvaW5jbHVkZS9hc20vcGd0YWJsZS5oICAgICAgICAgIHwgIDIgKy0KPiAgIGFyY2gv
cGFyaXNjL2luY2x1ZGUvYXNtL3BndGFibGUuaCAgICAgICAgICAgIHwgIDYgKysrKystCj4gICBh
cmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzMyL3BndGFibGUuaCB8ICAyICstCj4gICBh
cmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzY0L3BndGFibGUuaCB8ICA0ICsrLS0KPiAg
IGFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9ub2hhc2gvMzIvcGd0YWJsZS5oIHwgIDIgKy0KPiAg
IGFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9ub2hhc2gvMzIvcHRlLTh4eC5oIHwgIDIgKy0KPiAg
IGFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9ub2hhc2gvNjQvcGd0YWJsZS5oIHwgIDIgKy0KPiAg
IGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vcGd0YWJsZS5oICAgICAgICAgICAgIHwgIDYgKysrLS0t
Cj4gICBhcmNoL3MzOTAvaW5jbHVkZS9hc20vaHVnZXRsYi5oICAgICAgICAgICAgICB8ICA0ICsr
LS0KPiAgIGFyY2gvczM5MC9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggICAgICAgICAgICAgIHwgIDQg
KystLQo+ICAgYXJjaC9zaC9pbmNsdWRlL2FzbS9wZ3RhYmxlXzMyLmggICAgICAgICAgICAgfCAx
MCArKysrKysrKy0tCj4gICBhcmNoL3NwYXJjL2luY2x1ZGUvYXNtL3BndGFibGVfMzIuaCAgICAg
ICAgICB8ICAyICstCj4gICBhcmNoL3NwYXJjL2luY2x1ZGUvYXNtL3BndGFibGVfNjQuaCAgICAg
ICAgICB8ICA2ICsrKy0tLQo+ICAgYXJjaC91bS9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggICAgICAg
ICAgICAgICAgfCAgMiArLQo+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20vcGd0YWJsZS5oICAgICAg
ICAgICAgICAgfCAgNiArKysrLS0KPiAgIGFyY2gveHRlbnNhL2luY2x1ZGUvYXNtL3BndGFibGUu
aCAgICAgICAgICAgIHwgIDIgKy0KPiAgIGluY2x1ZGUvYXNtLWdlbmVyaWMvaHVnZXRsYi5oICAg
ICAgICAgICAgICAgIHwgIDQgKystLQo+ICAgaW5jbHVkZS9saW51eC9tbS5oICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgMiArLQo+ICAgbW0vZGVidWdfdm1fcGd0YWJsZS5jICAgICAgICAg
ICAgICAgICAgICAgICAgfCAxNiArKysrKysrKy0tLS0tLS0tCj4gICBtbS9odWdlX21lbW9yeS5j
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA2ICsrKy0tLQo+ICAgbW0vaHVnZXRsYi5j
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArKy0tCj4gICBtbS9tZW1vcnku
YyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0ICsrLS0KPiAgIG1tL21pZ3Jh
dGVfZGV2aWNlLmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0KPiAgIG1tL21wcm90
ZWN0LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0KPiAgIG1tL3VzZXJm
YXVsdGZkLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0KPiAgIDQyIGZpbGVz
IGNoYW5nZWQsIDEwNiBpbnNlcnRpb25zKCspLCA2OSBkZWxldGlvbnMoLSkKClRoYXQgbG9va3Mg
cGFpbmZ1bCBidXQgSU1ITyB3b3J0aCBpdCA6KQoKQWNrZWQtYnk6IERhdmlkIEhpbGRlbmJyYW5k
IDxkYXZpZEByZWRoYXQuY29tPgoKLS0gClRoYW5rcywKCkRhdmlkIC8gZGhpbGRlbmIKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWls
aW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
