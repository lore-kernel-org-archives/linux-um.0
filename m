Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4A9C77B7E
	for <linux-um@archiver.kernel.org>; Thu,  1 Jun 2023 07:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YzpJISYKS4lDEQIU+xFmXPjuawpccnUOVKk0FP5LepU=; b=Z6hRPRF/bNI+QX
	4ufS8tYvhAPv/rEleG9bva2m0jX1iIE//PjcYJdQWDUptDdzSo0Pj++aIRPl84MwxlEjh855BaJM1
	X1KP5j+wyNJ4JRpi1lY9x8mlo9uHyPesMiTlHRQtOUAwrwoTZ26VedvqeXOkT/6hmqtEcDJLJxARy
	qRK9NTk5Z6X9PLtagggmpE4WyRQqiNM03+QTUVLEZdCjVl+cAY70fbeofsRs5sFpQAw0mj2YY99xx
	ZB8/wft95ePNC2P1mzJ3AM0t+yuQZ92bZDAzTtdP6JV9yn2Rg6fVEXiwDDRZgePFoz8moDVNhpXGg
	91FrwgtdYjTxxalOMAMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4cv7-002OYa-1c;
	Thu, 01 Jun 2023 07:40:29 +0000
Received: from mail-yb1-f173.google.com ([209.85.219.173])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4cv3-002OWw-2d;
	Thu, 01 Jun 2023 07:40:27 +0000
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so2796966276.0;
        Thu, 01 Jun 2023 00:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685605223; x=1688197223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Vy5gwXbACIYw+FA/+yi3OHDGD1kIURAtfeea/c7peI=;
        b=Og1BMkE+MdVNKGYR889UmaINLrKoVpqswfthtZva/a43xln1E7O8tSXxdS9QGmUy/C
         zLrCyuHaOXm38RhXjDQYr7bYjWObBKi+RvnZfR3IS+IpETutXH181gU9Jme9aGFDso0Q
         w4qAa1uBhXBoKbB17MQ0VMr+2a+3ZZRSIfZZeAjITIhWkrtCpCdPUXdUHOYdbrIQUeqq
         qoTWF/ALeXwB8FhUiVI3D8uT/U41Yklq9DszHM3jb28/km7r+Lj7DNK12pyoovIDiTgW
         AA17Fg616/DjG7iCPf/4OXWWXM0fqC+iSpiIMFD1U9rXEDxP2BpAEXy80lQoe3udG77w
         ikbg==
X-Gm-Message-State: AC+VfDxkLB/gcpOd7PMn9MvE4PwagtOTBb1BUecZvoCuBg2idLfds5Zy
	gPkxsOHObApqqKqEsjjUtxbunNlf0GckmQ==
X-Google-Smtp-Source: ACHHUZ4Fh46CkVkR2qVNo7i5ve8QHdHdiK/ASMK9WDk5k0+4ab/xjYPoSDXKratkbKUonYzA3+X+2w==
X-Received: by 2002:a25:ce81:0:b0:ba7:a55f:9091 with SMTP id x123-20020a25ce81000000b00ba7a55f9091mr1234545ybe.6.1685605223575;
        Thu, 01 Jun 2023 00:40:23 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id m205-20020a2571d6000000b00ba87bc06fe5sm4803250ybc.52.2023.06.01.00.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 00:40:21 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ba8cd61ee2dso2770657276.1;
        Thu, 01 Jun 2023 00:40:21 -0700 (PDT)
X-Received: by 2002:a81:a041:0:b0:565:9f61:c771 with SMTP id
 x62-20020a81a041000000b005659f61c771mr1176431ywg.9.1685605221248; Thu, 01 Jun
 2023 00:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230531213032.25338-1-vishal.moola@gmail.com> <20230531213032.25338-26-vishal.moola@gmail.com>
In-Reply-To: <20230531213032.25338-26-vishal.moola@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Jun 2023 09:40:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWCe=VsTJYNA_-k=JipeAGKzgBFjZ8i+XRK7U1DBei=7A@mail.gmail.com>
Message-ID: <CAMuHMdWCe=VsTJYNA_-k=JipeAGKzgBFjZ8i+XRK7U1DBei=7A@mail.gmail.com>
Subject: Re: [PATCH v3 25/34] m68k: Convert various functions to use ptdescs
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
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
X-CRM114-CacheID: sfid-20230601_004025_853284_85980B1A 
X-CRM114-Status: GOOD (  22.92  )
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

