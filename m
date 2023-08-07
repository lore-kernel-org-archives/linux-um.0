Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD75CC001DB
	for <linux-um@archiver.kernel.org>; Mon,  7 Aug 2023 22:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=empJVgEMXrk/dITnTcuhK7IEe0T6iyO4jy/SF3Oyit8=; b=oW2nCcRgoYMwEW
	cUNYpQPq9vF7SKkfy+4UfT9E0XPEQIVSBeWVNX0CDhI/2YdK1QmBRD+QeABA6E5oaoqYGBfF3tidL
	oVXvYd3ihgRIjWDf86LKjSKvkFYmoKWMdWcS/ePL6/mkwcmGbc52fr5qNF6GYd5JdZ4YM1tvqCHP1
	M/TH3Dln0KVFabP+NvCApUyDRn+PbCWUaA20hiuotbi3Q3Hcnv4zutVaQZi8WuTItFQAuKIfVqafR
	WloarTHncXdGTh+nc9aVsdHMqBWxtA6dM7+OkZmviME8XR3FfQgBjX5Pipfky+Z7vN6xJLVFz+TyH
	5a00EdSV8ij3Ck2eZBpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qT8qk-001039-2O;
	Mon, 07 Aug 2023 22:37:18 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qT8qh-00101t-0y
	for linux-um@lists.infradead.org;
	Mon, 07 Aug 2023 22:37:17 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so15495e9.1
        for <linux-um@lists.infradead.org>; Mon, 07 Aug 2023 15:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691447832; x=1692052632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdgZ+yKdFSOFiY00JEX4rMGwnQcYiswrUXgyH1Y7NI8=;
        b=zmwt3+VhE/zISQHArzy0S2xng2eRXEBRjH7vY5M6DhOL7yCzeQQrj93fhG6GLN15FV
         XyjlkGW16ZLDgOh/nunApLS2HRoVieiyhYqAhJoTN1WLXoZjHuu/QsBuCvgZeytytsgo
         ZPtwtuY3men0q2NUExwdbgTjTWggH5a2/RDxI6GJYjU8ChdvJMVD10L+Sy61oBNiWqpR
         iVaBz4GP1ZdKSAiUnqxK4CZx/fj6y5xm/SRCNm3Aa780rxcazX/CE8ERan5CkXKcGjXR
         Ej2xGEHDIPWt2fAVc3ervijwKK5jXKQuplnugTBOGwkOrN+i2Xo4LAC7L8VhlOQaC5pB
         MVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691447832; x=1692052632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdgZ+yKdFSOFiY00JEX4rMGwnQcYiswrUXgyH1Y7NI8=;
        b=NIhCed3pR4zI3KzaWYirQe677N3QCWbmIlQeowFGqQ7fFl34rUbc21ZsxlJRYu7fG8
         f6mtgpSvUpNxv92+tY42J83DoRm1i3qnlFLzJ8fRTGrdaB4WIpod0siIo16d4NLyteiK
         sDynIhdYW+cpJmLHCymkdEGeZcRf/y/bEGuGlPy9iwE+SBQ/meFyJy2tAaeoQvqlGGye
         RFprVwpeYfuzJDS4MtGZ+hQdXi4Rh1QGeshmN2TJVESdT6jhK52ITLFl4hNKIxPr4Akk
         jJULd0soejrt3IJ82LIlNJ4i1D4xUnQRhVuOYNAB98Tneg/F3h3ug2r8ARZqHNdXtnQK
         KtdQ==
X-Gm-Message-State: AOJu0YzlanrWhhqeRKSuZQ3NSD/9yF8qf6D+s8ZHXaeAOFYn/i2eUucQ
	KVPfbulcQ6O3adV2K60VbU4LzW6FkgKaZ28FhTmD
X-Google-Smtp-Source: AGHT+IGzgdIUbivb2zwdikjRtkP7BIwhj4BTYu6hyXTOMC7jmF9THDOVGX6dmbylOsLRZI7Jua6/H2NK3ns/5JRiZso=
X-Received: by 2002:a05:600c:1d13:b0:3fe:b38:5596 with SMTP id
 l19-20020a05600c1d1300b003fe0b385596mr234589wms.6.1691447831991; Mon, 07 Aug
 2023 15:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230807-arch-um-v1-1-86dbbfb59709@google.com>
