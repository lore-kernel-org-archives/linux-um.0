Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65B0CDB47E
	for <linux-um@archiver.kernel.org>; Fri, 20 Oct 2023 10:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:
	Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z/FA+p6Q26Of5Kz+sxyZ/OzrWvhvAw+E2SzblWFFjI0=; b=WhQtdCN8ewBi6w7IiBFuClVqkI
	cOgIG+RMGpMzD2qHWYMfkfsBi4PR8yLAiv2uxUIitRNFdgdFiKoMh0YioEPvXyuxpOLs0r4yYtbuG
	UcG4feC+eDK7CUlvgdtCjTZWnvc1JC88GJhbSfIDFJ97+INWlIrmZ7scCXRG622R2Ntf02Dd63Vrt
	tOqneSoI173YdnPk219h6phlwgPox9c1Mf6ND5rEdGSnn/BE4abFfh3LY9hMfZCtyYFrgQL2VqOAA
	s5KhyExQAC4MO0Dc0+lQb2q1Pg9ttiMexczxd+SzvXEKhWYTFoLlq9KW2+JaQ3tVU2360tvyUomTs
	lj3FtNQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtmuC-001nkS-1Q;
	Fri, 20 Oct 2023 10:39:00 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtmu9-001nhp-09
	for linux-um@lists.infradead.org;
	Fri, 20 Oct 2023 10:38:59 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 20 Oct 2023 10:38:55 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1697798335; bh=cvbH77NQzwTocC1knJHOzbHdE2Q3hG/ueyMafcjaHik=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 iEnMt91t6B5yxKlMXSUQAe/FHPy55sB8wll6b6QpMBir2Dmon4tgDZtiDBrr/1qQ6ij+NFDFwhwld4/RUNH9BA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1697798335; bh=cvbH77NQzwTocC1knJHOzbHdE2Q3hG/ueyMafcjaHik=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 B8bXif0RFgNDSO+1sSaItRJYr2MK4NVOJrZEwnMLtFM4EgjdJN4X0dFZXJttpC3jyWsSBAlVpMnKX2vb1Lehow4T07ZkclessECuveDgy7nIPM8ScZAo9jX88lqP6CHUuZJ0onHKKDByS2HXJ+kVVWukzhNcUMhTOeT33Expu/8=
Received: from [139.30.201.32] (139.30.201.32) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 20 Oct
 2023 12:38:53 +0200
Message-ID: <549de9c0-05f8-437e-8460-5b013b0cd87b@uni-rostock.de>
Date: Fri, 20 Oct 2023 12:38:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] um: irqs: process outstanding IRQs when unblocking
 signals
Content-Language: de-DE
To: <linux-um@lists.infradead.org>
References: <20231018123643.1255813-1-benjamin@sipsolutions.net>
 <6082036a-c7f9-4bd5-8234-14957ed9953d@uni-rostock.de>
 <11ab4d47dd8fdcdc2148e00618cc496866016883.camel@sipsolutions.net>
From: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=C3=A4t_Rostock?=
In-Reply-To: <11ab4d47dd8fdcdc2148e00618cc496866016883.camel@sipsolutions.net>
X-Originating-IP: [139.30.201.32]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: E16AEC76C8068575AA8CE4DC73141CBA74D34F000CE9264CB3EE84C8B363A2F92000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_033857_388804_A245CD78 
X-CRM114-Status: GOOD (  15.22  )
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
Content-Type: multipart/mixed; boundary="===============5814192092934383499=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

--===============5814192092934383499==
Content-Language: de-DE
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------4W8rqTyWsQYNvGFGmCkJclOT"

--------------4W8rqTyWsQYNvGFGmCkJclOT
Content-Type: multipart/mixed; boundary="------------ryLZHYTZU35s1m9U0qBfD7Y5";
 protected-headers="v1"
From: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
To: linux-um@lists.infradead.org
Message-ID: <549de9c0-05f8-437e-8460-5b013b0cd87b@uni-rostock.de>
Subject: Re: [PATCH 1/4] um: irqs: process outstanding IRQs when unblocking
 signals
References: <20231018123643.1255813-1-benjamin@sipsolutions.net>
 <6082036a-c7f9-4bd5-8234-14957ed9953d@uni-rostock.de>
 <11ab4d47dd8fdcdc2148e00618cc496866016883.camel@sipsolutions.net>
In-Reply-To: <11ab4d47dd8fdcdc2148e00618cc496866016883.camel@sipsolutions.net>

