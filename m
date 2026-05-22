Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FD6CD5BB0
	for <linux-um@archiver.kernel.org>; Fri, 22 May 2026 19:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vLMJ+CEK8P+inVymr0G/EuKdkQwloNlCzxx6/7+0C/E=; b=04zuatjQLIjkb2YyhmKhgnUgLm
	al6PpKhksqAURpC7t/4g80kYasKqkPocKxHqq6MYZ4DvAF6Ko/8bSPSjg4DlgqvGx05X1XBzBn0nW
	lmC66f5kLx7b4GouK0Kkt+PmqD87Bu2YBSJu4lOWV4Ng3G/2BZenZ1VI1MILnbovthlSSrw1H0fLe
	DGZUm8d126d1A/IpwNbBeFeWOXL6QF8quF/uhW9uEXk4amdEiVFvQjjsZjm3B+dYY4KbCJvK7n+1n
	1PQ0LGmpqfJgjUoEkV9IMyBjcVyV7ygtcYRxB2igpsz4pg87gyYy4Dihpcmiz44LSly6Y4UgA70Qz
	sjeMqX1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQV6M-0000000BjIb-0VUc;
	Fri, 22 May 2026 19:00:06 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQV6J-0000000BjDZ-3DeX
	for linux-um@lists.infradead.org;
	Fri, 22 May 2026 19:00:05 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so12620351a12.1
        for <linux-um@lists.infradead.org>; Fri, 22 May 2026 12:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779476402; x=1780081202; darn=lists.infradead.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vLMJ+CEK8P+inVymr0G/EuKdkQwloNlCzxx6/7+0C/E=;
        b=NT1m7ZE0IIGByPt186aDfW3+GvyEAzPnApTTppQIo/IZ0BbeeXss9rAkSHhJI9CLtF
         3lR36nTd3qqWUW1fvtJ5b0DyB+/Zbu6o+br51rwZhN26uLwTaxDyHHu4J1kOOI8MwuX0
         csJ3+jI2RW/fzJY7l8Zti7RMuDgRH1TSKp/vZVEeoTT4ckPPfXowdn+Ns+YJdULTioCG
         JmCpFT5/v4mOdzqCQV8p5XD5Lui0MSOxp12ArOVof9Iyt8ItA4WgVKgYp36mk7UAjlHM
         vlMUGki92NtejLQMClyTqNHm3Oz9UMi1p3f2hqWmi/Sm2fleOzDaNTJawndiawiL9UHT
         JS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779476402; x=1780081202;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLMJ+CEK8P+inVymr0G/EuKdkQwloNlCzxx6/7+0C/E=;
        b=RJ8bGq9P/yROi8EWUTyMEUn96Z3NP/6zy3cKueHOZrcVOooDw4iCseO7D2RevMrncw
         671h269HcZihIDErQmUFZyVu7jJSEcQPrC6LVJnL5xCthDKP0odh4EXCjaQqW7/bx9dL
         Gra/NCNafE0ewbMfP3eP/1xESaZeLuOdEMaZeB+apmntABEaefJqnCMrME+OcK3j0hbe
         RFJV3FqqA4v5ldMGtZWL3BRLI4ET2R2LASWRZN20+LKgDECHrP8eYgInGqzGjyFHbZPA
         4z6iEaPSpcfyxLJf+mk2GwH2jU562MJ8Ty0ZcsFfPgqbeMi4rlOKqfZxNepHWA2DWjdJ
         q/vg==
X-Forwarded-Encrypted: i=1; AFNElJ+1jieGx1ZVgPZYltt0ikbh0QoTEx8s7Ym7HzbZEtbZyoEXrgYw1iLGJniC72kjbZA145++/3mqXw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyNmTt1VfkJQdmsycEOt+lEV84xg6JkiQ1bJzXsX8mhAIbkevYZ
	0C+/c3KhTMu9yJqhVVreWFOP30+kvJH6eTg/iY2+mS85GZgmiVYZR792gH89Rsu1PzQ=
