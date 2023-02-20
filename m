Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C76C6379F
	for <linux-um@archiver.kernel.org>; Mon, 20 Feb 2023 01:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lbEUAwxd7HxcYcoQUK/GteK6FoQiQfPTBgV1lYPNEk4=; b=Y09vdudUBVJrwJ
	Ldl3ybgg8hPR883RYpKe16uEr/Cvi4Pj0KkWNSE1LZPAyvscwj1a6bWJV3kjYrWDYA46lqqOMsAdS
	u4pDc6vI9FQnjueaCSzYf0159IPyyYRDN6EdQhmMRuEBJ0mrIMFqqGzpKNoTBXi+HJeOIibkCwG94
	SVZ2x4yxN11AJhL3820+L79ne7OVhOs44Vd0n7Cf9EPIBqB8x7H6lKaXpugaKCKVX/jI54tIWQ+lV
	Jy+5+Ud5U/TjXogRbsc3aQJBTM4hheHqlcJ429BrEJ8NpIRAFN0UkpNmORIAj/miHlOtRT4UPEZId
	U2ccehqs807/E6bF2rBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pTuYN-002dnc-5B; Mon, 20 Feb 2023 01:01:15 +0000
Received: from gandalf.ozlabs.org ([150.107.74.76])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pTuYC-002dih-99; Mon, 20 Feb 2023 01:01:09 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKkcZ5RDfz4x81;
	Mon, 20 Feb 2023 12:00:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1676854853;
	bh=F/BA55hncJJcUXKiAlKImZaWKF9J7v8lLnKr9dq21p4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XslnKyUEjBPQ1U1pxlZfaOackH5Uc53v2LGKi4H/fZCzwS12mRxSKUo5Y0d1NKeZn
	 awyroz/jmv/ppUpYp1TDhtbm3Xr2UbxbQ7SLm7HpIZR367un5O+1m6RO8MFNGLc4tN
	 bOsgsJ/QSRuN9qLOaQNEAnGHLCgJYRh2AmA+hh1/q0GxiYmMbgWuXckkgvhyXESi3z
	 pkyDk+R2FxF/Bbq8WxwITYwB8LWISeRkdVED0wYKG14B7OppQx/VBH6ejWIfX4nrhf
	 +DPFJJxnIwj6xY4eD5/CyK6ZQt6qJeWIa8XOq0dKk/I3y+LAhnFdM5gYPtu4P26I4l
	 sm8Hu7By7kuYg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org, "H . Peter
 Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski
 <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov
 <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>,
 Florian Weimer <fweimer@redhat.com>, "H . J . Lu" <hjl.tools@gmail.com>,
 Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook
 <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav
 Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek
 <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap
 <rdunlap@infradead.org>, Weijiang Yang <weijiang.yang@intel.com>, "Kirill
 A . Shutemov" <kirill.shutemov@linux.intel.com>, John Allen
 <john.allen@amd.com>, kcc@google.com, eranian@google.com, rppt@kernel.org,
 jamorris@linux.microsoft.com, dethoma@microsoft.com,
 akpm@linux-foundation.org, Andrew.Cooper3@citrix.com,
 christina.schimpe@intel.com, david@redhat.com, debug@rivosinc.com
Cc: rick.p.edgecombe@intel.com, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Dinh
 Nguyen <dinguyen@kernel.org>, linux-mips@vger.kernel.org,
 openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v6 13/41] mm: Make pte_mkwrite() take a VMA
In-Reply-To: <20230218211433.26859-14-rick.p.edgecombe@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-14-rick.p.edgecombe@intel.com>
Date: Mon, 20 Feb 2023 12:00:46 +1100
Message-ID: <875ybxywu9.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230219_170104_706847_59F6060D 
X-CRM114-Status: GOOD (  16.72  )
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

UmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiB3cml0ZXM6Cj4gVGhl
IHg4NiBDb250cm9sLWZsb3cgRW5mb3JjZW1lbnQgVGVjaG5vbG9neSAoQ0VUKSBmZWF0dXJlIGlu
Y2x1ZGVzIGEgbmV3Cj4gdHlwZSBvZiBtZW1vcnkgY2FsbGVkIHNoYWRvdyBzdGFjay4gVGhpcyBz
aGFkb3cgc3RhY2sgbWVtb3J5IGhhcyBzb21lCj4gdW51c3VhbCBwcm9wZXJ0aWVzLCB3aGljaCBy
ZXF1aXJlcyBzb21lIGNvcmUgbW0gY2hhbmdlcyB0byBmdW5jdGlvbgo+IHByb3Blcmx5LgouLi4K
PiAtLS0KPiBIaSBOb24teDg2IEFyY2jigJlzLAo+Cj4geDg2IGhhcyBhIGZlYXR1cmUgdGhhdCBh
bGxvd3MgZm9yIHRoZSBjcmVhdGlvbiBvZiBhIHNwZWNpYWwgdHlwZSBvZgo+IHdyaXRhYmxlIG1l
bW9yeSAoc2hhZG93IHN0YWNrKSB0aGF0IGlzIG9ubHkgd3JpdGFibGUgaW4gbGltaXRlZCBzcGVj
aWZpYwo+IHdheXMuIFByZXZpb3VzbHksIGNoYW5nZXMgd2VyZSBwcm9wb3NlZCB0byBjb3JlIE1N
IGNvZGUgdG8gdGVhY2ggaXQgdG8KPiBkZWNpZGUgd2hlbiB0byBjcmVhdGUgbm9ybWFsbHkgd3Jp
dGFibGUgbWVtb3J5IG9yIHRoZSBzcGVjaWFsIHNoYWRvdyBzdGFjawo+IHdyaXRhYmxlIG1lbW9y
eSwgYnV0IERhdmlkIEhpbGRlbmJyYW5kIHN1Z2dlc3RlZFswXSB0byBjaGFuZ2UKPiBwWFhfbWt3
cml0ZSgpIHRvIHRha2UgYSBWTUEsIHNvIGF3YXJlbmVzcyBvZiBzaGFkb3cgc3RhY2sgbWVtb3J5
IGNhbiBiZQo+IG1vdmVkIGludG8geDg2IGNvZGUuCj4KPiBTaW5jZSBwWFhfbWt3cml0ZSgpIGlz
IGRlZmluZWQgaW4gZXZlcnkgYXJjaCwgaXQgcmVxdWlyZXMgc29tZSB0cmVlLXdpZGUKPiBjaGFu
Z2VzLiBTbyB0aGF0IGlzIHdoeSB5b3UgYXJlIHNlZWluZyBzb21lIHBhdGNoZXMgb3V0IG9mIGEg
YmlnIHg4Ngo+IHNlcmllcyBwb3AgdXAgaW4geW91ciBhcmNoIG1haWxpbmcgbGlzdC4gVGhlcmUg
aXMgbm8gZnVuY3Rpb25hbCBjaGFuZ2UuCj4gQWZ0ZXIgdGhpcyByZWZhY3RvciwgdGhlIHNoYWRv
dyBzdGFjayBzZXJpZXMgZ29lcyBvbiB0byB1c2UgdGhlIGFyY2gKPiBoZWxwZXJzIHRvIHB1c2gg
c2hhZG93IHN0YWNrIG1lbW9yeSBkZXRhaWxzIGluc2lkZSBhcmNoL3g4Ni4KLi4uCj4gLS0tCj4g
IERvY3VtZW50YXRpb24vbW0vYXJjaF9wZ3RhYmxlX2hlbHBlcnMucnN0ICAgIHwgIDkgKysrKysr
LS0tCj4gIGFyY2gvYWxwaGEvaW5jbHVkZS9hc20vcGd0YWJsZS5oICAgICAgICAgICAgIHwgIDYg
KysrKystCj4gIGFyY2gvYXJjL2luY2x1ZGUvYXNtL2h1Z2VwYWdlLmggICAgICAgICAgICAgIHwg
IDIgKy0KPiAgYXJjaC9hcmMvaW5jbHVkZS9hc20vcGd0YWJsZS1iaXRzLWFyY3YyLmggICAgfCAg
NyArKysrKystCj4gIGFyY2gvYXJtL2luY2x1ZGUvYXNtL3BndGFibGUtM2xldmVsLmggICAgICAg
IHwgIDcgKysrKysrLQo+ICBhcmNoL2FybS9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggICAgICAgICAg
ICAgICB8ICAyICstCj4gIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vcGd0YWJsZS5oICAgICAgICAg
ICAgIHwgIDQgKystLQo+ICBhcmNoL2Nza3kvaW5jbHVkZS9hc20vcGd0YWJsZS5oICAgICAgICAg
ICAgICB8ICAyICstCj4gIGFyY2gvaGV4YWdvbi9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggICAgICAg
ICAgIHwgIDIgKy0KPiAgYXJjaC9pYTY0L2luY2x1ZGUvYXNtL3BndGFibGUuaCAgICAgICAgICAg
ICAgfCAgMiArLQo+ICBhcmNoL2xvb25nYXJjaC9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggICAgICAg
ICB8ICA0ICsrLS0KPiAgYXJjaC9tNjhrL2luY2x1ZGUvYXNtL21jZl9wZ3RhYmxlLmggICAgICAg
ICAgfCAgMiArLQo+ICBhcmNoL202OGsvaW5jbHVkZS9hc20vbW90b3JvbGFfcGd0YWJsZS5oICAg
ICB8ICA2ICsrKysrLQo+ICBhcmNoL202OGsvaW5jbHVkZS9hc20vc3VuM19wZ3RhYmxlLmggICAg
ICAgICB8ICA2ICsrKysrLQo+ICBhcmNoL21pY3JvYmxhemUvaW5jbHVkZS9hc20vcGd0YWJsZS5o
ICAgICAgICB8ICAyICstCj4gIGFyY2gvbWlwcy9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggICAgICAg
ICAgICAgIHwgIDYgKysrLS0tCj4gIGFyY2gvbmlvczIvaW5jbHVkZS9hc20vcGd0YWJsZS5oICAg
ICAgICAgICAgIHwgIDIgKy0KPiAgYXJjaC9vcGVucmlzYy9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgg
ICAgICAgICAgfCAgMiArLQo+ICBhcmNoL3BhcmlzYy9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggICAg
ICAgICAgICB8ICA2ICsrKysrLQo+ICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzMy
L3BndGFibGUuaCB8ICAyICstCj4gIGFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9ib29rM3MvNjQv
cGd0YWJsZS5oIHwgIDQgKystLQo+ICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vbm9oYXNoLzMy
L3BndGFibGUuaCB8ICAyICstCj4gIGFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9ub2hhc2gvMzIv
cHRlLTh4eC5oIHwgIDIgKy0KPiAgYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL25vaGFzaC82NC9w
Z3RhYmxlLmggfCAgMiArLQoKTG9va3MgbGlrZSB5b3UgZGlzY292ZXJlZCB0aGUgam95cyBvZiBw
cGMncyBhdC1sZWFzdCA1IGRpZmZlcmVudCBNTVUKaW1wbGVtZW50YXRpb25zLCBzb3JyeSA6KQoK
QWNrZWQtYnk6IE1pY2hhZWwgRWxsZXJtYW4gPG1wZUBlbGxlcm1hbi5pZC5hdT4gKHBvd2VycGMp
CgpjaGVlcnMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
