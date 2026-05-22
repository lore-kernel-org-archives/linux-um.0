Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A07CD5BB0
	for <linux-um@archiver.kernel.org>; Fri, 22 May 2026 15:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HscsaAI3zhZlQIP3MYlUDUTcu4itN8t1ArqO/C1kFEI=; b=pz3TXF1AgWr6ibqRJ1zzWsQWaV
	zc5n87ZlLUQtRLSnGgp0sB3XFWTvmYEbI/B6nRVDvrsPl9XFAgsUTQvDRJhi8P5kvq60s3Oo9iGsq
	SQreadeYuaopN+h7b9DTZmwDiHHEIlk/0f462V5QnyKRu70OteOo0IFftPi2mapyY/E6Pm6gCd2nn
	xmq5SPB/zp+mgRP8INmGTYSA6qkyEhQQMNcBrGKjV/nJ9jNkEZnLKgC4t8YsMDB8bKs6ibhfXV3me
	mLVzJf3v0hc8ehPiMplILHSc0kIl+r8ZRarvm2TtUkyrsS5YZ6ccWtjnCBSCLLt9Z259Sg8hi90G/
	ZVHjDSVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQS58-0000000BK87-3gOg;
	Fri, 22 May 2026 15:46:38 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQS56-0000000BK6a-1Q7Q
	for linux-um@lists.infradead.org;
	Fri, 22 May 2026 15:46:37 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-67c1e0229acso12399846a12.1
        for <linux-um@lists.infradead.org>; Fri, 22 May 2026 08:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779464794; x=1780069594; darn=lists.infradead.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HscsaAI3zhZlQIP3MYlUDUTcu4itN8t1ArqO/C1kFEI=;
        b=Fcp+yPVAyfnUjKK5Y6ey2jFdwacOKERxroeXKf7VIfQhw0G4zsb/FJXYJF+BUmHGix
         ridpyADbf9eQdUiHIcL1o9WUhI2u/ytmaLZsUIZF4e7GUndMgHzLm1QXTFlsBeokETr4
         fmSErlBTQF6yb/pCttMK2m0HNECxyXtPE4lW6dUe0xwd//tz+pHQD3Mr651woPm6LTKD
         aijeYIjTEvNTE8ERCWGtHw35jIvwZ8tCfBqUFgs+dB3mzwLydhlecI16q/TOzp9ngqyk
         /p753wkF9aYNGHzWrudfFuQXRi263LZaesdsaLzbx42XoACAqU24UYd7FzCp3XUepeL0
         9jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779464794; x=1780069594;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HscsaAI3zhZlQIP3MYlUDUTcu4itN8t1ArqO/C1kFEI=;
        b=qqOtz3igReBn9NUJcn7ZnRm934cNnvFCIUHCjGpuVzwLLxR+RAXocs517LIYN35TEU
         InP6npX9TYocanwoB7jGPZ2vIMPJEE1eWKmO81q7bhN75RhnAVEX86GqCoDGFGfX2peA
         MNasLazaEKXt4RoqYo2WPx0xmg8klE6FkZUA7ere0a2Z4CW7r6/LIQbBI9Ll5sngv7TZ
         4fFH/D0uG72UKmM95oiCY3NR//iRMCtyVNXuGzYYSVdXQXhrdiD4suJx4W5Ec8S5Tw1c
         Ww7eKu1tvdj85+31Ucn82IuoSzi8hqJK/Vu5jm9VhZtW2TSL1DKOuz/zFGRw5FBSvIDK
         4nyA==
X-Forwarded-Encrypted: i=1; AFNElJ8yED8r77TZzTD2F6naBqUCwWjMMjYu8Z1w04VaBy62nvbaqESZQk9U4XMoVQc50vWn4+SY/xwHzQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw/ZbXqZ7etHQPjsX61e9qJz217ZI+S3jehTUbk3WaWTfrMR0fM
	9Qs/b4KwwW83p0m6yBsgQVeOlAU890YzRWZJ5QQsusyKdowUkEK1NmT8YAPmmMetBTE1cpmuAwR
	/BeHmy94=
