Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46611EB64DC
	for <linux-um@archiver.kernel.org>; Wed, 14 Jun 2023 09:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cUl0s/WVgqwxe5QKckS8jm+drIkL6oWUEHHgIdilquQ=; b=MsiM+SqDycV+G2
	5HSnk/DA1lvHsI0Ztcjjg3CcsfLJO4i/N2UNWyg3ubA0I4cpsJLH898wAWMLiqmNhPvSgb7z6iwWv
	+KnJTDcpxff8KHOmmFpkW3i7fleQ5yDMLqATtvmCQeo5aTjuOjCnkSv9Ngjj5MfnAUIgMoQnjgOiD
	VjNCdv8/pHidxQm7ssT5oLzd54n/mHnSzXuFRfkeIqKzKUbb5XBgxbu94cU5KFXZD3JFAIDoz/Lta
	DEw7wjAAI0kjPDVZvTgATKnBQJ1iGVYZ9HwSEOUmt6wslHsjwSAl2NlLg9NH6/dl3Np1D9oIdscVK
	+4EPZGUQbmDFf8YLQkoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Mpc-00B4VA-1t;
	Wed, 14 Jun 2023 09:30:24 +0000
Received: from mail-yw1-f171.google.com ([209.85.128.171])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9MpY-00B4Rv-0N;
	Wed, 14 Jun 2023 09:30:21 +0000
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-56d4f50427cso5150397b3.3;
        Wed, 14 Jun 2023 02:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686735019; x=1689327019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUg4qrNPX3u1L7teHyX+L+B+2nv6pGpY1jj7jQmio6E=;
        b=Jn2wTqDTCW9BGUkxpmlkOL+j7cq70y9y1YkDpxHbPKS2YJq7CwP7xr31ny3PmIr1mv
         k+MreWDPdp+gl2W5MkraIu3FexJWX41peqELhhstHxcZoPFSOY+zY2zBMs/gcsujeYFU
         h9OnqJmZLn0/h0g2IBkG8kOorWygaqs7l5D/1L84+WQMV+sXCGFH7T31bdMW9HFdENrR
         UaaZyVDnumwfihD+tLFAAqpscACzLsqnHRJ09HaVIs0bL+lGD9r/1KIHMayubFb9jt6U
         SP4yWuUIIcd6F3ua3/HM3mH9P0i/6Q4wjrVSJxokN3F99H73jjrcWsv0QjM3mUVV7ox1
         7egw==
X-Gm-Message-State: AC+VfDxy7aAzBVk3ozA9I1ezZcHnIfgwEiMKlE6qNTxsipap90KrPZOk
	s2jBeqMQQURZSV+Wkh2IebmSVN1OUwMQvA==
X-Google-Smtp-Source: ACHHUZ6qjy+11yb5IfLjK/0A0UC0u4YGNWOw8dcsz/dmjsomucF/TAuZD/NbgPuSjtjaRBx1k4lzwg==
X-Received: by 2002:a25:b4c:0:b0:bd7:4ee7:887b with SMTP id 73-20020a250b4c000000b00bd74ee7887bmr1323042ybl.37.1686735018436;
        Wed, 14 Jun 2023 02:30:18 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id k34-20020a25b2a2000000b00bcdb7d2a03bsm1194774ybj.17.2023.06.14.02.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 02:30:17 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-57001c0baddso5177117b3.2;
        Wed, 14 Jun 2023 02:30:17 -0700 (PDT)
X-Received: by 2002:a25:6b47:0:b0:ba8:2009:ccbb with SMTP id
 o7-20020a256b47000000b00ba82009ccbbmr1338474ybm.46.1686735017346; Wed, 14 Jun
 2023 02:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-28-vishal.moola@gmail.com> <e52c7a74-da68-08d2-54e2-f95a8c5b52e7@kernel.org>
In-Reply-To: <e52c7a74-da68-08d2-54e2-f95a8c5b52e7@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Jun 2023 11:30:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXPASfLM8St_JZOW3Wke+ickJoo1oDr+orRbTERy=Zgwg@mail.gmail.com>
Message-ID: <CAMuHMdXPASfLM8St_JZOW3Wke+ickJoo1oDr+orRbTERy=Zgwg@mail.gmail.com>
Subject: Re: [PATCH v4 27/34] nios2: Convert __pte_free_tlb() to use ptdescs
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, 
	kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230614_023020_151447_90F2ACE6 
