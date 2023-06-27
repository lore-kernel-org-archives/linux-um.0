Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F3CEB64DD
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 17:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vO+KLXuOjXBxR62Mm28GZXobrBBJYfSLEV/FIkQkEhw=; b=vjUHiftdAfvWMD
	qRrKlVUfPH16SMsoc3zMl5oEBfVJhallhLMOJYDRFIkqGM19lUYdLIXtADwDB7+r+wIZM5N3akgKV
	YKU63kuD16zvbj4P/btLvmPNyWHWd37R3/IMYMv2DcsJvgNSLUQT7nSBA6CZRzHJfs8bG7ctT7RVo
	ET7mvtFmjiIfyv7sk+4poMEmsZ+JYCDctX+iAbXaE8enutFSr2fX0TAINUs5XU4F1fLVGNnwsEvkf
	JhRasx4vvgsSI7kpb9q6IqGYJp3s9eyacIg0LEfZZwJYrppe8Xq9tN+ax2WoJtLhb+dlPmcGE/DuS
	AF0U/bEoZzjvWAcm6B+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qECrQ-00Dlit-0r;
	Tue, 27 Jun 2023 17:52:16 +0000
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qECrM-00DlhX-15;
	Tue, 27 Jun 2023 17:52:13 +0000
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b73b839025so2711578a34.1;
        Tue, 27 Jun 2023 10:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687888331; x=1690480331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ya0gjT04wvrkPEwxsIo0SrjOZFrw43ACMJ5aI2sBKGs=;
        b=jU0XSQm/UgQNqhqQcjqaxOHJKL3Tu8GM/GwEobHZGDkP+x8DVdgSjRkU85h/Lj/+te
         oZwK4Q1yO37Pzbn1i7oZRsd+yfivOXZX9DLv/iX+OOzSZ/17s4ytR4cUrCKbaq8ScVjb
         y4NBy98BQyt8WGI73+o5s1aq7cUaSdPW95ULfQ6FlPkdUprfA5PQkMvKjJsZAGVBcKqi
         qlieckJVpQyRqbWlQMoi71Q4k95ldkAZz69rpAi1h8kLQ3wxt3idqYMSWF1Mqn3mJooy
         Rs2GGbK0m2G7LUgnIAcus/1X+0dgeX1Usy3dZ/2MF2ihQvsHs5fE8nG3/WrSESAbmo+3
         LPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687888331; x=1690480331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ya0gjT04wvrkPEwxsIo0SrjOZFrw43ACMJ5aI2sBKGs=;
        b=JMA3ncht5W41VSpI8r9rhRtndNRMXQGWbCClmUGctbPisFmNq+Bvz7g+bulpEWyDYt
         Ds/VSLgxXWubPB7UZuPMBdBH7OOsu+ztoAek8ue8uG64FyYanB96JeZoXVn7/mKq05sk
         Gs5oLtV5BS18Jbs4TEXkHxAOO7/+wPRcqc9qmjNCg2x+vtZLssjW/25KpMyd1QECiDiE
         fwJIS/5PEsVU85tpCWPyQBnF4+/O7nG9vExiKTfH+TgfcrUaIUB+bWKjgnnA1ZelfqVC
         L1HR8GHZLirZghfR+LLpvm5k4ir3mNKPiLF/eTN+e7T9OFmm157M77kz59z0LW754cIt
         KGig==
X-Gm-Message-State: AC+VfDypqpYj17ij2gHhrpgE2lXFIF1azKplqc//v3iHOVG9HuMKWWGA
	LYWBGC+fRLNh1Kfhp2G9TQWj9ShO/osbr/8Zxvo=
X-Google-Smtp-Source: ACHHUZ60PXVLGXFjCZbPL4+H89P+QaultgII2fPTXJpRhifF/y6voZRlslPkfFetToA56imkT1WhjHNqMU1RYiBUm6M=
X-Received: by 2002:a05:6359:d23:b0:133:a55:7e26 with SMTP id
 gp35-20020a0563590d2300b001330a557e26mr5444430rwb.7.1687888330839; Tue, 27
 Jun 2023 10:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230627031431.29653-1-vishal.moola@gmail.com>
 <20230627031431.29653-4-vishal.moola@gmail.com> <ZJsJT9dLtxaKlxVb@x1n>
In-Reply-To: <ZJsJT9dLtxaKlxVb@x1n>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Tue, 27 Jun 2023 10:51:59 -0700
Message-ID: <CAOzc2pw2U2XvMcaEdy18UYe=5=PeCBn_qLR_3ns8_nWvgSSDQw@mail.gmail.com>
Subject: Re: [PATCH v6 03/33] pgtable: Create struct ptdesc
To: Peter Xu <peterx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org, 
	Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_105212_373112_ECC94F93 
X-CRM114-Status: GOOD (  15.32  )
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

