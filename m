Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F806C7EE24
	for <linux-um@archiver.kernel.org>; Mon, 15 May 2023 19:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rWpokuiVI+/dZGXLzarQbOv16/4/2YEg4QxfjVFfqXA=; b=mmgxBcj8CH+NBH
	wKQ+gvkMfAxxwY3IdkUhKA/RJErG4fafDsAZxxdO4M5YrfVg/aypBwMqD/6PoHOOBTNgPqXiD2LLV
	Kj4TbL3nCpnAdWh3cpNzvXrZcxRUSzr+hTvDFOdjwWvIrlNZlhY/bFUK7hondv6j4KQ3SmS1s0Czf
	YcPu/b/ceBp/UXdOAAJ5/vs5Rv54kZ36yDsDx/tDdp0e577fWwFqtlu/gYn2D3i4zXAiOpneFfzA1
	E8Z8lVaIo5KD6iQ5M+A+lzWpGEtKTLc16rLy0ozS/VJpTjAYzATLVgSJP5XccF32X/Aoxe6GlGTpA
	F5M1Jti96lfAOVVETYbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pydc8-003EwL-1L;
	Mon, 15 May 2023 19:12:08 +0000
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pydc5-003Etu-08;
	Mon, 15 May 2023 19:12:06 +0000
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-ba1815e12efso11332715276.3;
        Mon, 15 May 2023 12:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684177917; x=1686769917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEdsDznoeQ0wGPMJWBs10mMvCj7VphDqPqR+uizklHY=;
        b=W/Z9qzmBUq3bCVhP8uewmPEIaZEVYfzpzeh9YTeAKrK3sWIwtOfql71JlvN0P+P5pK
         YKy9cml02fk4SnFQ2DdWQ6w4JijHunpNA4zsiud1GYDMnfuy8RTxF/bEehOFA+aPeByE
         DTSRG2bdMMqymbgvM1f+cbSlSYq+sQANl8uMoYLlmajJ3SyWJdGVyTNcYD0Ioakieviy
         BESs3L0iPHTKfiNNq75aO8FTJdn/BYay+E8sIKUXSqB49RgAR5VB2xxzW+nwEEKofO5F
         26ssX78nNr5JZdvfN8wyMBJyb6MRO06YlrKHWh/GpY8CaWKtewkcbGK5ZJkz6FL2Wiq9
         dAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684177917; x=1686769917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEdsDznoeQ0wGPMJWBs10mMvCj7VphDqPqR+uizklHY=;
        b=CsyFi4Odf2vVfZ5qpgZOBV7sjXJEz1/CmYhmheplKBrPzxIzW0E20XTnjij/Sv3rGd
         0LtEf8byEiZHn7QTVfz4t0RkJ8Iej3c6CsHHdhFUpM0lOdwwhrVNdS9i1EGDDEw13tDD
         HAdPjWprjnCzcXRlF8RUQPQ0z4HfA6LervITXyBhu4BcVQs1GjOcc28+qQYBB8uDeB3s
         HKWz/YE73dSPbAk4Wel8WlGpazDl0QhuJO7rwI/HIBtJthBF6Nfw5x579Hp1u73W3jbd
         T9uokXbd2le7NPUCWUJ3ueMpopvVQf6muL/P6M1PEUwe2Qa0/9OPKnwTg8Xij4jb6jQr
         77pQ==
X-Gm-Message-State: AC+VfDz7F0bM8iZdUW+vR1gBli9hvJsclw2P1rn4ZxwXRupdq5QmD0Jk
	58c1Zi6IhvKQLEVzJdWiJgc6LdiEVALHxag3eDY=
X-Google-Smtp-Source: ACHHUZ5oDsw20tcH12/01C4i2nT6w5iAb2H6/okJg55EYYpqTgJ8h9iiRdXz2tD9egoOuSwMxk4Rmyquuvv7u/aep3U=
X-Received: by 2002:a25:2586:0:b0:ba7:809c:50de with SMTP id
 l128-20020a252586000000b00ba7809c50demr6158133ybl.38.1684177917068; Mon, 15
 May 2023 12:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-31-vishal.moola@gmail.com> <c0677d21a4b6caa2e5018af000294a974121d9e8.camel@physik.fu-berlin.de>
In-Reply-To: <c0677d21a4b6caa2e5018af000294a974121d9e8.camel@physik.fu-berlin.de>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Mon, 15 May 2023 12:11:46 -0700
Message-ID: <CAOzc2pz6y=gRcdfkQVgwRuzWeWf2Nx-UBtKnZBTs2qKJ+r7R0Q@mail.gmail.com>
Subject: Re: [PATCH v2 30/34] sh: Convert pte_free_tlb() to use ptdescs
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org, 
	Yoshinori Sato <ysato@users.sourceforge.jp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_121205_078627_9558D9AE 
X-CRM114-Status: GOOD (  18.42  )
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