X-Gm-Gg: Acq92OHbsgPoFaDQcDpzZJSzMoKGeYXNs9vOiidB6PTeYzPCmE4bZyUf5V8yShuruzs
	5uZFKhvEIgW/VrYnrktriO6fNemKRkVdu3qwgKpNTYGif5muW8NSHFAQfgzNjYt/5GdMvwNZJl4
	nHptg7DVLtii+UMXeqegHAYLNbi05LYiJTk2eEOg7SvDbB3waQWvw7Q8FH1MmLQLV06tkGprgi0
	CJn/vEIVEFwdl4Dyo4ao17/FCjVWb5M+5kCEWGIcSi/qa/QwSV3rPCn+Tux/0dblXT4QwRlwDHQ
	mntuk6fkouNzQwGx2/PbAWvpRc0vDU+3N9f9brvZ4s5BgJWBfbUmFabHgR80r92vcjKLJvN10Lg
	1/ICVGEp788cCkWWd1wMMBoy9Np5RCzrAqs1lD6asi9E75AcGVbdC0+7AVHPZwrFL33zgEc6Tch
	u0sphFFKolelF5efdvuUn8noh/EJfwSXoo9N+yn+QYl96cmxZeXotUsBvPxRx+eFJ/P6nL0Z4Ny
	PgUGjvXuYaYN6sa01+/bqTWFUkXKg4RB0J7hLi//MrtSwkwlXzepw==
X-Received: by 2002:a17:907:a394:b0:bda:254d:4761 with SMTP id a640c23a62f3a-bdd277c8310mr360519666b.31.1779476401776;
        Fri, 22 May 2026 12:00:01 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc66d5b1csm84371066b.56.2026.05.22.12.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 12:00:01 -0700 (PDT)
Message-ID: <be2e816b-3940-4d1e-922f-2c4687d3e09b@suse.com>
Date: Fri, 22 May 2026 21:00:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] x86: remove dependencies on CONFIG_M... CPU options
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 Ingo Molnar <mingo@redhat.com>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner
 <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Alexander Usyskin <alexander.usyskin@intel.com>,
 Anthony L Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
References: <20260522141959.1071595-1-arnd@kernel.org>
 <20260522141959.1071595-6-arnd@kernel.org>
 <57e5a8e2-d277-459b-a10f-48c5f1b5f0cf@suse.com>
 <caee6c86-00ee-4f91-b449-f91606d03942@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <caee6c86-00ee-4f91-b449-f91606d03942@app.fastmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------640Tq8LPeRKPKSjj8ZHo95oo"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_120003_875856_A3A127E6 