X-Gm-Gg: Acq92OFgZt+q8X8NVj7wNfI2CZXZB4xCgQUfamepqDf0UO/M+WgjrM3ti/3RKOd90jY
	MmqKcld+jPYa/aRyODk37cGwqD2mwAin2Y3RvdeRwCsK0YUBIcHUq4K/XwdS2myYodf4wEYp2/Z
	vyQVrroW9cn5uyy1E3SLLbwBGEqe4gi83fQNcvbFce3xZVXrhyHMO5hQowaiRWJMOVZVfW6AyYF
	y3MyoMsgnst4iJXqnWL+/GlkV8yKGKOdEIBQQRth8+8ckRzSBt8K0Z/b3mP9/pAtemL5WLurQrw
	6pQsQkq2OQ0Cd6uEVW+l/5mftVvrksyPb7eNNtdd92XTeEpcRVw230mOz6zm3CKLXoxf58fPHur
	nVe8O7oT4TdzKrdJtmS8vXcKJYOYUf9J3QynHQKCARoYwd98mvquJftpOgYhkb11pQAD8DdlAve
	nVI9khnRtiJf+WJ2slDcCncWCj7Rvq2SUWXICvf2f8L5WX3T3DHp9vTPtM12zmG/YcyOijfG8SW
	l4ZsZO+bbi2WcNvXpMEoSYaR7qrWDCsSN4T6YvG3Qj+F6bwZTNvLA==
X-Received: by 2002:a17:907:388b:b0:bd5:ca8:768c with SMTP id a640c23a62f3a-bdd2a4fdcf4mr289445166b.31.1779464793594;
        Fri, 22 May 2026 08:46:33 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc264d98asm69732666b.9.2026.05.22.08.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 08:46:33 -0700 (PDT)
Message-ID: <57e5a8e2-d277-459b-a10f-48c5f1b5f0cf@suse.com>
Date: Fri, 22 May 2026 17:46:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] x86: remove dependencies on CONFIG_M... CPU options
To: Arnd Bergmann <arnd@kernel.org>, Ingo Molnar <mingo@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Weinberger <richard@nod.at>,
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
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
References: <20260522141959.1071595-1-arnd@kernel.org>
 <20260522141959.1071595-6-arnd@kernel.org>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
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
In-Reply-To: <20260522141959.1071595-6-arnd@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0sUiYbLOi0ZyBSUicwgRdp05"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_084636_441829_C04581F7 
X-CRM114-Status: GOOD (  20.52  )
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
--------------0sUiYbLOi0ZyBSUicwgRdp05
Content-Type: multipart/mixed; boundary="------------bCajkPKCdMRK0Et9O0MbwJNh";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Arnd Bergmann <arnd@kernel.org>, Ingo Molnar <mingo@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Weinberger <richard@nod.at>,
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
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Message-ID: <57e5a8e2-d277-459b-a10f-48c5f1b5f0cf@suse.com>
Subject: Re: [PATCH 5/8] x86: remove dependencies on CONFIG_M... CPU options
References: <20260522141959.1071595-1-arnd@kernel.org>
 <20260522141959.1071595-6-arnd@kernel.org>
In-Reply-To: <20260522141959.1071595-6-arnd@kernel.org>

--------------bCajkPKCdMRK0Et9O0MbwJNh
Content-Type: multipart/mixed; boundary="------------OV6Dhj0Zp00cHWVDjxGNEapk"

