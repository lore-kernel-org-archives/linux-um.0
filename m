Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F92FC3DA78
	for <linux-um@archiver.kernel.org>; Sun, 15 Jan 2023 09:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cUn2iAbRY0T8HGQlSsxbGS4+dBd8VdDDraTNx3mfwxo=; b=WQZkyFIIWHCk7Y
	gk3aJyCSw1+h97+vsTdOMH4pYWehWAh65UzjU8+HPTLZPL7Pwo/ReSih5KDTGEcT3fUleKjkmwRGc
	Q4O0yadZs1kyPbTQfwCI9UdSsFVBHEbt5yogobi8j5uaPRhOJlQruoFbICINMtmcPqPyPix4WZl88
	nYycXnUbmNl0TFduEKbj+AhXYgvmHIvUIA0ZVBpR98WjERPa48QYlcn1fEAPIAnac9Ogu102OoVuE
	TGLjVOw6hWjKFobNDi4Q3irt75HTy7pBpeyZzOs01MmR6UTOkcbKn/C2fhdrE/oU/RaDhdVUc/Rqv
	MMhIEIwY2JJ9i+k80Uvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGzci-00799k-4c; Sun, 15 Jan 2023 09:48:20 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGzcf-007991-Od
	for linux-um@lists.infradead.org; Sun, 15 Jan 2023 09:48:19 +0000
Received: by mail-ej1-x631.google.com with SMTP id vm8so61724526ejc.2
        for <linux-um@lists.infradead.org>; Sun, 15 Jan 2023 01:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U91tZ1pcL+C5oCwSnm2ekb7b6jfm6xqHe6fUGsu0ktM=;
        b=nnDDnTlzHuKvIuOwtJ8+Uq5p94FYTsvGa/hjrDCWnj4igFQ/+5OMt9b+0VuOvJTSsF
         i7+CnSb7s3qDZ5PosseVVS+xilrMjkv66/dEb67/IwDMbVkd7NyGVdjB24XPEYyqnQ7G
         poVHSWf4P6kv4bpOGH+YVXZjL11kNMKRdc7WZptXhqg+Hqbc4efIfYqaywEeLmjDywSG
         dO0O1tWss+0Xi1jD3BdkpFUgRn/dHyE6iZY+36C0mjvBQPFYXt+LmoC08/DDGLnFNO5T
         uG1aFnm6Ik/Ma6VQ0kYR0VA6lJ3U2SM0Q/bUtuAyB73YzxZQDViaE1Ew7hh8tTSW93J2
         si4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U91tZ1pcL+C5oCwSnm2ekb7b6jfm6xqHe6fUGsu0ktM=;
        b=lLs6RZ2EakyhLnvGDSd8uwlowuPD5Cvf4DVxkAF1kn/qtuwyORW95jS74WzbAk7icN
         UuxbkA2ABVLjlOyLz0N9UDE9Az8NsX6oQPmk1fSyehva2FHLPbjb37G3c7jOQ9QoSKkx
         WAYGUHx22KZNZHmQs4wpczJvCyarWgcKNGAPpJH9Ra5ZWgHlkwrxeM6oAul494CyS1gX
         f1J+k4z/CMpU6lsumT4TgDGUPYRb/CZWtS4ZwtlNOaZ2wAJxbSR0uTYCwtHGvPAVfTzE
         gO0I4s4buAaxIpRPDg2dhNlcCxvJt4UnY19N+sMJicPmRLJjScw6uWVfOAgKlMwg2Lmy
         LhOA==
X-Gm-Message-State: AFqh2kpQxanc88rOM+py+szrCLvLW93RJm5+kmRhMSFv4m+BS1ly/cNQ
	z5CB4OT9x5giHuan4k6ZH1plqFxKrFRlygI5bjE=
X-Google-Smtp-Source: AMrXdXut/jQfPnLAZ0P8wTjeVheBJGzDy1oXd+fLbIjFFvMb2cO1l1wWanUjf0idLIAT+L4AoNQ/GeLj+GyV7h2w9sI=
X-Received: by 2002:a17:906:d217:b0:7c1:8a0b:f915 with SMTP id
 w23-20020a170906d21700b007c18a0bf915mr6150975ejz.42.1673776096219; Sun, 15
 Jan 2023 01:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20221217044436.4138642-1-davidgow@google.com> <20221217044436.4138642-3-davidgow@google.com>
In-Reply-To: <20221217044436.4138642-3-davidgow@google.com>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Sun, 15 Jan 2023 10:47:39 +0100
Message-ID: <CAA76j91Kn62Rqs9843njNSmuvb2XEyNLnC996Bmmz1obTbCX9w@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: arch/um: Disable FP/SIMD instruction to match x86
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, rust-for-linux@vger.kernel.org, 
	linux-um@lists.infradead.org, llvm@lists.linux.dev, linux-doc@vger.kernel.org, 
	kunit-dev@googlegroups.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Daniel Latypov <dlatypov@google.com>, 
	Jonathan Corbet <corbet@lwn.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230115_014817_823703_FEFDB3F1 
