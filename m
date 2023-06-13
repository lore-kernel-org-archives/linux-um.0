Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2D2C88CB6
	for <linux-um@archiver.kernel.org>; Tue, 13 Jun 2023 07:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NSA87fcxYuNqU3LGvBXkrXYfAKjS4gUHlgXM0ZV9o0s=; b=NFIibWU4Hxl9T8
	48RH5esptrrO9fe2GH991C9eSx57+Y01X2ZhYdwIyX8Nn4Ra6ygut6FWqX8ryctZqrRs8Wc2ybaJn
	dsuK70X9F2p8s136y/hL8kxU3stRdHTK47JipRQzGVkeoIR2GpZMDVQ8atM5awusjCbWnSiZ5gPSB
	GP8xlpcyTCafTJ4aBFL3n+759dusKh8rbXNL9BIM2RocagX9xLac1Ju0CPFPt/FjLTB1Wulslp+gr
	dWeZLPxT5MZoasn2ZUoauzPNl3HEYGahdkIn5f7obydOH7Kvno15y2Egl8YEzydmwIx2sbAkdTuvw
	kqxV15wxvtFDerdplVkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8yK4-007CJi-1a;
	Tue, 13 Jun 2023 07:20:12 +0000
Received: from mail-yw1-f173.google.com ([209.85.128.173])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8yJz-007CIU-2E;
	Tue, 13 Jun 2023 07:20:09 +0000
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-56cf34a3c72so33025867b3.1;
        Tue, 13 Jun 2023 00:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686640806; x=1689232806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fbl6hTPLrmpSWav/3sGvPZAOIrvUN7WR7CUdowhVquE=;
        b=dmYOqD7fTsDnK7bXev4RkWwaSrza/zxJZAwKaXiJxPXWHYibblal3rTCLjvQnJkjvD
         Fp/wyRLbh781vNEh9HNSrkch9z/TxE6ER4IZ39YAtzSu8LDL4xvIi86w54RyF0uudlFk
         zMz0zASOXoHhqvN6uYXWE70noePD9qW6soCC3uS05IgyUbQEfTyyrMKjDEevC2yvLz78
         +1WVo2bYtkGnNSoqPiEwVDLccUbfgmb5FqloXbZPzQM77n66jTgN32Bch01EzNMYPq64
         sE+YiFxTrQSEYqNw/gsT1R0nZC2axXx64ZbOH4/0t0z57jMxxXYQWoGGbvDC1qpa8MGH
         SGKg==
X-Gm-Message-State: AC+VfDz06rTy1pXTy5SO5tiJeiXuZTV5SEaPw/X49QEwL9X+4JaaPh6u
	IdBl4P6m6JVWwTMCP/Pdo0sJxBDNwReVeatL
X-Google-Smtp-Source: ACHHUZ4C1kc2uUECzKCkuBdvkEjVhrIFdlTq6LuTGJTmqrfjUTm51nr6peuOyLi21WG2VgLgtDlAHA==
X-Received: by 2002:a81:fd02:0:b0:56c:f371:557b with SMTP id g2-20020a81fd02000000b0056cf371557bmr1053715ywn.19.1686640806200;
        Tue, 13 Jun 2023 00:20:06 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id d5-20020a816805000000b00565374c5962sm3035703ywc.98.2023.06.13.00.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 00:20:05 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-bc4651e3838so3370730276.2;
        Tue, 13 Jun 2023 00:20:05 -0700 (PDT)
X-Received: by 2002:a25:b191:0:b0:ba8:3bc0:4d19 with SMTP id
 h17-20020a25b191000000b00ba83bc04d19mr680890ybj.28.1686640784641; Tue, 13 Jun
 2023 00:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com> <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
In-Reply-To: <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 13 Jun 2023 09:19:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX7K-9gXuOM3KkFieM_W2-Sbb3AVZ-sR65abRMdSBux5A@mail.gmail.com>
Message-ID: <CAMuHMdX7K-9gXuOM3KkFieM_W2-Sbb3AVZ-sR65abRMdSBux5A@mail.gmail.com>
Subject: Re: [PATCH v9 01/42] mm: Rename arch pte_mkwrite()'s to pte_mkwrite_novma()
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, 
	Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, 
	Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Weijiang Yang <weijiang.yang@intel.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, John Allen <john.allen@amd.com>, kcc@google.com, 
	eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com, 
	dethoma@microsoft.com, akpm@linux-foundation.org, Andrew.Cooper3@citrix.com, 
	christina.schimpe@intel.com, david@redhat.com, debug@rivosinc.com, 
	szabolcs.nagy@arm.com, torvalds@linux-foundation.org, broonie@kernel.org, 
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, linux-mips@vger.kernel.org, 
	openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	Linus Torvalds <torvalds@linuxfoundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_002007_733428_6AF6564C 
X-CRM114-Status: GOOD (  29.39  )
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

