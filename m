Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FABCA0EC3
	for <linux-um@archiver.kernel.org>; Tue, 12 Sep 2023 07:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UecpoMWQiLki4nZg9uq28dT3ywZFLYnOLp0ARGzNl+0=; b=QBcJfWNGLgcUni
	5BE041Ia80iosOw3Y+9wtJFzInZ2nKwMnj0f2qx29eNUnkn2Wi6PuSMR3yrubzeSVuaruOztlVYgy
	Debj+NIjNIRV8kiYimPV4xeV/myKTA7ocJZI20FXYYsOwoGgcVUC3AXoig1CU/JnmPyBzjA6gkC4d
	r+niqM4TMkRVmVWUta96qGVmIv9yf6q2Qc9qEfKfAnp6IZqqU22M3PONCU169fPB2Dy+4ly0tS5z0
	eqh+05j6x/Bhg9JcmqBszwnGqUKsehu7LSWCj8YnY0lzzb7aelFIqZEaiyJY0k1b3ymyNUG2MILxe
	PlAO3rVjcHMx4qZtqb5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfxxG-002Q9y-19;
	Tue, 12 Sep 2023 07:37:02 +0000
Received: from mail-yw1-f175.google.com ([209.85.128.175])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfxxD-002Q8s-0g
	for linux-um@lists.infradead.org;
	Tue, 12 Sep 2023 07:37:00 +0000
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59b4ec8d9c1so44412977b3.0
        for <linux-um@lists.infradead.org>; Tue, 12 Sep 2023 00:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694504217; x=1695109017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQkTxWFhHruinciBZiWA46A9JASfXDRadwS/Z78n1r8=;
        b=KcqDW6nwvid+YOM982kJ4NmRJroV1ArfS3EZENyqbiAnC8U5Y11x+TfP6lfL7bS00b
         I+p1n/bihQRRDaD7lfGhDSuNfGL/zzwjR+Rv9Sgx1gzi43zU+AyWsYpD4cV01Nb/3tNC
         b3RKCnAXIPTtBe8HFPhmlS/vjtP8ZWjCZiXAFRBJqnmgyMaiXnzqZ6d5RbLYhMSIpVXb
         cM5j5InCXk60QXAGM/oBNl0O9CqsP+HBUSDeSaw9P6z0mESXdm7ddutFXg7eEKfjIlyf
         8yt/GniiO9dZNSoFqWTyD6//w7z+bMFiIjTEmAiQuKJHxb8P6J7zawhb3dMiyLRgDrcZ
         JaEA==
X-Gm-Message-State: AOJu0Yyc4IbbAlqx1fFl+06I/32jWTs/2QLhFm812nz6TDKLOt05vTaU
	Z+k8SOxgn29594X4gpsVP6+FIgq7K8rstA==
X-Google-Smtp-Source: AGHT+IEuEeIRSJpYofGHN4+2FyF5LOl2tjFH+hIfWk98ZhVERQtsXPM0M1RQC7mkdc4uTiQE1ipkng==
X-Received: by 2002:a0d:c142:0:b0:592:60e9:97cf with SMTP id c63-20020a0dc142000000b0059260e997cfmr10717731ywd.12.1694504217004;
        Tue, 12 Sep 2023 00:36:57 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id x204-20020a817cd5000000b0058c668e46cbsm2420086ywc.46.2023.09.12.00.36.55
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:36:55 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d801c83325fso3559367276.0
        for <linux-um@lists.infradead.org>; Tue, 12 Sep 2023 00:36:55 -0700 (PDT)
X-Received: by 2002:a25:2d08:0:b0:d7a:d018:5a37 with SMTP id
 t8-20020a252d08000000b00d7ad0185a37mr11515001ybt.39.1694504214921; Tue, 12
 Sep 2023 00:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230911-strncpy-arch-um-os-linux-drivers-ethertap_user-c-v1-1-d9e53f52ab32@google.com>