SGkgVmlzaGFsLAoKT24gV2VkLCBNYXkgMzEsIDIwMjMgYXQgMTE6MzLigK9QTSBWaXNoYWwgTW9v
bGEgKE9yYWNsZSkKPHZpc2hhbC5tb29sYUBnbWFpbC5jb20+IHdyb3RlOgo+IEFzIHBhcnQgb2Yg
dGhlIGNvbnZlcnNpb25zIHRvIHJlcGxhY2UgcGd0YWJsZSBjb25zdHJ1Y3Rvci9kZXN0cnVjdG9y
cyB3aXRoCj4gcHRkZXNjIGVxdWl2YWxlbnRzLCBjb252ZXJ0IHZhcmlvdXMgcGFnZSB0YWJsZSBm
dW5jdGlvbnMgdG8gdXNlIHB0ZGVzY3MuCj4KPiBTb21lIG9mIHRoZSBmdW5jdGlvbnMgdXNlIHRo
ZSAqZ2V0KnBhZ2UqKCkgaGVscGVyIGZ1bmN0aW9ucy4gQ29udmVydAo+IHRoZXNlIHRvIHVzZSBw
YWdldGFibGVfYWxsb2MoKSBhbmQgcHRkZXNjX2FkZHJlc3MoKSBpbnN0ZWFkIHRvIGhlbHAKPiBz
dGFuZGFyZGl6ZSBwYWdlIHRhYmxlcyBmdXJ0aGVyLgo+Cj4gU2lnbmVkLW9mZi1ieTogVmlzaGFs
IE1vb2xhIChPcmFjbGUpIDx2aXNoYWwubW9vbGFAZ21haWwuY29tPgoKVGhhbmtzIGZvciB5b3Vy
IHBhdGNoIQoKPiAtLS0gYS9hcmNoL202OGsvaW5jbHVkZS9hc20vbWNmX3BnYWxsb2MuaAo+ICsr
KyBiL2FyY2gvbTY4ay9pbmNsdWRlL2FzbS9tY2ZfcGdhbGxvYy5oCj4gQEAgLTcsMjAgKzcsMTkg
QEAKPgo+ICBleHRlcm4gaW5saW5lIHZvaWQgcHRlX2ZyZWVfa2VybmVsKHN0cnVjdCBtbV9zdHJ1
Y3QgKm1tLCBwdGVfdCAqcHRlKQo+ICB7Cj4gLSAgICAgICBmcmVlX3BhZ2UoKHVuc2lnbmVkIGxv
bmcpIHB0ZSk7Cj4gKyAgICAgICBwYWdldGFibGVfZnJlZSh2aXJ0X3RvX3B0ZGVzYyhwdGUpKTsK
PiAgfQo+Cj4gIGV4dGVybiBjb25zdCBjaGFyIGJhZF9wbWRfc3RyaW5nW107Cj4KPiAgZXh0ZXJu
IGlubGluZSBwdGVfdCAqcHRlX2FsbG9jX29uZV9rZXJuZWwoc3RydWN0IG1tX3N0cnVjdCAqbW0p
Cj4gIHsKPiAtICAgICAgIHVuc2lnbmVkIGxvbmcgcGFnZSA9IF9fZ2V0X2ZyZWVfcGFnZShHRlBf
RE1BKTsKPiArICAgICAgIHN0cnVjdCBwdGRlc2MgKnB0ZGVzYyA9IHBhZ2V0YWJsZV9hbGxvYyhH
RlBfRE1BIHwgX19HRlBfWkVSTywgMCk7Cj4KPiAtICAgICAgIGlmICghcGFnZSkKPiArICAgICAg
IGlmICghcHRkZXNjKQo+ICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsKPgo+IC0gICAgICAg
bWVtc2V0KCh2b2lkICopcGFnZSwgMCwgUEFHRV9TSVpFKTsKPiAtICAgICAgIHJldHVybiAocHRl
X3QgKikgKHBhZ2UpOwo+ICsgICAgICAgcmV0dXJuIChwdGVfdCAqKSAocHRkZXNjX2FkZHJlc3Mo
cHRkZXNjKSk7CgpObyBuZWVkIHRvIGNhc3QgInZvaWQgKiIgd2hlbiByZXR1cm5pbmcgYSBkaWZm
ZXJlbnQgcG9pbnRlciB0eXBlLgoKPiAgfQo+Cj4gIGV4dGVybiBpbmxpbmUgcG1kX3QgKnBtZF9h
bGxvY19rZXJuZWwocGdkX3QgKnBnZCwgdW5zaWduZWQgbG9uZyBhZGRyZXNzKQo+IEBAIC0zNSwz
NiArMzQsMzYgQEAgZXh0ZXJuIGlubGluZSBwbWRfdCAqcG1kX2FsbG9jX2tlcm5lbChwZ2RfdCAq
cGdkLCB1bnNpZ25lZCBsb25nIGFkZHJlc3MpCj4gIHN0YXRpYyBpbmxpbmUgdm9pZCBfX3B0ZV9m
cmVlX3RsYihzdHJ1Y3QgbW11X2dhdGhlciAqdGxiLCBwZ3RhYmxlX3QgcGd0YWJsZSwKPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBhZGRyZXNzKQo+ICB7
Cj4gLSAgICAgICBzdHJ1Y3QgcGFnZSAqcGFnZSA9IHZpcnRfdG9fcGFnZShwZ3RhYmxlKTsKPiAr
ICAgICAgIHN0cnVjdCBwdGRlc2MgKnB0ZGVzYyA9IHZpcnRfdG9fcHRkZXNjKHBndGFibGUpOwo+
Cj4gLSAgICAgICBwZ3RhYmxlX3B0ZV9wYWdlX2R0b3IocGFnZSk7Cj4gLSAgICAgICBfX2ZyZWVf
cGFnZShwYWdlKTsKPiArICAgICAgIHBhZ2V0YWJsZV9wdGVfZHRvcihwdGRlc2MpOwo+ICsgICAg
ICAgcGFnZXRhYmxlX2ZyZWUocHRkZXNjKTsKPiAgfQo+Cj4gIHN0YXRpYyBpbmxpbmUgcGd0YWJs
ZV90IHB0ZV9hbGxvY19vbmUoc3RydWN0IG1tX3N0cnVjdCAqbW0pCj4gIHsKPiAtICAgICAgIHN0
cnVjdCBwYWdlICpwYWdlID0gYWxsb2NfcGFnZXMoR0ZQX0RNQSwgMCk7Cj4gKyAgICAgICBzdHJ1
Y3QgcHRkZXNjICpwdGRlc2MgPSBwYWdldGFibGVfYWxsb2MoR0ZQX0RNQSwgMCk7Cj4gICAgICAg
ICBwdGVfdCAqcHRlOwo+Cj4gLSAgICAgICBpZiAoIXBhZ2UpCj4gKyAgICAgICBpZiAoIXB0ZGVz
YykKPiAgICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7Cj4gLSAgICAgICBpZiAoIXBndGFibGVf
cHRlX3BhZ2VfY3RvcihwYWdlKSkgewo+IC0gICAgICAgICAgICAgICBfX2ZyZWVfcGFnZShwYWdl
KTsKPiArICAgICAgIGlmICghcGFnZXRhYmxlX3B0ZV9jdG9yKHB0ZGVzYykpIHsKPiArICAgICAg
ICAgICAgICAgcGFnZXRhYmxlX2ZyZWUocHRkZXNjKTsKPiAgICAgICAgICAgICAgICAgcmV0dXJu
IE5VTEw7Cj4gICAgICAgICB9Cj4KPiAtICAgICAgIHB0ZSA9IHBhZ2VfYWRkcmVzcyhwYWdlKTsK
PiAtICAgICAgIGNsZWFyX3BhZ2UocHRlKTsKPiArICAgICAgIHB0ZSA9IHB0ZGVzY19hZGRyZXNz
KHB0ZGVzYyk7Cj4gKyAgICAgICBwYWdldGFibGVfY2xlYXIocHRlKTsKPgo+ICAgICAgICAgcmV0
dXJuIHB0ZTsKPiAgfQo+Cj4gIHN0YXRpYyBpbmxpbmUgdm9pZCBwdGVfZnJlZShzdHJ1Y3QgbW1f
c3RydWN0ICptbSwgcGd0YWJsZV90IHBndGFibGUpCj4gIHsKPiAtICAgICAgIHN0cnVjdCBwYWdl
ICpwYWdlID0gdmlydF90b19wYWdlKHBndGFibGUpOwo+ICsgICAgICAgc3RydWN0IHB0ZGVzYyAq
cHRkZXNjID0gdmlydF90b19wdGRlc2MocHRkZXNjKTsKCnZpcnRfdG9fcHRkZXNjKHBndGFibGUp
CgooWW91IGNhbiBidWlsZCB0aGlzIHVzaW5nIG01NDc1ZXZiX2RlZmNvbmZpZykKCj4KPiAtICAg
ICAgIHBndGFibGVfcHRlX3BhZ2VfZHRvcihwYWdlKTsKPiAtICAgICAgIF9fZnJlZV9wYWdlKHBh
Z2UpOwo+ICsgICAgICAgcGFnZXRhYmxlX3B0ZV9kdG9yKHB0ZGVzYyk7Cj4gKyAgICAgICBwYWdl
dGFibGVfZnJlZShwdGRlc2MpOwo+ICB9Cj4KPiAgLyoKPiBAQCAtNzUsMTYgKzc0LDE4IEBAIHN0
YXRpYyBpbmxpbmUgdm9pZCBwdGVfZnJlZShzdHJ1Y3QgbW1fc3RydWN0ICptbSwgcGd0YWJsZV90
IHBndGFibGUpCj4KPiAgc3RhdGljIGlubGluZSB2b2lkIHBnZF9mcmVlKHN0cnVjdCBtbV9zdHJ1
Y3QgKm1tLCBwZ2RfdCAqcGdkKQo+ICB7Cj4gLSAgICAgICBmcmVlX3BhZ2UoKHVuc2lnbmVkIGxv
bmcpIHBnZCk7Cj4gKyAgICAgICBwYWdldGFibGVfZnJlZSh2aXJ0X3RvX3B0ZGVzYyhwZ2QpKTsK
PiAgfQo+Cj4gIHN0YXRpYyBpbmxpbmUgcGdkX3QgKnBnZF9hbGxvYyhzdHJ1Y3QgbW1fc3RydWN0
ICptbSkKPiAgewo+ICAgICAgICAgcGdkX3QgKm5ld19wZ2Q7Cj4gKyAgICAgICBzdHJ1Y3QgcHRk
ZXNjICpwdGRlc2MgPSBwYWdldGFibGVfYWxsb2MoR0ZQX0RNQSB8IEdGUF9OT1dBUk4sIDApOwo+
Cj4gLSAgICAgICBuZXdfcGdkID0gKHBnZF90ICopX19nZXRfZnJlZV9wYWdlKEdGUF9ETUEgfCBf
X0dGUF9OT1dBUk4pOwo+IC0gICAgICAgaWYgKCFuZXdfcGdkKQo+ICsgICAgICAgaWYgKCFwdGRl
c2MpCj4gICAgICAgICAgICAgICAgIHJldHVybiBOVUxMOwo+ICsgICAgICAgbmV3X3BnZCA9IChw
Z2RfdCAqKSBwdGRlc2NfYWRkcmVzcyhwdGRlc2MpOwoKTm8gbmVlZCB0byBjYXN0ICJ2b2lkICoi
IHdoZW4gYXNzaWduaW5nIHRvIGEgZGlmZmVyZW50IHBvaW50ZXIgdHlwZS4KCj4gKwo+ICAgICAg
ICAgbWVtY3B5KG5ld19wZ2QsIHN3YXBwZXJfcGdfZGlyLCBQVFJTX1BFUl9QR0QgKiBzaXplb2Yo
cGdkX3QpKTsKPiAgICAgICAgIG1lbXNldChuZXdfcGdkLCAwLCBQQUdFX09GRlNFVCA+PiBQR0RJ
Ul9TSElGVCk7Cj4gICAgICAgICByZXR1cm4gbmV3X3BnZDsKClRoZSByZXN0IExHVE0uCgpHcntv
ZXRqZSxlZXRpbmd9cywKCiAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0CgotLSAKR2VlcnQg
VXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVy
dEBsaW51eC1tNjhrLm9yZwoKSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNh
bCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dAp3aGVuIEknbSB0YWxraW5nIHRv
IGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRo
YXQuCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1h
aWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