T24gVHVlLCBKdW4gMTMsIDIwMjMgYXQgMjoxM+KAr0FNIFJpY2sgRWRnZWNvbWJlCjxyaWNrLnAu
ZWRnZWNvbWJlQGludGVsLmNvbT4gd3JvdGU6Cj4gVGhlIHg4NiBTaGFkb3cgc3RhY2sgZmVhdHVy
ZSBpbmNsdWRlcyBhIG5ldyB0eXBlIG9mIG1lbW9yeSBjYWxsZWQgc2hhZG93Cj4gc3RhY2suIFRo
aXMgc2hhZG93IHN0YWNrIG1lbW9yeSBoYXMgc29tZSB1bnVzdWFsIHByb3BlcnRpZXMsIHdoaWNo
IHJlcXVpcmVzCj4gc29tZSBjb3JlIG1tIGNoYW5nZXMgdG8gZnVuY3Rpb24gcHJvcGVybHkuCj4K
PiBPbmUgb2YgdGhlc2UgdW51c3VhbCBwcm9wZXJ0aWVzIGlzIHRoYXQgc2hhZG93IHN0YWNrIG1l
bW9yeSBpcyB3cml0YWJsZSwKPiBidXQgb25seSBpbiBsaW1pdGVkIHdheXMuIFRoZXNlIGxpbWl0
cyBhcmUgYXBwbGllZCB2aWEgYSBzcGVjaWZpYyBQVEUKPiBiaXQgY29tYmluYXRpb24uIE5ldmVy
dGhlbGVzcywgdGhlIG1lbW9yeSBpcyB3cml0YWJsZSwgYW5kIGNvcmUgbW0gY29kZQo+IHdpbGwg
bmVlZCB0byBhcHBseSB0aGUgd3JpdGFibGUgcGVybWlzc2lvbnMgaW4gdGhlIHR5cGljYWwgcGF0
aHMgdGhhdAo+IGNhbGwgcHRlX21rd3JpdGUoKS4gRnV0dXJlIHBhdGNoZXMgd2lsbCBtYWtlIHB0
ZV9ta3dyaXRlKCkgdGFrZSBhIFZNQSwgc28KPiB0aGF0IHRoZSB4ODYgaW1wbGVtZW50YXRpb24g
b2YgaXQgY2FuIGtub3cgd2hldGhlciB0byBjcmVhdGUgcmVndWxhcgo+IHdyaXRhYmxlIG1lbW9y
eSBvciBzaGFkb3cgc3RhY2sgbWVtb3J5Lgo+Cj4gQnV0IHRoZXJlIGFyZSBhIGNvdXBsZSBvZiBj
aGFsbGVuZ2VzIHRvIHRoaXMuIE1vZGlmeWluZyB0aGUgc2lnbmF0dXJlcyBvZgo+IGVhY2ggYXJj
aCBwdGVfbWt3cml0ZSgpIGltcGxlbWVudGF0aW9uIHdvdWxkIGJlIGVycm9yIHByb25lIGJlY2F1
c2Ugc29tZQo+IGFyZSBnZW5lcmF0ZWQgd2l0aCBtYWNyb3MgYW5kIHdvdWxkIG5lZWQgdG8gYmUg
cmUtaW1wbGVtZW50ZWQuIEFsc28sIHNvbWUKPiBwdGVfbWt3cml0ZSgpIGNhbGxlcnMgb3BlcmF0
ZSBvbiBrZXJuZWwgbWVtb3J5IHdpdGhvdXQgYSBWTUEuCj4KPiBTbyB0aGlzIGNhbiBiZSBkb25l
IGluIGEgdGhyZWUgc3RlcCBwcm9jZXNzLiBGaXJzdCBwdGVfbWt3cml0ZSgpIGNhbiBiZQo+IHJl
bmFtZWQgdG8gcHRlX21rd3JpdGVfbm92bWEoKSBpbiBlYWNoIGFyY2gsIHdpdGggYSBnZW5lcmlj
IHB0ZV9ta3dyaXRlKCkKPiBhZGRlZCB0aGF0IGp1c3QgY2FsbHMgcHRlX21rd3JpdGVfbm92bWEo
KS4gTmV4dCBjYWxsZXJzIHdpdGhvdXQgYSBWTUEgY2FuCj4gYmUgbW92ZWQgdG8gcHRlX21rd3Jp
dGVfbm92bWEoKS4gQW5kIGxhc3RseSwgcHRlX21rd3JpdGUoKSBhbmQgYWxsIGNhbGxlcnMKPiBj
YW4gYmUgY2hhbmdlZCB0byB0YWtlL3Bhc3MgYSBWTUEuCj4KPiBTdGFydCB0aGUgcHJvY2VzcyBi
eSByZW5hbWluZyBwdGVfbWt3cml0ZSgpIHRvIHB0ZV9ta3dyaXRlX25vdm1hKCkgYW5kCj4gYWRk
aW5nIHRoZSBwdGVfbWt3cml0ZSgpIHdyYXBwZXIgaW4gbGludXgvcGd0YWJsZS5oLiBBcHBseSB0
aGUgc2FtZQo+IHBhdHRlcm4gZm9yIHBtZF9ta3dyaXRlKCkuIFNpbmNlIG5vdCBhbGwgYXJjaHMg
aGF2ZSBhIHBtZF9ta3dyaXRlX25vdm1hKCksCj4gY3JlYXRlIGEgbmV3IGFyY2ggY29uZmlnIEhB
U19IVUdFX1BBR0UgdGhhdCBjYW4gYmUgdXNlZCB0byB0ZWxsIGlmCj4gcG1kX21rd3JpdGUoKSBz
aG91bGQgYmUgZGVmaW5lZC4gT3RoZXJ3aXNlIGluIHRoZSAhSEFTX0hVR0VfUEFHRSBjYXNlcyB0
aGUKPiBjb21waWxlciB3b3VsZCBub3QgYmUgYWJsZSB0byBmaW5kIHBtZF9ta3dyaXRlX25vdm1h
KCkuCj4KPiBObyBmdW5jdGlvbmFsIGNoYW5nZS4KPgo+IENjOiBsaW51eC1kb2NAdmdlci5rZXJu
ZWwub3JnCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKPiBDYzogbGludXgtYWxw
aGFAdmdlci5rZXJuZWwub3JnCj4gQ2M6IGxpbnV4LXNucHMtYXJjQGxpc3RzLmluZnJhZGVhZC5v
cmcKPiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCj4gQ2M6IGxpbnV4
LWNza3lAdmdlci5rZXJuZWwub3JnCj4gQ2M6IGxpbnV4LWhleGFnb25Admdlci5rZXJuZWwub3Jn
Cj4gQ2M6IGxpbnV4LWlhNjRAdmdlci5rZXJuZWwub3JnCj4gQ2M6IGxvb25nYXJjaEBsaXN0cy5s
aW51eC5kZXYKPiBDYzogbGludXgtbTY4a0BsaXN0cy5saW51eC1tNjhrLm9yZwo+IENjOiBNaWNo
YWwgU2ltZWsgPG1vbnN0ckBtb25zdHIuZXU+Cj4gQ2M6IERpbmggTmd1eWVuIDxkaW5ndXllbkBr
ZXJuZWwub3JnPgo+IENjOiBsaW51eC1taXBzQHZnZXIua2VybmVsLm9yZwo+IENjOiBvcGVucmlz
Y0BsaXN0cy5saWJyZWNvcmVzLm9yZwo+IENjOiBsaW51eC1wYXJpc2NAdmdlci5rZXJuZWwub3Jn
Cj4gQ2M6IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnCj4gQ2M6IGxpbnV4LXJpc2N2QGxp
c3RzLmluZnJhZGVhZC5vcmcKPiBDYzogbGludXgtczM5MEB2Z2VyLmtlcm5lbC5vcmcKPiBDYzog
bGludXgtc2hAdmdlci5rZXJuZWwub3JnCj4gQ2M6IHNwYXJjbGludXhAdmdlci5rZXJuZWwub3Jn
Cj4gQ2M6IGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBDYzogbGludXgtYXJjaEB2Z2Vy
Lmtlcm5lbC5vcmcKPiBDYzogbGludXgtbW1Aa3ZhY2sub3JnCj4gU3VnZ2VzdGVkLWJ5OiBMaW51
cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXhmb3VuZGF0aW9uLm9yZz4KPiBTaWduZWQtb2ZmLWJ5
OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+Cj4gTGluazogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9DQUhrLT13aVpqU3U3YzlzRllaYjNxMDQxMDhzdGdI
ZmYyd2Zib2tHQ0NnVzdyaXorOFFAbWFpbC5nbWFpbC5jb20vCgo+ICBhcmNoL202OGsvaW5jbHVk
ZS9hc20vbWNmX3BndGFibGUuaCAgICAgICAgICB8ICAyICstCj4gIGFyY2gvbTY4ay9pbmNsdWRl
L2FzbS9tb3Rvcm9sYV9wZ3RhYmxlLmggICAgIHwgIDIgKy0KPiAgYXJjaC9tNjhrL2luY2x1ZGUv
YXNtL3N1bjNfcGd0YWJsZS5oICAgICAgICAgfCAgMiArLQoKQWNrZWQtYnk6IEdlZXJ0IFV5dHRl
cmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+CgpHcntvZXRqZSxlZXRpbmd9cywKCiAgICAg
ICAgICAgICAgICAgICAgICAgIEdlZXJ0CgotLSAKR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJl
J3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZwoKSW4g
cGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNl
bGYgYSBoYWNrZXIuIEJ1dAp3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBz
YXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtdW0K