--------------ryLZHYTZU35s1m9U0qBfD7Y5
Content-Type: multipart/mixed; boundary="------------nuYJKvGL62mOU4l3WAwIm0lh"

--------------nuYJKvGL62mOU4l3WAwIm0lh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

QW0gMjAuMTAuMjAyMyB1bSAxMTo1OSBzY2hyaWViIEJlbmphbWluIEJlcmc6DQo+Pg0KPj4g
SSBhbHNvIG5vdGljZWQgdGhpcyBwcm9ibGVtLCBidXQgYWZ0ZXIgYSBkaXNjdXNzaW9uIHdp
dGggSm9oYW5uZXMgQmVyZw0KPj4gYWJvdXQgdGhpcywgd2UgY29tZSB0byB0aGUgY29uY2x1
c2lvbiwgdGhhdCBhbGwgZHJpdmVycyB3aXRoIGludGVycnVwdHMNCj4+IG5lZWQgdG8gZGVh
bCB3aXRoIHRpbWUgdHJhdmVsIG1vZGUgdmlhIHRoZWlyIG93biB0aW1lIHRyYXZlbCBoYW5k
bGVyLg0KPj4gV2hhdCBJIGFjdHVhbGx5IGRpZCwgd2FzIHRvIHdyaXRlIGEgdHJpdmlhbCBo
YW5kbGVyIGZvciBlLmcuLCB0aGUgc2VyaWFsDQo+PiBsaW5lLCB3aGljaCBzaW1wbHkgb25s
eSBjYWxsIHRpbWVfdHJhdmVsX2FkZF9pcnFfZXZlbnQoZXYpLg0KPiANCj4gWWVzLCB3ZSBj
b3VsZCBpbnN0ZWFkIGp1c3QgYXNzZXJ0IHRoYXQgd2UgZG8gbm90IGhhdmUgYW55IElSUSB3
aXRob3V0IGENCj4gdGltZXRyYXZlbCBoYW5kbGVyLiBXZSByZWFsbHkgc2hvdWxkbid0IGhh
dmUsIGJ1dCB3ZSBkbyBoYXZlIG9uZSBmb3INCj4gc3RkaW4gdW5mb3J0dW5hdGVseSAod2hp
Y2ggaXMgYXQgbGVhc3QgdXNlZCBieSB0aGUgaG9zdGFwIGh3c2ltIHRlc3RzLA0KPiBzbyB3
ZSBtaWdodCB3YW50IHRvIG5vdCByZW1vdmUgaXQgdW50aWwgd2UgaGF2ZSBhIGRpZmZlcmVu
dCBzb2x1dGlvbikuDQo+IA0KPiBXaGF0IHdlIGNvdWxkIGRvIGlzIGp1c3QgYWRkIGFuIHN0
ZGluIHRpbWV0cmF2ZWwgaGFuZGxlciBhcyB5b3UgaGF2ZQ0KPiBkb25lLCBidXQgcHJpbnQg
YSB3YXJuaW5nIHdoZW4gdGhlIHN0ZGluIElSUSBpcyByZWdpc3RlcmVkWzFdLiBBbmQNCj4g
dGhlbiwgaWYgc29tZW9uZSB0cmllcyB0byByZWdpc3RlciBhbiBJUlEgd2l0aG91dCBhIHRp
bWUtdHJhdmVsIGhhbmRsZXINCj4gd2UganVzdCBwYW5pYygpLCBpdCBzaG91bGQgbmV2ZXIg
aGFwcGVuLg0KQ2FuIHlvdSBleHBsYWluLCB3aHkgYSB0aW1lIHRyYXZlbCBoYW5kbGVyIGZv
ciBzdGRpbiBtYXkgYmUgYmFkPyBJdCANCnNvdW5kcyBsaWtlIHlvdSB3YW50IHRvIGF2b2lk
IGl0LCBidXQgSSBzZWUgbm8gaW1tZWRpYXRlIHByb2JsZW0uDQoNCj4gDQo+IEJlbmphbWlu
DQo+IA0KPiBbMV0gV2UnbGwgYWxzbyBuZWVkIHRvIHNldCBzdGRpbiB0byBiZSBhICJudWxs
IiBjaGFubmVsIGFuZCB0aGVuDQo+IHNvbWVob3cgYXZvaWQgcmVnaXN0ZXJpbmcgdGhlIElS
USBpbiB0aGF0IGNhc2UuDQo+IA0KDQotLSANCk0uU2MuIEJlbmphbWluIEJlaWNobGVyDQoN
ClVuaXZlcnNpdMOkdCBSb3N0b2NrLCBGYWt1bHTDpHQgZsO8ciBJbmZvcm1hdGlrIHVuZCBF
bGVrdHJvdGVjaG5paw0KSW5zdGl0dXQgZsO8ciBBbmdld2FuZHRlIE1pa3JvZWxla3Ryb25p
ayB1bmQgRGF0ZW50ZWNobmlrDQoNClVuaXZlcnNpdHkgb2YgUm9zdG9jaywgRGVwYXJ0bWVu
dCBvZiBDUyBhbmQgRUUNCkluc3RpdHV0ZSBvZiBBcHBsaWVkIE1pY3JvZWxlY3Ryb25pY3Mg
YW5kIENFDQoNCkFsYmVydC1FaW5zdGVpbi1TdHIuIDI2DQoxODA1OSBSb3N0b2NrDQpEZXV0
c2NobGFuZC9HZXJtYW55DQoNCnBob25lOiArNDkgKDApIDM4MSA0OTggLSA3Mjc4DQplbWFp
bDogQmVuamFtaW4uQmVpY2hsZXJAdW5pLXJvc3RvY2suZGUNCnd3dzogaHR0cDovL3d3dy5p
bWQudW5pLXJvc3RvY2suZGUvDQoNCg==
--------------nuYJKvGL62mOU4l3WAwIm0lh
Content-Type: application/pgp-keys; name="OpenPGP_0x1569BBF90AC3918A.asc"
Content-Disposition: attachment; filename="OpenPGP_0x1569BBF90AC3918A.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEW08D4RYJKwYBBAHaRw8BAQdARRw5LUE0LoG/3A8AuH6shJZQcVbm0p/m5fCc
3FkaJ6vNKkJlbmphbWluIEJlaWNobGVyIDxoYWRyaWFuMjAwMkBmcmVlbmV0LmRl
PsKWBBMWCAA+FiEE6qkQGP12r5eYfxTHFWm7+QrDkYoFAmIvW3MCGyMFCQ0OX5IF
CwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQFWm7+QrDkYqH5AD+JVDmECMgMC6h
QJ/g7HgwGRPQPvMuQ9Xm6OVFSyzNI/AA/2/BvinRs5oX7+gBjFExuWcfSS9DKxiT
jZQO3t8z8FgNwpYEExYIAD4WIQTqqRAY/Xavl5h/FMcVabv5CsORigUCW08ERgIb
IwUJB5SrvwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRAVabv5CsORilzwAP9x
T8dX7YDDPEuxXl9lvWOhbI8p0wObh+avjjCTCBzwDwEAmPQCDUbN0wTzbEprAZF8
SOH0ac0wN/U7Raq+1YBepwrNNUJlbmphbWluIEJlaWNobGVyIDxiZW5qYW1pbi5i
ZWljaGxlcjJAdW5pLXJvc3RvY2suZGU+wpYEExYIAD4WIQTqqRAY/Xavl5h/FMcV
abv5CsORigUCYi9bcwIbIwUJDQ5fkgULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAK
CRAVabv5CsORiukbAP9z4QdU/+9nwmIURy3YNj2hkORiJvaoZFlsW4zlCBHoQgEA
g9BviNo4rlP7bJkQx1d7Ua7L5UIWOUMziHsfoJB8MgTClgQTFggAPhYhBOqpEBj9
dq+XmH8UxxVpu/kKw5GKBQJbTwQ5AhsjBQkHlKu/BQsJCAcCBhUKCQgLAgQWAgMB
Ah4BAheAAAoJEBVpu/kKw5GKJkkA+gO30jVHChUKLymR/OqFo2Ici9zHYoFTNylQ
151RqVU+AQCbnzDzK2FFbv/58e8/iNMEj5lb4IRTjfkZqc5x+BYbCc0uQmVuamFt
aW4gQmVpY2hsZXIgPGhhZHJpYW4yMDAyQGdvb2dsZW1haWwuY29tPsKWBBMWCAA+
FiEE6qkQGP12r5eYfxTHFWm7+QrDkYoFAmIvW3MCGyMFCQ0OX5IFCwkIBwIGFQoJ
CAsCBBYCAwECHgECF4AACgkQFWm7+QrDkYrMTwD7BUBMMkjKmI7VNLzloGLXBxG+
cFOgeqVd2f6vFAGMMlkBAOms7Wg+VgPDBtemJEFVHlTAaKanPpYFRbUEJVCMud4J
wpYEExYIAD4WIQTqqRAY/Xavl5h/FMcVabv5CsORigUCW08EJwIbIwUJB5SrvwUL
CQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRAVabv5CsORipBkAQCVnovpi3Xczuc6
kKr1iuC4ZK4jrvvxIeRINUXacZgQRwD/fS+EhjHwX9kUGKkK3Vy7KUroVP3jG2iF
yHBC1U4btAvNNEJlbmphbWluIEJlaWNobGVyIDxCZW5qYW1pbi5CZWljaGxlckB1
bmktcm9zdG9jay5kZT7ClgQTFggAPhYhBOqpEBj9dq+XmH8UxxVpu/kKw5GKBQJi
L1tzAhsjBQkNDl+SBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEBVpu/kKw5GK
/fIA/AsNIaUC4L3WUn7HqKRU4ccUwMRlS2yr7Ql08OWoNFI0AQD7td2pcr1LYqDP
r0jj+0thDJ2T5XLyeDnun9iyleplA8KWBBMWCAA+FiEE6qkQGP12r5eYfxTHFWm7
+QrDkYoFAltPBBQCGyMFCQeUq78FCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQ
FWm7+QrDkYqqfwD+LRMnHoZFyo8wv7UUhMMScKn5nX5TsCCX5xSKYq3tmk0BAMjh
UH2oOnGUpbMVu4n4vA/Yjmy21EFrMy7OljFyt+MDzSVCZW5qYW1pbiBCZWljaGxl
ciA8Qi5CZWljaGxlckBnbXguZGU+wpYEExYIAD4WIQTqqRAY/Xavl5h/FMcVabv5
CsORigUCYi9bcwIbIwUJDQ5fkgULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRAV
abv5CsORip98AP9NSVOYuS03CKmNtupeLwMA0+bF/23hblveVXoXeEJVxAD/QqrJ
g/tYbYljsjJUl1ogiI+dM2AtqhC9hYOs0JBe0w/ClgQTFggAPhYhBOqpEBj9dq+X
mH8UxxVpu/kKw5GKBQJbTwPhAhsjBQkHlKu/BQsJCAcCBhUKCQgLAgQWAgMBAh4B
AheAAAoJEBVpu/kKw5GKS6cBAME+9khHdl57jbA2lImVBz0xt5adekH4wkZ29AWc
k/pxAP421qyi38GgV6io78zuuOvNylMWH8B/b9dwm7HZo/PSA844BFtPA+ESCisG
AQQBl1UBBQEBB0BcpmVLLpJQJPcC7Y8iIFOpshER+LqiAQiJSS6kZc7YUAMBCAfC
iAQYFggAJhYhBOqpEBj9dq+XmH8UxxVpu/kKw5GKBQJiL1t0AhsMBQkNDl+SABQJ
EBVpu/kKw5GKCRAVabv5CsORisHWAQDM4ToSmmwlB1bTM+OT42FqgM6R5mpUoEOI
4wdfPvw2SAD/XJPzeWWgIsINDtlwmFu6Z0g7RszoHSIslLQb7dfMlQfCfgQYFggA
JhYhBOqpEBj9dq+XmH8UxxVpu/kKw5GKBQJbTwPhAhsMBQkHlKu/AAoJEBVpu/kK
w5GK3/4A/1aEt8nV1aTTshyBPX758ZvWgBLd4HWFHLgoj8/+peqKAQCndMsWEsVL
w90kV+kNkZChSA671e8Gf1FZXIf3S87+AA=3D=3D
=3DtoPw
-----END PGP PUBLIC KEY BLOCK-----

--------------nuYJKvGL62mOU4l3WAwIm0lh--

--------------ryLZHYTZU35s1m9U0qBfD7Y5--

--------------4W8rqTyWsQYNvGFGmCkJclOT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTqqRAY/Xavl5h/FMcVabv5CsORigUCZTJYvQUDAAAAAAAKCRAVabv5CsORihv+
AQD9uCVbCBiWrFHWX6l7fWb7lX/HnhOtpii6VzGyUJH2RQEAv0FAdqWD09+W6Nsgmfax0xwDtvAb
W5+y30xeJdgXhw8=
=UA65
-----END PGP SIGNATURE-----

--------------4W8rqTyWsQYNvGFGmCkJclOT--



--===============5814192092934383499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============5814192092934383499==--