T24gU2F0LCBNYXkgNiwgMjAyMyBhdCA0OjM14oCvQU0gSm9obiBQYXVsIEFkcmlhbiBHbGF1Yml0
ego8Z2xhdWJpdHpAcGh5c2lrLmZ1LWJlcmxpbi5kZT4gd3JvdGU6Cj4KPiBIaSBWaXNoYWwhCj4K
PiBPbiBNb24sIDIwMjMtMDUtMDEgYXQgMTI6MjggLTA3MDAsIFZpc2hhbCBNb29sYSAoT3JhY2xl
KSB3cm90ZToKPiA+IFBhcnQgb2YgdGhlIGNvbnZlcnNpb25zIHRvIHJlcGxhY2UgcGd0YWJsZSBj
b25zdHJ1Y3Rvci9kZXN0cnVjdG9ycyB3aXRoCj4gPiBwdGRlc2MgZXF1aXZhbGVudHMuIEFsc28g
Y2xlYW5zIHVwIHNvbWUgc3BhY2luZyBpc3N1ZXMuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogVmlz
aGFsIE1vb2xhIChPcmFjbGUpIDx2aXNoYWwubW9vbGFAZ21haWwuY29tPgo+ID4gLS0tCj4gPiAg
YXJjaC9zaC9pbmNsdWRlL2FzbS9wZ2FsbG9jLmggfCA5ICsrKysrLS0tLQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdp
dCBhL2FyY2gvc2gvaW5jbHVkZS9hc20vcGdhbGxvYy5oIGIvYXJjaC9zaC9pbmNsdWRlL2FzbS9w
Z2FsbG9jLmgKPiA+IGluZGV4IGE5ZTk4MjMzYzRkNC4uY2UyYmE5OWRiZDg0IDEwMDY0NAo+ID4g
LS0tIGEvYXJjaC9zaC9pbmNsdWRlL2FzbS9wZ2FsbG9jLmgKPiA+ICsrKyBiL2FyY2gvc2gvaW5j
bHVkZS9hc20vcGdhbGxvYy5oCj4gPiBAQCAtMiw2ICsyLDcgQEAKPiA+ICAjaWZuZGVmIF9fQVNN
X1NIX1BHQUxMT0NfSAo+ID4gICNkZWZpbmUgX19BU01fU0hfUEdBTExPQ19ICj4gPgo+ID4gKyNp
bmNsdWRlIDxsaW51eC9tbS5oPgo+ID4gICNpbmNsdWRlIDxhc20vcGFnZS5oPgo+ID4KPiA+ICAj
ZGVmaW5lIF9fSEFWRV9BUkNIX1BNRF9BTExPQ19PTkUKPiA+IEBAIC0zMSwxMCArMzIsMTAgQEAg
c3RhdGljIGlubGluZSB2b2lkIHBtZF9wb3B1bGF0ZShzdHJ1Y3QgbW1fc3RydWN0ICptbSwgcG1k
X3QgKnBtZCwKPiA+ICAgICAgIHNldF9wbWQocG1kLCBfX3BtZCgodW5zaWduZWQgbG9uZylwYWdl
X2FkZHJlc3MocHRlKSkpOwo+ID4gIH0KPiA+Cj4gPiAtI2RlZmluZSBfX3B0ZV9mcmVlX3RsYih0
bGIscHRlLGFkZHIpICAgICAgICAgICAgICAgICBcCj4gPiAtZG8geyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCj4gPiAtICAgICBwZ3RhYmxlX3B0ZV9w
YWdlX2R0b3IocHRlKTsgICAgICAgICAgICAgICAgICAgICBcCj4gPiAtICAgICB0bGJfcmVtb3Zl
X3BhZ2UoKHRsYiksIChwdGUpKTsgICAgICAgICAgICAgICAgICBcCj4gPiArI2RlZmluZSBfX3B0
ZV9mcmVlX3RsYih0bGIsIHB0ZSwgYWRkcikgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XAo+ID4gK2RvIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBcCj4gPiArICAgICBwdGRlc2NfcHRlX2R0b3IocGFnZV9wdGRlc2MocHRlKSk7
ICAgICAgICAgICAgICAgICAgICAgIFwKPiA+ICsgICAgIHRsYl9yZW1vdmVfcGFnZV9wdGRlc2Mo
KHRsYiksIChwYWdlX3B0ZGVzYyhwdGUpKSk7ICAgICAgXAo+ID4gIH0gd2hpbGUgKDApCj4gPgo+
ID4gICNlbmRpZiAvKiBfX0FTTV9TSF9QR0FMTE9DX0ggKi8KPgo+IExvb2tpbmcgYXQgdGhlIHBh
dGNoIHdoaWNoIGludHJvZHVjZXMgdGxiX3JlbW92ZV9wYWdlX3B0ZGVzYygpIFsxXSwgaXQgc2Vl
bXMgdGhhdAo+IHRsYl9yZW1vdmVfcGFnZV9wdGRlc2MoKSBhbHJlYWR5IGNhbGxzIHRsYl9yZW1v
dmVfcGFnZSgpIHdpdGggcHRkZXNjX3BhZ2UocHQpLCBzbwo+IEknbSBub3Qgc3VyZSB3aGV0aGVy
IHRoZSBhYm92ZSB0bGJfcmVtb3ZlX3BhZ2VfcHRkZXNjKCh0bGIpLCAocGFnZV9wdGRlc2MocHRl
KSkpCj4gaXMgY29ycmVjdC4KPgo+IFNob3VsZG4ndCBpdCBqdXN0IGJlIHRsYl9yZW1vdmVfcGFn
ZV9wdGRlc2MoKHRsYiksIChwdGUpKT8KCkFzIG9mIHRoaXMgcGF0Y2hzZXQgYWxsIGltcGxlbWVu
dGF0aW9ucyBvZiBfX3B0ZV9mcmVlX3RsYigpIHRha2UgaW4gYQpzdHJ1Y3QgcGFnZS4gRXZlbnR1
YWxseSB3ZSdsbCB3YW50IGl0IHRvIGJlIHRsYl9yZW1vdmVfcGFnZV9wdGRlc2ModGxiLCBwdGUp
LApidXQgZm9yIG5vdyB0aGUgY2FzdCBpcyBuZWNlc3NhcnkgaGVyZS4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdAps
aW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtdW0K