X-CRM114-Status: GOOD (  19.51  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------640Tq8LPeRKPKSjj8ZHo95oo
Content-Type: multipart/mixed; boundary="------------rS5gqBxRBbuva5z4BxBWRIaS";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 Ingo Molnar <mingo@redhat.com>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner
 <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Alexander Usyskin <alexander.usyskin@intel.com>,
 Anthony L Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Message-ID: <be2e816b-3940-4d1e-922f-2c4687d3e09b@suse.com>
Subject: Re: [PATCH 5/8] x86: remove dependencies on CONFIG_M... CPU options
References: <20260522141959.1071595-1-arnd@kernel.org>
 <20260522141959.1071595-6-arnd@kernel.org>
 <57e5a8e2-d277-459b-a10f-48c5f1b5f0cf@suse.com>
 <caee6c86-00ee-4f91-b449-f91606d03942@app.fastmail.com>
In-Reply-To: <caee6c86-00ee-4f91-b449-f91606d03942@app.fastmail.com>

--------------rS5gqBxRBbuva5z4BxBWRIaS
Content-Type: multipart/mixed; boundary="------------7mEqowKyfmEmuZaqrvYn6nqJ"

--------------7mEqowKyfmEmuZaqrvYn6nqJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjIuMDUuMjYgMjA6NTQsIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+IE9uIEZyaSwgTWF5
IDIyLCAyMDI2LCBhdCAxNzo0NiwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+IE9uIDIyLjA1
LjI2IDE2OjE5LCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0KPj4+DQo+Pj4gLS0tIGEvYXJjaC94
ODYveGVuL0tjb25maWcNCj4+PiArKysgYi9hcmNoL3g4Ni94ZW4vS2NvbmZpZw0KPj4+IEBA
IC0xMCw4ICsxMCw3IEBAIGNvbmZpZyBYRU4NCj4+PiAgICAJc2VsZWN0IFg4Nl9IVl9DQUxM
QkFDS19WRUNUT1INCj4+PiAgICAJc2VsZWN0IEhJQkVSTkFURV9DQUxMQkFDS1MNCj4+PiAg
ICAJZGVwZW5kcyBvbiBYODZfNjQgfHwgKFg4Nl8zMiAmJiBYODZfUEFFKQ0KPj4+IC0JZGVw
ZW5kcyBvbiBYODZfNjQgfHwgKFg4Nl9HRU5FUklDIHx8IE1QRU5USVVNNCB8fCBNQVRPTSkN
Cj4+PiAtCWRlcGVuZHMgb24gWDg2X0xPQ0FMX0FQSUMgJiYgWDg2X1RTQw0KPj4+ICsJZGVw
ZW5kcyBvbiBYODZfTE9DQUxfQVBJQw0KPj4NCj4+IFRoaXMgaXMgcHJvYmxlbWF0aWMuIFNl
ZSBjb21taXQgOTNjZDA1OTc2NDk4Lg0KPj4NCj4+IE1heWJlIHVzZSAiZGVwZW5kcyBvbiBY
ODZfTE9DQUxfQVBJQyAmJiBYODZfTDFfQ0FDSEVfU0hJRlQgPj0gNiIgaW5zdGVhZD8NCj4g
DQo+IEFmdGVyIHBhdGNoIDYvOCwgdGhpcyBpcyBhbHdheXMgdHJ1ZSwgc28gSSBzdXBwb3Nl
IGl0IHdvdWxkDQo+IGlmIHRoYXQgY2FtZSBmaXJzdCwgcmlnaHQ/DQoNClllcywgYWdyZWVk
Lg0KDQo+IA0KPiBPbiBhIHJlbGF0ZWQgbm90ZSwgYXJlIHRoZXJlIHN0aWxsIHJlbWFpbmlu
ZyBYZW4gdXNlcnMgb24gbmV3DQo+IDMyLWJpdCBndWVzdCBrZXJuZWxzPyBJIHVuZGVyc3Rh
bmQgdGhhdCBvbmUgY291bGQgc3RpbGwgcnVuDQo+IG1vZGVybiBrZXJuZWxzIG9uIDMyLWJp
dCBYZW4tNC4yIChFT0wgaW4gMjAxNSksIGFuZCB0aGF0IDY0LWJpdA0KPiBYZW4gc3RpbGwg
c3VwcG9ydHMgb2xkZXIgMzItYml0IGd1ZXN0IG9wZXJhdGluZyBzeXN0ZW1zIGZvcg0KPiBj
b21wYXRpYmlsaXR5LCBidXQgSSdtIG5vdCBzdXJlIGlmIHRoZXJlIGlzIGFueSByZWFzb24g
dG8NCj4gbGVnaXRpbWF0ZWx5IHJ1biBhIDMyLWJpdCBsaW51eC03Lngga2VybmVsIG9uIGEg
NjQtYml0IFhlbg0KPiBpbnN0ZWFkIG9mIHJ1bm5pbmcgYSBiZXR0ZXIgc3VwcG9ydGVkIDY0
LWJpdCBndWVzdCBrZXJuZWwuDQoNCiBGcm9tIHRoZSBsb2dpY2FsIHBvaW50IG9mIHZpZXcg
SSB0b3RhbGx5IGFncmVlLiBPVE9IIHVzZXJzIGFyZSBodW1hbnMsDQpzbyB0aGV5IG1pZ2h0
IG5vdCBhZ3JlZSB3aXRoIHRoYXQuIDstKQ0KDQoNCkp1ZXJnZW4NCg==
--------------7mEqowKyfmEmuZaqrvYn6nqJ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------7mEqowKyfmEmuZaqrvYn6nqJ--

--------------rS5gqBxRBbuva5z4BxBWRIaS--

--------------640Tq8LPeRKPKSjj8ZHo95oo
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmoQp7AFAwAAAAAACgkQsN6d1ii/Ey9a
6QgAh5MBUP/4OpwuaOyZwc6fsSJlVytQDOtm/rf1gQY/S3CAsPTsSNh28+h2a7UtqXWlER1tTCyS
sjVY61LeybsoMOiIlkG8eXJUskAPN5GPZxHN2QrIc6ry+1RmfqjYLBeiLQqAUGT1h6VrELQBSGJV
g9pyiPANpbY1+mRlhI4OJIEHkwnEn+7YEQmaUP1B9qsfjJNKvvfpeJgslKGIQEfya34a3o5OAFDd
oseGtkwjVV69i2YN6sXlralYLtlxp2Z3x0GZELPqilU+y/HEAStERbyuAkND30F4pWg1FnXrB667
6I32ZWX0sCsZylu8hGqz/vGhWUAFodyXMBLbUYpniA==
=sWHU
-----END PGP SIGNATURE-----

--------------640Tq8LPeRKPKSjj8ZHo95oo--

