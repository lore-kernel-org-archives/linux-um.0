Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9BDC77B73
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 14:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sxpYMCQy4p5oBleqRKHxuxKBveqYy6zGp8ZnleQpYEU=; b=3NCe+Axqp7EG78
	WNTvqBX0qHTzQ4YKb5jLkcElGX8Jc8pxmSeZzzZMPebtjmOALEa+uIi/8cPA8o6w4/zjFB5Ufdy0E
	xR83umwT7F1EMFKwZ/a4iNuukWYIV/UIeLaiFTVS8/B+ojVgt5z710BVQefRk0GQifhHiFeCtkmGj
	4ksoGbM4NBnfHajGwJ7W+5SJs5PJGrzD8nNcAGb4Cb0OuHa/U2baN86xYdoodJpJfp1no67WrrR/l
	ppzU0VJSnv1o/KJMIfjeKsdgMh50zmnuX4If2nfGA1VEXUqDl52tf6GQEWiNOV1XMv5MDuy/0JdLt
	xjyylHycZfEqn6Io2SvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4N8K-000AcN-0X;
	Wed, 31 May 2023 14:49:04 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4N8H-000Abi-1Z
	for linux-um@lists.infradead.org;
	Wed, 31 May 2023 14:49:02 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30a1fdde3d6so5899354f8f.0
        for <linux-um@lists.infradead.org>; Wed, 31 May 2023 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685544538; x=1688136538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7V4aOa0uoRUYdUYR7nYgnOP0GeYZb+MEHjtYTAKUMpk=;
        b=fAd4Wk7fuTrLHlDRSUUcBPTLvSSU6+39np3jZnQBthlFVCpUHKcgp5ha3qQlUg2Txy
         TzvT58UTWxuxX3gbYpozq/ZAmshttW9trg2mx2KCd50gGlA1/jgPTw21akuADNM71n2K
         zoVH71krvK0q/Yxx/Kygpyed32jJN49t/xPEl5mlVSbx0DEuOm5SmhVv2qIMIIBQQewd
         XFu0np5bdyUmqj4XDNkjGu91HsBMz9aSUDpCgs7lS8HB7Wf+cD7fa5SKR/DRp+dXWCKO
         2sL2pz3QvwICQJRPFvOTI+QZOaAHKJlfuENxsTKYBH0MFvdLjcv8RmKleriYHbW/qSKh
         GuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685544538; x=1688136538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7V4aOa0uoRUYdUYR7nYgnOP0GeYZb+MEHjtYTAKUMpk=;
        b=ASfbcMXVN3oKLnkqDoktXQ05Ek11wpth5iQugkSB8tUGeJhIXLmmEiDMqnQZGQYiFS
         khJzBNr9FDsw7jfoM7V/Ib9C/8WTDLvC1OQ0ZlUL2r5XfNdcV04qp8cu+dfr4nBWg+UE
         RZpYK+Q/FDveT9ZOhjiWvGGdd4SKzFHL3Rkj4rzGOqnHbJD7Y63KgfawrxaAuFrunNi+
         /QJr2OGH1gOYf/3OsWauIn1p6+T43arN7AQvReGgYKSNRyPyfrzlpxhCBFQrW5yepI+X
         xfEkB8XXfuezXAU4LfUkC07mbIWSrJ0sqN0F+yl/ad1ToNnv73W4uLAkpz9YgdOtotm9
         ebaw==
X-Gm-Message-State: AC+VfDy7qdvckfOZTiUSd/wrS+vH3D2JxIN6eTp1pbSiWRkEq7JPuQLR
	EOtVdy8w1p99BLQlPh8RfSF4QFZBJgDfnSlaubI=