X-CRM114-Status: GOOD (  23.00  )
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

SGkgRGluaCwKCk9uIFdlZCwgSnVuIDE0LCAyMDIzIGF0IDEyOjE34oCvQU0gRGluaCBOZ3V5ZW4g
PGRpbmd1eWVuQGtlcm5lbC5vcmc+IHdyb3RlOgo+IE9uIDYvMTIvMjMgMTY6MDQsIFZpc2hhbCBN
b29sYSAoT3JhY2xlKSB3cm90ZToKPiA+IFBhcnQgb2YgdGhlIGNvbnZlcnNpb25zIHRvIHJlcGxh
Y2UgcGd0YWJsZSBjb25zdHJ1Y3Rvci9kZXN0cnVjdG9ycyB3aXRoCj4gPiBwdGRlc2MgZXF1aXZh
bGVudHMuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogVmlzaGFsIE1vb2xhIChPcmFjbGUpIDx2aXNo
YWwubW9vbGFAZ21haWwuY29tPgo+ID4gLS0tCj4gPiAgIGFyY2gvbmlvczIvaW5jbHVkZS9hc20v
cGdhbGxvYy5oIHwgOCArKysrLS0tLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9hcmNoL25pb3MyL2luY2x1
ZGUvYXNtL3BnYWxsb2MuaCBiL2FyY2gvbmlvczIvaW5jbHVkZS9hc20vcGdhbGxvYy5oCj4gPiBp
bmRleCBlY2QxNjU3YmIyY2UuLmNlNmJiOGU3NDI3MSAxMDA2NDQKPiA+IC0tLSBhL2FyY2gvbmlv
czIvaW5jbHVkZS9hc20vcGdhbGxvYy5oCj4gPiArKysgYi9hcmNoL25pb3MyL2luY2x1ZGUvYXNt
L3BnYWxsb2MuaAo+ID4gQEAgLTI4LDEwICsyOCwxMCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcG1k
X3BvcHVsYXRlKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCBwbWRfdCAqcG1kLAo+ID4KPiA+ICAgZXh0
ZXJuIHBnZF90ICpwZ2RfYWxsb2Moc3RydWN0IG1tX3N0cnVjdCAqbW0pOwo+ID4KPiA+IC0jZGVm
aW5lIF9fcHRlX2ZyZWVfdGxiKHRsYiwgcHRlLCBhZGRyKSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcCj4gPiAtICAgICBkbyB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFwKPiA+IC0gICAgICAgICAgICAgcGd0YWJsZV9wdGVfcGFnZV9k
dG9yKHB0ZSk7ICAgICAgICAgICAgICAgICAgICAgXAo+ID4gLSAgICAgICAgICAgICB0bGJfcmVt
b3ZlX3BhZ2UoKHRsYiksIChwdGUpKTsgICAgICAgICAgICAgICAgICBcCj4gPiArI2RlZmluZSBf
X3B0ZV9mcmVlX3RsYih0bGIsIHB0ZSwgYWRkcikgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBcCj4gPiArICAgICBkbyB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAo+ID4gKyAgICAgICAgICAgICBwYWdldGFi
bGVfcHRlX2R0b3IocGFnZV9wdGRlc2MocHRlKSk7ICAgICAgICAgICAgICAgICAgIFwKPiA+ICsg
ICAgICAgICAgICAgdGxiX3JlbW92ZV9wYWdlX3B0ZGVzYygodGxiKSwgKHBhZ2VfcHRkZXNjKHB0
ZSkpKTsgICAgICBcCj4gPiAgICAgICB9IHdoaWxlICgwKQo+ID4KPiA+ICAgI2VuZGlmIC8qIF9B
U01fTklPUzJfUEdBTExPQ19IICovCj4KPiBBcHBsaWVkIQoKSSBkb24ndCB0aGluayB5b3UgY2Fu
IGp1c3QgYXBwbHkgdGhpcyBwYXRjaCwgYXMgdGhlIG5ldyBmdW5jdGlvbnMKd2VyZSBvbmx5IGlu
dHJvZHVjZWQgaW4gW1BBVENIIHY0IDA1LzM0XSBvZiB0aGlzIHNlcmllcy4KCkdye29ldGplLGVl
dGluZ31zLAoKICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQKCi0tIApHZWVydCBVeXR0ZXJo
b2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4
LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3Bs
ZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5h
bGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBs
aXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