T24gVHVlLCBKdW4gMjcsIDIwMjMgYXQgOTowN+KAr0FNIFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4KPiBPbiBNb24sIEp1biAyNiwgMjAyMyBhdCAwODoxNDowMVBNIC0wNzAw
LCBWaXNoYWwgTW9vbGEgKE9yYWNsZSkgd3JvdGU6Cj4gPiBDdXJyZW50bHksIHBhZ2UgdGFibGUg
aW5mb3JtYXRpb24gaXMgc3RvcmVkIHdpdGhpbiBzdHJ1Y3QgcGFnZS4gQXMgcGFydAo+ID4gb2Yg
c2ltcGxpZnlpbmcgc3RydWN0IHBhZ2UsIGNyZWF0ZSBzdHJ1Y3QgcHRkZXNjIGZvciBwYWdlIHRh
YmxlCj4gPiBpbmZvcm1hdGlvbi4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBWaXNoYWwgTW9vbGEg
KE9yYWNsZSkgPHZpc2hhbC5tb29sYUBnbWFpbC5jb20+Cj4gPiBBY2tlZC1ieTogTWlrZSBSYXBv
cG9ydCAoSUJNKSA8cnBwdEBrZXJuZWwub3JnPgo+ID4gLS0tCj4gPiAgaW5jbHVkZS9saW51eC9w
Z3RhYmxlLmggfCA2OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA2OCBpbnNlcnRpb25zKCspCj4gPgo+ID4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvcGd0YWJsZS5oIGIvaW5jbHVkZS9saW51eC9wZ3RhYmxlLmgKPiA+IGlu
ZGV4IDUwNjNiNDgyZTM0Zi4uZDQ2Y2I3MDljZTA4IDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS9s
aW51eC9wZ3RhYmxlLmgKPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvcGd0YWJsZS5oCj4gPiBAQCAt
OTg3LDYgKzk4Nyw3NCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcHRlcF9tb2RpZnlfcHJvdF9jb21t
aXQoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsCj4gPiAgI2VuZGlmIC8qIF9fSEFWRV9BUkNI
X1BURVBfTU9ESUZZX1BST1RfVFJBTlNBQ1RJT04gKi8KPiA+ICAjZW5kaWYgLyogQ09ORklHX01N
VSAqLwo+ID4KPiA+ICsKPiA+ICsvKioKPiA+ICsgKiBzdHJ1Y3QgcHRkZXNjIC0gICAgTWVtb3J5
IGRlc2NyaXB0b3IgZm9yIHBhZ2UgdGFibGVzLgo+ID4gKyAqIEBfX3BhZ2VfZmxhZ3M6ICAgICBT
YW1lIGFzIHBhZ2UgZmxhZ3MuIFVudXNlZCBmb3IgcGFnZSB0YWJsZXMuCj4gPiArICogQHB0X3Jj
dV9oZWFkOiAgICAgIEZvciBmcmVlaW5nIHBhZ2UgdGFibGUgcGFnZXMuCj4gPiArICogQHB0X2xp
c3Q6ICAgICAgICAgIExpc3Qgb2YgdXNlZCBwYWdlIHRhYmxlcy4gVXNlZCBmb3IgczM5MCBhbmQg
eDg2Lgo+ID4gKyAqIEBfcHRfcGFkXzE6ICAgICAgICBQYWRkaW5nIHRoYXQgYWxpYXNlcyB3aXRo
IHBhZ2UncyBjb21wb3VuZCBoZWFkLgo+ID4gKyAqIEBwbWRfaHVnZV9wdGU6ICAgICBQcm90ZWN0
ZWQgYnkgcHRkZXNjLT5wdGwsIHVzZWQgZm9yIFRIUHMuCj4gPiArICogQF9wdF9zMzkwX2dhZGRy
OiAgIEFsaWFzZXMgd2l0aCBwYWdlJ3MgbWFwcGluZy4gVXNlZCBmb3IgczM5MCBnbWFwIG9ubHku
Cj4KPiBTaG91bGQgc29tZSBhcmNoLXNwZWNpZmljIGJpdHMgKGFuZCBhIGZldyBvdGhlcnMpIGFs
d2F5cyB1bmRlciBzb21lCj4gI2lmZGVmcywgc28gaXQgc2hvdWxkbid0IGFwcGVhciBvbiBvdGhl
ciBhcmNocz8KClJpZ2h0IG5vdyB0aGlzIHN0cnVjdCBjb21wbGV0ZWx5IG92ZXJsYXlzIHN0cnVj
dCBwYWdlLCBzbyB0aGUgcGFkZGluZyBhcwp3ZWxsIGFzIGFueSBhcmNoLXNwZWNpZmljIGZpZWxk
cyBoYXZlIHRvIHN0YXkuIFdoZW5ldmVyIHdlIGdldCBwdGRlc2NzCmluZGVwZW5kZW50IG9mIHN0
cnVjdCBwYWdlIHdlIGNhbiBjbGVhbnVwIGFueSB1bm5lY2Vzc2FyeSBmaWVsZHMsIGFzCndlbGwg
YXMgb21pdCB1bm5lY2Vzc2FyeSBmaWVsZHMgZnJvbSB1bnJlbGF0ZWQgYXJjaGl0ZWN0dXJlcy4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVt
IG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