X-Google-Smtp-Source: ACHHUZ76Ha8CZKICeSBhZyU4Oyb1eBY8UiUyGLLhoB9dAjS/BuxWDWVoT4O+XDFk7Ug65aGOLRPzLbhLSjSA+TzBi4Q=
X-Received: by 2002:adf:d851:0:b0:304:8147:f0ba with SMTP id
 k17-20020adfd851000000b003048147f0bamr4748357wrl.3.1685544536973; Wed, 31 May
 2023 07:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230530164004.986750-1-azeemshaikh38@gmail.com>
 <202305311135.zGMT1gYR-lkp@intel.com> <09A0C6FA-669F-4B73-9620-43AEA17E5D0C@kernel.org>
 <103925562.158061.1685514200368.JavaMail.zimbra@nod.at> <CAMuHMdU70uRxnMNb8KCJe8M3BRPPxowRXtj+POcrh+KLkfQyAA@mail.gmail.com>
In-Reply-To: <CAMuHMdU70uRxnMNb8KCJe8M3BRPPxowRXtj+POcrh+KLkfQyAA@mail.gmail.com>
From: Azeem Shaikh <azeemshaikh38@gmail.com>
Date: Wed, 31 May 2023 10:48:45 -0400
Message-ID: <CADmuW3WXDg-5SFXkMDE6BmvSwLNHmXpTzBonaOL8eErc4+d3qQ@mail.gmail.com>
Subject: Re: [PATCH] uml: Replace all non-returning strlcpy with strscpy
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>, Kees Cook <kees@kernel.org>, kernel test robot <lkp@intel.com>, 
	Maxim Krasnyansky <maxk@qti.qualcomm.com>, oe-kbuild-all <oe-kbuild-all@lists.linux.dev>, 
	linux-hardening@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_074901_530225_65724443 
X-CRM114-Status: GOOD (  21.77  )
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