In-Reply-To: <20230807-arch-um-v1-1-86dbbfb59709@google.com>
From: Bill Wendling <morbo@google.com>
Date: Mon, 7 Aug 2023 15:36:55 -0700
Message-ID: <CAGG=3QVUqVdkzBo-=vGWprPBUhuV8p3bRSx3Qsvtqx_LDct05w@mail.gmail.com>
Subject: Re: [PATCH] um: refactor deprecated strncpy to strtomem
To: Justin Stitt <justinstitt@google.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-hardening@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_153715_360187_6BF456E5 
X-CRM114-Status: GOOD (  19.57  )
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

T24gTW9uLCBBdWcgNywgMjAyMyBhdCAyOjE44oCvUE0gSnVzdGluIFN0aXR0IDxqdXN0aW5zdGl0
dEBnb29nbGUuY29tPiB3cm90ZToKPgo+IFVzZSBgc3RydG9tZW1gIGhlcmUgc2luY2UgYGNvbnNv
bGVfYnVmYCBpcyBub3QgZXhwZWN0ZWQgdG8gYmUKPiBOVUwtdGVybWluYXRlZC4gV2Ugc2hvdWxk
IHByb2JhYmx5IGFsc28ganVzdCB1c2UgYE1DT05TT0xFX01BWF9EQVRBYAo+IGluc3RlYWQgb2Yg
dXNpbmcgYEFSUkFZX1NJWkUoKWAgZm9yIGV2ZXJ5IGl0ZXJhdGlvbiBvZiB0aGUgbG9vcC4KPgpJ
cyB0aGlzIGNoYW5nZSBuZWNlc3Nhcnk/IEkgaGF2ZSBhIGdlbmVyYWwgcHJlZmVyZW5jZSBmb3Ig
QVJSQVlfU0laRSwKYmVjYXVzZSBhIGNoYW5nZSBpbiBzaXplIGlzIGxlc3MgbGlrZWx5IHRvIGJl
IG92ZXJsb29rZWQgKHVubGVzcyB0aGF0CmdvZXMgYWdhaW5zdCB0aGUgY29kaW5nIHN0YW5kYXJk
KS4KCj4gQWxzbyBtYXJrIGNoYXIgYnVmZmVyIGFzIGBfX25vbnN0cmluZ2AgYXMgcGVyIEtlZXMn
IHN1Z2dlc3Rpb24gaGVyZSBbMV0KPgo+IEZpbmFsbHksIGZvbGxvdyBjaGVja3BhdGNoJ3MgcmVj
b21tZW5kYXRpb24gb2YgdXNpbmcgYG1pbl90YCBvdmVyIGBtaW5gCj4KPiBMaW5rOiBodHRwczov
L2dpdGh1Yi5jb20vS1NQUC9saW51eC9pc3N1ZXMvOTAgWzFdCj4gQ2M6IGxpbnV4LWhhcmRlbmlu
Z0B2Z2VyLmtlcm5lbC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBKdXN0aW4gU3RpdHQgPGp1c3RpbnN0
aXR0QGdvb2dsZS5jb20+Cj4gLS0tCj4gTm90ZXM6Cj4gSSBvbmx5IGJ1aWxkIHRlc3RlZCB0aGlz
IHBhdGNoLgo+IC0tLQo+ICBhcmNoL3VtL2RyaXZlcnMvbWNvbnNvbGVfa2Vybi5jIHwgNyArKysr
LS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvYXJjaC91bS9kcml2ZXJzL21jb25zb2xlX2tlcm4uYyBiL2FyY2gvdW0v
ZHJpdmVycy9tY29uc29sZV9rZXJuLmMKPiBpbmRleCA1MDI2ZTdiOWFkZmUuLmZkNGMwMjQyMDJh
ZSAxMDA2NDQKPiAtLS0gYS9hcmNoL3VtL2RyaXZlcnMvbWNvbnNvbGVfa2Vybi5jCj4gKysrIGIv
YXJjaC91bS9kcml2ZXJzL21jb25zb2xlX2tlcm4uYwo+IEBAIC00LDYgKzQsNyBAQAo+ICAgKiBD
b3B5cmlnaHQgKEMpIDIwMDEgLSAyMDA4IEplZmYgRGlrZSAoamRpa2VAe2FkZHRvaXQsbGludXgu
aW50ZWx9LmNvbSkKPiAgICovCj4KPiArI2luY2x1ZGUgImxpbnV4L2NvbXBpbGVyX2F0dHJpYnV0
ZXMuaCIKCm5pdDogU2hvdWxkIHRoaXMgaW5jbHVkZSBiZSBpbiBhbmdsZSBicmFja2V0cz8KCiNp
bmNsdWRlIDxsaW51eC9jb21waWxlcl9hdHRyaWJ1dGVzLmg+Cgo+ICAjaW5jbHVkZSA8bGludXgv
Y29uc29sZS5oPgo+ICAjaW5jbHVkZSA8bGludXgvY3R5cGUuaD4KPiAgI2luY2x1ZGUgPGxpbnV4
L3N0cmluZy5oPgo+IEBAIC01NTQsNyArNTU1LDcgQEAgc3RydWN0IG1jb25zb2xlX291dHB1dCB7
Cj4KPiAgc3RhdGljIERFRklORV9TUElOTE9DSyhjbGllbnRfbG9jayk7Cj4gIHN0YXRpYyBMSVNU
X0hFQUQoY2xpZW50cyk7Cj4gLXN0YXRpYyBjaGFyIGNvbnNvbGVfYnVmW01DT05TT0xFX01BWF9E
QVRBXTsKPiArc3RhdGljIGNoYXIgY29uc29sZV9idWZbTUNPTlNPTEVfTUFYX0RBVEFdIF9fbm9u
c3RyaW5nOwo+Cj4gIHN0YXRpYyB2b2lkIGNvbnNvbGVfd3JpdGUoc3RydWN0IGNvbnNvbGUgKmNv
bnNvbGUsIGNvbnN0IGNoYXIgKnN0cmluZywKPiAgICAgICAgICAgICAgICAgICAgICAgICAgIHVu
c2lnbmVkIGludCBsZW4pCj4gQEAgLTU2Niw4ICs1NjcsOCBAQCBzdGF0aWMgdm9pZCBjb25zb2xl
X3dyaXRlKHN0cnVjdCBjb25zb2xlICpjb25zb2xlLCBjb25zdCBjaGFyICpzdHJpbmcsCj4gICAg
ICAgICAgICAgICAgIHJldHVybjsKPgo+ICAgICAgICAgd2hpbGUgKGxlbiA+IDApIHsKPiAtICAg
ICAgICAgICAgICAgbiA9IG1pbigoc2l6ZV90KSBsZW4sIEFSUkFZX1NJWkUoY29uc29sZV9idWYp
KTsKPiAtICAgICAgICAgICAgICAgc3RybmNweShjb25zb2xlX2J1Ziwgc3RyaW5nLCBuKTsKPiAr
ICAgICAgICAgICAgICAgbiA9IG1pbl90KHNpemVfdCwgbGVuLCBNQ09OU09MRV9NQVhfREFUQSk7
Cj4gKyAgICAgICAgICAgICAgIHN0cnRvbWVtKGNvbnNvbGVfYnVmLCBzdHJpbmcpOwo+ICAgICAg
ICAgICAgICAgICBzdHJpbmcgKz0gbjsKPiAgICAgICAgICAgICAgICAgbGVuIC09IG47Cj4KPgo+
IC0tLQo+IGJhc2UtY29tbWl0OiBjMWE1MTVkM2MwMjcwNjI4ZGY4YWU1ZjUxMThiYTg1OWI4NTQ2
NGEyCj4gY2hhbmdlLWlkOiAyMDIzMDgwNy1hcmNoLXVtLTNlZjI0NDEzNDI3ZQo+Cj4gQmVzdCBy
ZWdhcmRzLAo+IC0tCj4gSnVzdGluIFN0aXR0IDxqdXN0aW5zdGl0dEBnb29nbGUuY29tPgo+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBt
YWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