--------------OV6Dhj0Zp00cHWVDjxGNEapk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjIuMDUuMjYgMTY6MTksIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+IEZyb206IEFybmQg
QmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+IA0KPiBDUFUgc3BlY2lmaWMgZmVhdHVyZXMg
c2hvdWxkIGdlbmVyYWxseSBiZSBjb250cm9sbGVkIGJ5DQo+IENQVV9TVVBfeHh4IG9wdGlv
bnMgcmF0aGVyIHRoYW4gQ09ORklHX014eHgsIHRvIGFsbG93DQo+IGdlbmVyaWMga2VybmVs
cyB0byBiZSBidWlsdCB0aGF0IHdvcmsgd2l0aCBhbGwgb2YgdGhlbS4NCj4gDQo+IFJlcGxh
Y2UgdGhlIGZldyBvcHRpb25zIHRoYXQgZG9uJ3QgZm9sbG93IHRoaXMgc2NoZW1lDQo+IHdp
dGggY2hlY2tzIG9uIGVpdGhlciBDUFVfU1VQX3h4eCBvciBYODZfUEFFIGJ5IGl0c2VsZi4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+
IC0tLQ0KPiAgIGFyY2gveDg2L2tlcm5lbC90c2MuYyAgICB8IDIgKy0NCj4gICBhcmNoL3g4
Ni94ZW4vS2NvbmZpZyAgICAgfCAzICstLQ0KPiAgIGRyaXZlcnMvbWlzYy9tZWkvS2NvbmZp
ZyB8IDIgKy0NCj4gICAzIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvdHNjLmMgYi9h
cmNoL3g4Ni9rZXJuZWwvdHNjLmMNCj4gaW5kZXggZTdhNDM0NzE3ODNmLi4zZDVkMzgwMzVj
NTIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC90c2MuYw0KPiArKysgYi9hcmNo
L3g4Ni9rZXJuZWwvdHNjLmMNCj4gQEAgLTEyMTMsNyArMTIxMyw3IEBAIHN0YXRpYyB2b2lk
IF9faW5pdCB0c2NfZGlzYWJsZV9jbG9ja3NvdXJjZV93YXRjaGRvZyh2b2lkKQ0KPiAgIA0K
PiAgIHN0YXRpYyB2b2lkIF9faW5pdCBjaGVja19zeXN0ZW1fdHNjX3JlbGlhYmxlKHZvaWQp
DQo+ICAgew0KPiAtI2lmIGRlZmluZWQoQ09ORklHX01HRU9ERUdYMSkgfHwgZGVmaW5lZChD
T05GSUdfTUdFT0RFX0xYKSB8fCBkZWZpbmVkKENPTkZJR19YODZfR0VORVJJQykNCj4gKyNp
ZiBkZWZpbmVkKENPTkZJR19DUFVfU1VQX0NZUklYXzMyKQ0KPiAgIAlpZiAoaXNfZ2VvZGVf
bHgoKSkgew0KPiAgIAkJLyogUlRTQyBjb3VudHMgZHVyaW5nIHN1c3BlbmQgKi8NCj4gICAj
ZGVmaW5lIFJUU0NfU1VTUCAweDEwMA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYveGVuL0tj
b25maWcgYi9hcmNoL3g4Ni94ZW4vS2NvbmZpZw0KPiBpbmRleCBhYTQwNDBmZDkyMTUuLjdl
NzRkYjY1MjIxNSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYveGVuL0tjb25maWcNCj4gKysr
IGIvYXJjaC94ODYveGVuL0tjb25maWcNCj4gQEAgLTEwLDggKzEwLDcgQEAgY29uZmlnIFhF
Tg0KPiAgIAlzZWxlY3QgWDg2X0hWX0NBTExCQUNLX1ZFQ1RPUg0KPiAgIAlzZWxlY3QgSElC
RVJOQVRFX0NBTExCQUNLUw0KPiAgIAlkZXBlbmRzIG9uIFg4Nl82NCB8fCAoWDg2XzMyICYm
IFg4Nl9QQUUpDQo+IC0JZGVwZW5kcyBvbiBYODZfNjQgfHwgKFg4Nl9HRU5FUklDIHx8IE1Q
RU5USVVNNCB8fCBNQVRPTSkNCj4gLQlkZXBlbmRzIG9uIFg4Nl9MT0NBTF9BUElDICYmIFg4
Nl9UU0MNCj4gKwlkZXBlbmRzIG9uIFg4Nl9MT0NBTF9BUElDDQoNClRoaXMgaXMgcHJvYmxl
bWF0aWMuIFNlZSBjb21taXQgOTNjZDA1OTc2NDk4Lg0KDQpNYXliZSB1c2UgImRlcGVuZHMg
b24gWDg2X0xPQ0FMX0FQSUMgJiYgWDg2X0wxX0NBQ0hFX1NISUZUID49IDYiIGluc3RlYWQ/
DQoNCg0KSnVlcmdlbg0K
--------------OV6Dhj0Zp00cHWVDjxGNEapk
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------OV6Dhj0Zp00cHWVDjxGNEapk--

--------------bCajkPKCdMRK0Et9O0MbwJNh--

--------------0sUiYbLOi0ZyBSUicwgRdp05
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmoQelgFAwAAAAAACgkQsN6d1ii/Ey+/
4Af/ZLKY4LkqFNN2G01/uHhyz7SlA3EVFqtyooR+dOSIijc+2gItl/Cpe2aACA+twww2BJdQuC/k
FNznZuW1jqtVU8/6fXjRcJedOT/o4RXqScQlwRapZTyvq1Zv35qpsoXC2sBZmfvHvhfMFsWoHuBV
Hx33xNGo+9XtMf4MY+pKxtLr263dgMLgiVHzReR9bZvjOaNympWWMIWqYWew118hChhedxO4d2LT
jvPOz9dIf5SekoN3l+86p7NTD44tOA2mKbfu2IQliADNLm0s2N1a+Io5b3hjbd5M8dxMr23tzQHv
ucfgeq5YYN94HrpZBesMN+qkpURdi0EdXYkYj2DKSg==
=v6VZ
-----END PGP SIGNATURE-----

--------------0sUiYbLOi0ZyBSUicwgRdp05--