VGhhbmtzIEdlZXJ0IGFuZCBSaWNoYXJkIGZvciB0aGUgcmV2aWV3LgoKT24gV2VkLCBNYXkgMzEs
IDIwMjMgYXQgNDowNeKAr0FNIEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5v
cmc+IHdyb3RlOgo+Cj4gT24gV2VkLCBNYXkgMzEsIDIwMjMgYXQgODoyM+KAr0FNIFJpY2hhcmQg
V2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+IHdyb3RlOgo+ID4gLS0tLS0gVXJzcHLDvG5nbGlj
aGUgTWFpbCAtLS0tLQo+ID4gPj4+PiBhcmNoL3VtL29zLUxpbnV4L2RyaXZlcnMvdHVudGFwX3Vz
ZXIuYzoxNDk6MTc6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZgo+ID4gPj4+PiBmdW5j
dGlvbiAnc3Ryc2NweSc7IGRpZCB5b3UgbWVhbiAnc3RybmNweSc/Cj4gPiA+Pj4+IFstV2Vycm9y
PWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQo+ID4gPj4gICAgIDE0OSB8ICAgICAgICAg
ICAgICAgICBzdHJzY3B5KGlmci5pZnJfbmFtZSwgcHJpLT5kZXZfbmFtZSwKPiA+ID4+ICAgICBz
aXplb2YoaWZyLmlmcl9uYW1lKSk7Cj4gPiA+PiAgICAgICAgIHwgICAgICAgICAgICAgICAgIF5+
fn5+fn4KPiA+ID4+ICAgICAgICAgfCAgICAgICAgICAgICAgICAgc3RybmNweQo+ID4gPj4gICBj
YzE6IHNvbWUgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKPiA+ID4KPiA+ID4gQWgs
IHllYWgsIHRoaXMgaXMgYW5vdGhlciAibm90IGFjdHVhbGx5IGluIHRoZSBrZXJuZWwiIGNhc2Vz
LiBMZXQncyBpZ25vcmUgdGhpcwo+ID4gPiBzdHJsY3B5IGZvciBub3cuCj4gPgo+ID4gV2VsbCwg
YWN0dWFsbHkgaXQncyBhbm90aGVyIGNhc2Ugb2YgIm5vdCBldmVuIGNvbXBpbGUgdGVzdGVkIi4g
Oi0oCgpBcmdoLCBteSB0ZXN0IHNjcmlwdCB3YXNuJ3QgY3Jvc3MtY29tcGlsaW5nIGZvciB1bS4g
U29ycnkgYWJvdXQgdGhhdCA6KAoKPiA+IFdlbGwsIHN0cmxjcHkoKSBpc24ndCBwYXJ0IG9mIGxp
YmMgZWl0aGVyLCBzbyBhbGwgdGhpcyB3b3VsZCBuZWVkIGlzIHRvCj4gPiBhZGQgaXQgdG8gdXNl
ci5oIGp1c3QgbGlrZSBzdHJsY3B5KCkgaXMgbm93Pwo+Cj4gSSB0aGluayBzby4KPiBBemVlbSwg
Y2FuIHlvdSBwbGVhc2UgdGVzdCB5b3VyIGNoYW5nZXMgd2l0aCB0aGlzIGZpeHVwIGFwcGxpZWQ/
Cj4KPiBkaWZmIC0tZ2l0IGEvYXJjaC91bS9pbmNsdWRlL3NoYXJlZC91c2VyLmggYi9hcmNoL3Vt
L2luY2x1ZGUvc2hhcmVkL3VzZXIuaAo+IGluZGV4IGJkYTY2ZTVhOWQ0ZTMuLmU1ZDNmYmJhZmU0
ZDIgMTAwNjQ0Cj4gLS0tIGEvYXJjaC91bS9pbmNsdWRlL3NoYXJlZC91c2VyLmgKPiArKysgYi9h
cmNoL3VtL2luY2x1ZGUvc2hhcmVkL3VzZXIuaAo+IEBAIC01Miw2ICs1Miw3IEBAIHN0YXRpYyBp
bmxpbmUgaW50IHByaW50ayhjb25zdCBjaGFyICpmbXQsIC4uLikKPiAgZXh0ZXJuIGludCBpbl9h
dG9uKGNoYXIgKnN0cik7Cj4gIGV4dGVybiBzaXplX3Qgc3RybGNweShjaGFyICosIGNvbnN0IGNo
YXIgKiwgc2l6ZV90KTsKPiAgZXh0ZXJuIHNpemVfdCBzdHJsY2F0KGNoYXIgKiwgY29uc3QgY2hh
ciAqLCBzaXplX3QpOwo+ICtleHRlcm4gc3NpemVfdCBzdHJzY3B5KGNoYXIgKiwgY29uc3QgY2hh
ciAqLCBzaXplX3QpOwo+Cj4gIC8qIENvcGllZCBmcm9tIGxpbnV4L2NvbXBpbGVyLWdjYy5oIHNp
bmNlIHdlIGNhbid0IGluY2x1ZGUgaXQgZGlyZWN0bHkgKi8KPiAgI2RlZmluZSBiYXJyaWVyKCkg
X19hc21fXyBfX3ZvbGF0aWxlX18oIiI6IDogOiJtZW1vcnkiKQo+CgpUZXN0ZWQgd2l0aCB0aGlz
IGZpeHVwLCBhbmQgaXQgYnVpbGRzIHN1Y2Nlc3NmdWxseSBvbiBBUkNIPXVtClNVQkFSQ0g9aTM4
Ni4gTGV0IG1lIGtub3cgaWYgSSBuZWVkIHRvIHRlc3Qgd2l0aCBhbnkgb3RoZXIKY3Jvc3MtY29t
cGlsYXRpb24gb3B0aW9ucyBiZWZvcmUgSSBzZW5kIG91dCB2Mi4KCj4KPiBBaCwgeWVhaCwgdGhp
cyBpcyBhbm90aGVyICJub3QgYWN0dWFsbHkgaW4gdGhlIGtlcm5lbCIgY2FzZXMuIExldCdzIGln
bm9yZSB0aGlzIHN0cmxjcHkgZm9yIG5vdy4KPgo+IC1LZWVkCgpQbGFubmluZyB0byBzZW5kIG91
dCB2MiB3aXRoIHRoZSBmaXh1cCBmcm9tIFJpY2hhcmQgYXBwbGllZC4gTGV0IG1lCmtub3cgaWYg
dGhhdCdzIG9rLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