In-Reply-To: <20230911-strncpy-arch-um-os-linux-drivers-ethertap_user-c-v1-1-d9e53f52ab32@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Sep 2023 09:36:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXJMZ6FebNn01C9EPsZAiJs-n5tp4j2hufAAr=zXOsSOQ@mail.gmail.com>
Message-ID: <CAMuHMdXJMZ6FebNn01C9EPsZAiJs-n5tp4j2hufAAr=zXOsSOQ@mail.gmail.com>
Subject: Re: [PATCH] um,ethertap: refactor deprecated strncpy
To: Justin Stitt <justinstitt@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_003659_253964_B3B5EE8E 
X-CRM114-Status: GOOD (  25.88  )
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

SGkgSnVzdGluLAoKVGhhbmtzIGZvciB5b3VyIHBhdGNoIQoKT24gTW9uLCBTZXAgMTEsIDIwMjMg
YXQgNzo1M+KAr1BNIEp1c3RpbiBTdGl0dCA8anVzdGluc3RpdHRAZ29vZ2xlLmNvbT4gd3JvdGU6
Cj4gYHN0cm5jcHlgIGlzIGRlcHJlY2F0ZWQgZm9yIHVzZSBvbiBOVUwtdGVybWluYXRlZCBkZXN0
aW5hdGlvbiBzdHJpbmdzIFsxXS4KPgo+IGBnYXRlX2J1ZmAgc2hvdWxkIGFsd2F5cyBiZSBOVUwt
dGVybWluYXRlZCBhbmQgZG9lcyBub3QgcmVxdWlyZQo+IE5VTC1wYWRkaW5nLiBJdCBpcyB1c2Vk
IGFzIGEgc3RyaW5nIGFyZyBpbnNpZGUgYW4gYXJndiBhcnJheSBnaXZlbiB0bwoKQ2FuIHlvdSBw
bGVhc2UgZXhwbGFpbiB3aHkgaXQgZG9lcyBub3QgcmVxdWlyZSBOVUwtcGFkZGluZz8KSXQgbG9v
a3MgbGlrZSB0aGlzIGJ1ZmZlciBpcyBwYXNzZWQgZXZlbnR1YWxseSB0byBhIHVzZXIgc3BhY2UK
YXBwbGljYXRpb24sIHRodXMgcG9zc2libHkgbGVha2luZyB1bmluaXRpYWxpemVkIHN0YWNrIGRh
dGEuCgo+IGBydW5faGVscGVyKClgLiBEdWUgdG8gdGhpcywgbGV0J3MgdXNlIGBzdHJzY3B5YCBh
cyBpdCBndWFyYW50ZWVzCj4gTlVMLXRlcm1pbmF0ZWQgb24gdGhlIGRlc3RpbmF0aW9uIGJ1ZmZl
ciBwcmV2ZW50aW5nIHBvdGVudGlhbCBidWZmZXIKPiBvdmVycmVhZHMgWzJdLgo+Cj4gVGhpcyBl
eGFjdCBpbnZvY2F0aW9uIHdhcyBjaGFuZ2VkIGZyb20gYHN0cmNweWAgdG8gYHN0cm5jcHlgIGlu
IGNvbW1pdAo+IDc4NzliMWQ5NGJhZGIgKCJ1bSxldGhlcnRhcDogdXNlIHN0cm5jcHkiKSBiYWNr
IGluIDIwMTUuIExldCdzIGNvbnRpbnVlCj4gaGFyZGVuaW5nIG91ciBgc3RyKmNweWAgYXBpcyBh
bmQgdXNlIHRoZSBuZXdlciBhbmQgc2FmZXIgYHN0cnNjcHlgIQo+Cj4gTGluazogd3d3Lmtlcm5l
bC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3Byb2Nlc3MvZGVwcmVjYXRlZC5odG1sI3N0cm5jcHktb24t
bnVsLXRlcm1pbmF0ZWQtc3RyaW5nc1sxXQo+IExpbms6IGh0dHBzOi8vbWFucGFnZXMuZGViaWFu
Lm9yZy90ZXN0aW5nL2xpbnV4LW1hbnVhbC00Ljgvc3Ryc2NweS45LmVuLmh0bWwgWzJdCj4gTGlu
azogaHR0cHM6Ly9naXRodWIuY29tL0tTUFAvbGludXgvaXNzdWVzLzkwCj4gQ2M6IGxpbnV4LWhh
cmRlbmluZ0B2Z2VyLmtlcm5lbC5vcmcKPiBDYzogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1
bS5vcmc+Cj4gU2lnbmVkLW9mZi1ieTogSnVzdGluIFN0aXR0IDxqdXN0aW5zdGl0dEBnb29nbGUu
Y29tPgo+IC0tLQo+ICBhcmNoL3VtL29zLUxpbnV4L2RyaXZlcnMvZXRoZXJ0YXBfdXNlci5jIHwg
MiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+
IGRpZmYgLS1naXQgYS9hcmNoL3VtL29zLUxpbnV4L2RyaXZlcnMvZXRoZXJ0YXBfdXNlci5jIGIv
YXJjaC91bS9vcy1MaW51eC9kcml2ZXJzL2V0aGVydGFwX3VzZXIuYwo+IGluZGV4IDk0ODMwMjFk
ODZkZC4uMzM2Mzg1MWE0YWU4IDEwMDY0NAo+IC0tLSBhL2FyY2gvdW0vb3MtTGludXgvZHJpdmVy
cy9ldGhlcnRhcF91c2VyLmMKPiArKysgYi9hcmNoL3VtL29zLUxpbnV4L2RyaXZlcnMvZXRoZXJ0
YXBfdXNlci5jCj4gQEAgLTEwNSw3ICsxMDUsNyBAQCBzdGF0aWMgaW50IGV0YXBfdHJhbXAoY2hh
ciAqZGV2LCBjaGFyICpnYXRlLCBpbnQgY29udHJvbF9tZSwKPiAgICAgICAgIHNwcmludGYoZGF0
YV9mZF9idWYsICIlZCIsIGRhdGFfcmVtb3RlKTsKPiAgICAgICAgIHNwcmludGYodmVyc2lvbl9i
dWYsICIlZCIsIFVNTF9ORVRfVkVSU0lPTik7Cj4gICAgICAgICBpZiAoZ2F0ZSAhPSBOVUxMKSB7
Cj4gLSAgICAgICAgICAgICAgIHN0cm5jcHkoZ2F0ZV9idWYsIGdhdGUsIDE1KTsKPiArICAgICAg
ICAgICAgICAgc3Ryc2NweShnYXRlX2J1ZiwgZ2F0ZSwgc2l6ZW9mKGdhdGVfYnVmKSk7Cj4gICAg
ICAgICAgICAgICAgIGFyZ3MgPSBzZXR1cF9hcmdzOwo+ICAgICAgICAgfQo+ICAgICAgICAgZWxz
ZSBhcmdzID0gbm9zZXR1cF9hcmdzOwo+Cj4gLS0tCj4gYmFzZS1jb21taXQ6IDJkZGUxOGNkMWQ4
ZmFjNzM1ODc1ZjJlNDk4N2YxMTgxN2NjMGJjMmMKPiBjaGFuZ2UtaWQ6IDIwMjMwOTExLXN0cm5j
cHktYXJjaC11bS1vcy1saW51eC1kcml2ZXJzLWV0aGVydGFwX3VzZXItYy04NTkxNjBkMTNmNTkK
Ckdye29ldGplLGVldGluZ31zLAoKICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQKCi0tIApH
ZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0t
IGdlZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVj
aG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtp
bmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxp
a2UgdGhhdC4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxk
cwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
dW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