X-CRM114-Status: GOOD (  16.02  )
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

T24gU2F0LCAxNyBEZWMgMjAyMiBhdCAwNTo0OSwgRGF2aWQgR293IDxkYXZpZGdvd0Bnb29nbGUu
Y29tPiB3cm90ZToKPgo+IFRoZSBrZXJuZWwgZGlzYWJsZXMgYWxsIFNTRSBhbmQgc2ltaWxhciBG
UC9TSU1EIGluc3RydWN0aW9ucyBvbgo+IHg4Ni1iYXNlZCBhcmNoaXRlY3R1cmVzIChwYXJ0bHkg
YmVjYXVzZSB3ZSBzaG91bGRuJ3QgYmUgdXNpbmcgZmxvYXRzIGluCj4gdGhlIGtlcm5lbCwgYW5k
IHBhcnRseSB0byBhdm9pZCB0aGUgbmVlZCBmb3Igc3RhY2sgYWxpZ25tZW50LCBzZWU6Cj4gaHR0
cHM6Ly9nY2MuZ251Lm9yZy9idWd6aWxsYS9zaG93X2J1Zy5jZ2k/aWQ9NTMzODMgKQo+Cj4gVU1M
IGRvZXMgbm90IGRvIHRoZSBzYW1lIHRoaW5nLCB3aGljaCBpc24ndCBpbiBpdHNlbGYgYSBwcm9i
bGVtLCBidXQKPiBkb2VzIGFkZCB0byB0aGUgbGlzdCBvZiBkaWZmZXJlbmNlcyBiZXR3ZWVuIFVN
TCBhbmQgIm5vcm1hbCIgeDg2IGJ1aWxkcy4KPgo+IEluIGFkZGl0aW9uLCB0aGVyZSB3YXMgYSBj
cmFzaCBidWcgd2l0aCBMTFZNIDwgMTUgLyBydXN0YyA8IDEuNjUgd2hlbgo+IGJ1aWxkaW5nIHdp
dGggU1NFLCBzbyBkaXNhYmxpbmcgaXQgZml4ZXMgcnVzdCBidWlsZHMgd2l0aCBlYXJsaWVyCj4g
Y29tcGlsZXIgdmVyc2lvbnMsIHNlZToKPiBodHRwczovL2dpdGh1Yi5jb20vUnVzdC1mb3ItTGlu
dXgvbGludXgvcHVsbC84ODEKPgo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEdvdyA8ZGF2aWRnb3dA
Z29vZ2xlLmNvbT4KPiAtLS0KPiAgYXJjaC94ODYvTWFrZWZpbGUudW0gfCA2ICsrKysrKwo+ICAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
TWFrZWZpbGUudW0gYi9hcmNoL3g4Ni9NYWtlZmlsZS51bQo+IGluZGV4IGIzYzFhZTA4NDE4MC4u
ZDJlOTVkMWQ0ZGI3IDEwMDY0NAo+IC0tLSBhL2FyY2gveDg2L01ha2VmaWxlLnVtCj4gKysrIGIv
YXJjaC94ODYvTWFrZWZpbGUudW0KPiBAQCAtMSw2ICsxLDEyIEBACj4gICMgU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjAKPiAgY29yZS15ICs9IGFyY2gveDg2L2NyeXB0by8KPgo+ICsj
Cj4gKyMgRGlzYWJsZSBTU0UgYW5kIG90aGVyIEZQL1NJTUQgaW5zdHJ1Y3Rpb25zIHRvIG1hdGNo
IG5vcm1hbCB4ODYKPiArIwo+ICtLQlVJTERfQ0ZMQUdTICs9IC1tbm8tc3NlIC1tbm8tbW14IC1t
bm8tc3NlMiAtbW5vLTNkbm93IC1tbm8tYXZ4Cj4gK0tCVUlMRF9SVVNURkxBR1MgKz0gLUN0YXJn
ZXQtZmVhdHVyZT0tc3NlLC1zc2UyLC1zc2UzLC1zc3NlMywtc3NlNC4xLC1zc2U0LjIsLWF2eCwt
YXZ4Mgo+ICsKPiAgaWZlcSAoJChDT05GSUdfWDg2XzMyKSx5KQo+ICBTVEFSVCA6PSAweDgwNDgw
MDAKPgo+IC0tCj4gMi4zOS4wLjMxNC5nODRiOWE3MTNjNDEtZ29vZwo+CgpSZXZpZXdlZC1ieTog
U2VyZ2lvIEdvbnrDoWxleiBDb2xsYWRvIDxzZXJnaW8uY29sbGFkb0BnbWFpbC5jb20+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWls
aW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
