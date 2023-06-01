Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1768FC7EE37
	for <linux-um@archiver.kernel.org>; Thu,  1 Jun 2023 08:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZY2M8FbGq4qAaNl/MjUwSiLxpXp7CbvIHxYBm4I7lgo=; b=yEL8lGT/kejXqu
	0rx7Tf2izOd1yWHcDrRu9JgguRn3a8mX+1nlaWZEj8QBtFLzmIJywoWbBzHxHL3Ae5XG0vwAi8jLG
	rBK6GUi/l4J8NLDv8ZG/wbvyvcrrUN1ipy2/HKsVwFoWalaX4wtz3dDGNphkdg2CUFLuYTEK8mv0Q
	ZmhtHQ+YvZtmZE+B0TtX4tfZYn0n1/pPGYracC1q+80N3XwlLGuU1vBvqa7iNe1NjtrPoW9kumody
	K44DncB9lNQUTdqeBu1qanqZZu57pnxFRv5VUbahtk/BdutZ6V3YDihy0MxAG4kli5mSKzEdNxgWw
	CqThvYjx/LgQhej7M+kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4dXt-002Wi7-10;
	Thu, 01 Jun 2023 08:20:33 +0000
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4dXq-002WfT-0D;
	Thu, 01 Jun 2023 08:20:31 +0000
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-568a1011488so5943757b3.0;
        Thu, 01 Jun 2023 01:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685607627; x=1688199627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tS4a1xOgxMUMLEbnCg0V4q+ycCWx2xlztmESkIXckyo=;
        b=bIHOxHzjZXokee9j5bbLR5t5pc8c2Z3iggLrV1+hE0XnEXAKfoXhCLHOSa/72NNKfd
         6fz4mYEsaohJNpEL4Rs9VL4vNpL+O0IFENkKP8Ed1r56LzcraMW5AYAo4x/ntCtiU2p3
         x22qNSqmdrlW4Y/tGkgjrEwyv71XC2UWZFG42WlTnI/gnlPQ9bm7CQBxLeRufsNGf3b3
         aSnEcs9elD0+6oKwXRc6fHvLfsfn4GZRVVoYihKOLOoIEu2kuGpVvxaorPdvDNijmjMi
         d1rL9Zr7ifZGWT0hflvFwiRNteKQuaUR21zo007VMcTBghI8tw53RKKaLOkzxLItE6zV
         XEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685607627; x=1688199627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tS4a1xOgxMUMLEbnCg0V4q+ycCWx2xlztmESkIXckyo=;
        b=NYAUen8aea1bGAuo2LnXC3cDmGvQViLjNUKqY+1qwK3PRqnuoit9qUIl/OlEBamqui
         BR7gTDLpcaGE6namUgNuotGoAqdXOzoRzmxHfDdxL/i6vmTmimuERL9TcgTzh2RjHgtt
         NdeKF6S5fqgGNdAuH3HprckMdBebY3NleiEW7rBhRTsPjXznypF/TPGbAVtY039ew/WA
         19/fSEGAdXYO2o5w7Jfq4XzdILo8zW3Q7995y8ZmW/v7fT6lr1oOdy4cjRrL8owf9tVi
         jhwGrRDbJrQWPCeINmlnJA6g0t+qLm/V3Fh8gV/2NoInAGv9UYcl3aFKeNiQSI0K0Whw
         23eQ==
X-Gm-Message-State: AC+VfDzCap2dzHRR+4lGfJ++iTVG7FKNe6lrPc6+rVuPjFVSujvNsAIj
	+374uIpCddvWYJCg6QUyKA6BONj4B2IIBtpkDOs=
X-Google-Smtp-Source: ACHHUZ4IZT44NtIfRs/xlbKnWFcG4D7AEEUxUuudHP/RnlDvS1B/rq8axgox+tzLkd9y6rosB3Zw4KNqjFWW/wbAOr8=
X-Received: by 2002:a81:7785:0:b0:565:7d7:1356 with SMTP id
 s127-20020a817785000000b0056507d71356mr8254467ywc.22.1685607626688; Thu, 01
 Jun 2023 01:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230531213032.25338-1-vishal.moola@gmail.com>
 <20230531213032.25338-26-vishal.moola@gmail.com> <CAMuHMdWCe=VsTJYNA_-k=JipeAGKzgBFjZ8i+XRK7U1DBei=7A@mail.gmail.com>
In-Reply-To: <CAMuHMdWCe=VsTJYNA_-k=JipeAGKzgBFjZ8i+XRK7U1DBei=7A@mail.gmail.com>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Thu, 1 Jun 2023 01:20:15 -0700
Message-ID: <CAOzc2pzVEO_LSw1Ffwk1K3sXni_32wO0T+fEAnR6zVVB5x=vVA@mail.gmail.com>
Subject: Re: [PATCH v3 25/34] m68k: Convert various functions to use ptdescs
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_012030_104674_521B8B10 
X-CRM114-Status: GOOD (  27.95  )
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

T24gVGh1LCBKdW4gMSwgMjAyMyBhdCAxMjo0MOKAr0FNIEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2Vl
cnRAbGludXgtbTY4ay5vcmc+IHdyb3RlOgo+Cj4gSGkgVmlzaGFsLAo+Cj4gT24gV2VkLCBNYXkg
MzEsIDIwMjMgYXQgMTE6MzLigK9QTSBWaXNoYWwgTW9vbGEgKE9yYWNsZSkKPiA8dmlzaGFsLm1v
b2xhQGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiBBcyBwYXJ0IG9mIHRoZSBjb252ZXJzaW9ucyB0byBy
ZXBsYWNlIHBndGFibGUgY29uc3RydWN0b3IvZGVzdHJ1Y3RvcnMgd2l0aAo+ID4gcHRkZXNjIGVx
dWl2YWxlbnRzLCBjb252ZXJ0IHZhcmlvdXMgcGFnZSB0YWJsZSBmdW5jdGlvbnMgdG8gdXNlIHB0
ZGVzY3MuCj4gPgo+ID4gU29tZSBvZiB0aGUgZnVuY3Rpb25zIHVzZSB0aGUgKmdldCpwYWdlKigp
IGhlbHBlciBmdW5jdGlvbnMuIENvbnZlcnQKPiA+IHRoZXNlIHRvIHVzZSBwYWdldGFibGVfYWxs
b2MoKSBhbmQgcHRkZXNjX2FkZHJlc3MoKSBpbnN0ZWFkIHRvIGhlbHAKPiA+IHN0YW5kYXJkaXpl
IHBhZ2UgdGFibGVzIGZ1cnRoZXIuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogVmlzaGFsIE1vb2xh
IChPcmFjbGUpIDx2aXNoYWwubW9vbGFAZ21haWwuY29tPgo+Cj4gVGhhbmtzIGZvciB5b3VyIHBh
dGNoIQo+Cj4gPiAtLS0gYS9hcmNoL202OGsvaW5jbHVkZS9hc20vbWNmX3BnYWxsb2MuaAo+ID4g
KysrIGIvYXJjaC9tNjhrL2luY2x1ZGUvYXNtL21jZl9wZ2FsbG9jLmgKPiA+IEBAIC03LDIwICs3
LDE5IEBACj4gPgo+ID4gIGV4dGVybiBpbmxpbmUgdm9pZCBwdGVfZnJlZV9rZXJuZWwoc3RydWN0
IG1tX3N0cnVjdCAqbW0sIHB0ZV90ICpwdGUpCj4gPiAgewo+ID4gLSAgICAgICBmcmVlX3BhZ2Uo
KHVuc2lnbmVkIGxvbmcpIHB0ZSk7Cj4gPiArICAgICAgIHBhZ2V0YWJsZV9mcmVlKHZpcnRfdG9f
cHRkZXNjKHB0ZSkpOwo+ID4gIH0KPiA+Cj4gPiAgZXh0ZXJuIGNvbnN0IGNoYXIgYmFkX3BtZF9z
dHJpbmdbXTsKPiA+Cj4gPiAgZXh0ZXJuIGlubGluZSBwdGVfdCAqcHRlX2FsbG9jX29uZV9rZXJu
ZWwoc3RydWN0IG1tX3N0cnVjdCAqbW0pCj4gPiAgewo+ID4gLSAgICAgICB1bnNpZ25lZCBsb25n
IHBhZ2UgPSBfX2dldF9mcmVlX3BhZ2UoR0ZQX0RNQSk7Cj4gPiArICAgICAgIHN0cnVjdCBwdGRl
c2MgKnB0ZGVzYyA9IHBhZ2V0YWJsZV9hbGxvYyhHRlBfRE1BIHwgX19HRlBfWkVSTywgMCk7Cj4g
Pgo+ID4gLSAgICAgICBpZiAoIXBhZ2UpCj4gPiArICAgICAgIGlmICghcHRkZXNjKQo+ID4gICAg
ICAgICAgICAgICAgIHJldHVybiBOVUxMOwo+ID4KPiA+IC0gICAgICAgbWVtc2V0KCh2b2lkICop
cGFnZSwgMCwgUEFHRV9TSVpFKTsKPiA+IC0gICAgICAgcmV0dXJuIChwdGVfdCAqKSAocGFnZSk7
Cj4gPiArICAgICAgIHJldHVybiAocHRlX3QgKikgKHB0ZGVzY19hZGRyZXNzKHB0ZGVzYykpOwo+
Cj4gTm8gbmVlZCB0byBjYXN0ICJ2b2lkICoiIHdoZW4gcmV0dXJuaW5nIGEgZGlmZmVyZW50IHBv
aW50ZXIgdHlwZS4KPgo+ID4gIH0KPiA+Cj4gPiAgZXh0ZXJuIGlubGluZSBwbWRfdCAqcG1kX2Fs
bG9jX2tlcm5lbChwZ2RfdCAqcGdkLCB1bnNpZ25lZCBsb25nIGFkZHJlc3MpCj4gPiBAQCAtMzUs
MzYgKzM0LDM2IEBAIGV4dGVybiBpbmxpbmUgcG1kX3QgKnBtZF9hbGxvY19rZXJuZWwocGdkX3Qg
KnBnZCwgdW5zaWduZWQgbG9uZyBhZGRyZXNzKQo+ID4gIHN0YXRpYyBpbmxpbmUgdm9pZCBfX3B0
ZV9mcmVlX3RsYihzdHJ1Y3QgbW11X2dhdGhlciAqdGxiLCBwZ3RhYmxlX3QgcGd0YWJsZSwKPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGFkZHJlc3Mp
Cj4gPiAgewo+ID4gLSAgICAgICBzdHJ1Y3QgcGFnZSAqcGFnZSA9IHZpcnRfdG9fcGFnZShwZ3Rh
YmxlKTsKPiA+ICsgICAgICAgc3RydWN0IHB0ZGVzYyAqcHRkZXNjID0gdmlydF90b19wdGRlc2Mo
cGd0YWJsZSk7Cj4gPgo+ID4gLSAgICAgICBwZ3RhYmxlX3B0ZV9wYWdlX2R0b3IocGFnZSk7Cj4g
PiAtICAgICAgIF9fZnJlZV9wYWdlKHBhZ2UpOwo+ID4gKyAgICAgICBwYWdldGFibGVfcHRlX2R0
b3IocHRkZXNjKTsKPiA+ICsgICAgICAgcGFnZXRhYmxlX2ZyZWUocHRkZXNjKTsKPiA+ICB9Cj4g
Pgo+ID4gIHN0YXRpYyBpbmxpbmUgcGd0YWJsZV90IHB0ZV9hbGxvY19vbmUoc3RydWN0IG1tX3N0
cnVjdCAqbW0pCj4gPiAgewo+ID4gLSAgICAgICBzdHJ1Y3QgcGFnZSAqcGFnZSA9IGFsbG9jX3Bh
Z2VzKEdGUF9ETUEsIDApOwo+ID4gKyAgICAgICBzdHJ1Y3QgcHRkZXNjICpwdGRlc2MgPSBwYWdl
dGFibGVfYWxsb2MoR0ZQX0RNQSwgMCk7Cj4gPiAgICAgICAgIHB0ZV90ICpwdGU7Cj4gPgo+ID4g
LSAgICAgICBpZiAoIXBhZ2UpCj4gPiArICAgICAgIGlmICghcHRkZXNjKQo+ID4gICAgICAgICAg
ICAgICAgIHJldHVybiBOVUxMOwo+ID4gLSAgICAgICBpZiAoIXBndGFibGVfcHRlX3BhZ2VfY3Rv
cihwYWdlKSkgewo+ID4gLSAgICAgICAgICAgICAgIF9fZnJlZV9wYWdlKHBhZ2UpOwo+ID4gKyAg
ICAgICBpZiAoIXBhZ2V0YWJsZV9wdGVfY3RvcihwdGRlc2MpKSB7Cj4gPiArICAgICAgICAgICAg
ICAgcGFnZXRhYmxlX2ZyZWUocHRkZXNjKTsKPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gTlVM
TDsKPiA+ICAgICAgICAgfQo+ID4KPiA+IC0gICAgICAgcHRlID0gcGFnZV9hZGRyZXNzKHBhZ2Up
Owo+ID4gLSAgICAgICBjbGVhcl9wYWdlKHB0ZSk7Cj4gPiArICAgICAgIHB0ZSA9IHB0ZGVzY19h
ZGRyZXNzKHB0ZGVzYyk7Cj4gPiArICAgICAgIHBhZ2V0YWJsZV9jbGVhcihwdGUpOwo+ID4KPiA+
ICAgICAgICAgcmV0dXJuIHB0ZTsKPiA+ICB9Cj4gPgo+ID4gIHN0YXRpYyBpbmxpbmUgdm9pZCBw
dGVfZnJlZShzdHJ1Y3QgbW1fc3RydWN0ICptbSwgcGd0YWJsZV90IHBndGFibGUpCj4gPiAgewo+
ID4gLSAgICAgICBzdHJ1Y3QgcGFnZSAqcGFnZSA9IHZpcnRfdG9fcGFnZShwZ3RhYmxlKTsKPiA+
ICsgICAgICAgc3RydWN0IHB0ZGVzYyAqcHRkZXNjID0gdmlydF90b19wdGRlc2MocHRkZXNjKTsK
Pgo+IHZpcnRfdG9fcHRkZXNjKHBndGFibGUpCj4KPiAoWW91IGNhbiBidWlsZCB0aGlzIHVzaW5n
IG01NDc1ZXZiX2RlZmNvbmZpZykKPgo+ID4KPiA+IC0gICAgICAgcGd0YWJsZV9wdGVfcGFnZV9k
dG9yKHBhZ2UpOwo+ID4gLSAgICAgICBfX2ZyZWVfcGFnZShwYWdlKTsKPiA+ICsgICAgICAgcGFn
ZXRhYmxlX3B0ZV9kdG9yKHB0ZGVzYyk7Cj4gPiArICAgICAgIHBhZ2V0YWJsZV9mcmVlKHB0ZGVz
Yyk7Cj4gPiAgfQo+ID4KPiA+ICAvKgo+ID4gQEAgLTc1LDE2ICs3NCwxOCBAQCBzdGF0aWMgaW5s
aW5lIHZvaWQgcHRlX2ZyZWUoc3RydWN0IG1tX3N0cnVjdCAqbW0sIHBndGFibGVfdCBwZ3RhYmxl
KQo+ID4KPiA+ICBzdGF0aWMgaW5saW5lIHZvaWQgcGdkX2ZyZWUoc3RydWN0IG1tX3N0cnVjdCAq
bW0sIHBnZF90ICpwZ2QpCj4gPiAgewo+ID4gLSAgICAgICBmcmVlX3BhZ2UoKHVuc2lnbmVkIGxv
bmcpIHBnZCk7Cj4gPiArICAgICAgIHBhZ2V0YWJsZV9mcmVlKHZpcnRfdG9fcHRkZXNjKHBnZCkp
Owo+ID4gIH0KPiA+Cj4gPiAgc3RhdGljIGlubGluZSBwZ2RfdCAqcGdkX2FsbG9jKHN0cnVjdCBt
bV9zdHJ1Y3QgKm1tKQo+ID4gIHsKPiA+ICAgICAgICAgcGdkX3QgKm5ld19wZ2Q7Cj4gPiArICAg
ICAgIHN0cnVjdCBwdGRlc2MgKnB0ZGVzYyA9IHBhZ2V0YWJsZV9hbGxvYyhHRlBfRE1BIHwgR0ZQ
X05PV0FSTiwgMCk7Cj4gPgo+ID4gLSAgICAgICBuZXdfcGdkID0gKHBnZF90ICopX19nZXRfZnJl
ZV9wYWdlKEdGUF9ETUEgfCBfX0dGUF9OT1dBUk4pOwo+ID4gLSAgICAgICBpZiAoIW5ld19wZ2Qp
Cj4gPiArICAgICAgIGlmICghcHRkZXNjKQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiBOVUxM
Owo+ID4gKyAgICAgICBuZXdfcGdkID0gKHBnZF90ICopIHB0ZGVzY19hZGRyZXNzKHB0ZGVzYyk7
Cj4KPiBObyBuZWVkIHRvIGNhc3QgInZvaWQgKiIgd2hlbiBhc3NpZ25pbmcgdG8gYSBkaWZmZXJl
bnQgcG9pbnRlciB0eXBlLgo+Cj4gPiArCj4gPiAgICAgICAgIG1lbWNweShuZXdfcGdkLCBzd2Fw
cGVyX3BnX2RpciwgUFRSU19QRVJfUEdEICogc2l6ZW9mKHBnZF90KSk7Cj4gPiAgICAgICAgIG1l
bXNldChuZXdfcGdkLCAwLCBQQUdFX09GRlNFVCA+PiBQR0RJUl9TSElGVCk7Cj4gPiAgICAgICAg
IHJldHVybiBuZXdfcGdkOwo+Cj4gVGhlIHJlc3QgTEdUTS4KClRoYW5rcyBzbyBtdWNoIGZvciB0
aGUgcmV2aWV3ISBJJ2xsIG1ha2UgdGhvc2UgY2hhbmdlcyBpbiB0aGUgbmV4dAp2ZXJzaW9uLgoK
Cj4gR3J7b2V0amUsZWV0aW5nfXMsCj4KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydAo+
Cj4gLS0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9u
ZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnCj4KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRp
b25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0Cj4g
d2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBv
ciBzb21ldGhpbmcgbGlrZSB0aGF0Lgo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
LS0gTGludXMgVG9ydmFsZHMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
