Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049A8CF3943
	for <linux-um@archiver.kernel.org>; Thu, 19 Sep 2024 14:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	From:References:CC:To:Subject:MIME-Version:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R+0ZwmMGmW5MT+Z6aQrXGhuK7JsQurZPyCgeXyiKWgs=; b=14o9m3KRx0qosTdqZwKBhzE/jG
	DHhRL+kO9+et/ABY2DfsnZHCaA50Ye4mWDEWxLJyObuo3p9ZWgch43z+N0YkIy7mR96UL5RKUOkNM
	cevqOPi8y0WfllIQJlx9zH2CCV9XdlrKnGwFkbZW36WGoeRsrI5JdRUH21UsKTjSFF/5J1tiu6h4M
	i4wIfmjV1xmx2Z2jr9KGOwRspO7MOcQVL0ArvimUx43SySJxVI3e3LpeV1Kcrq1f+ZtAeciQbAw8x
	encI5gxLVLFcf18qAnG2xGKYp7hZIj+VPaaiglXkrEWm10qUVIkzHxZSR67DOkNk3vKfBXcpziCyk
	pR4GvENw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srHsr-0000000APsx-3PYM;
	Thu, 19 Sep 2024 14:11:49 +0000
Received: from mx2.uni-rostock.de ([139.30.22.72])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srHso-0000000APsL-1qSB
	for linux-um@lists.infradead.org;
	Thu, 19 Sep 2024 14:11:48 +0000
Received: from 139.30.22.84 by mx2.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Thu, 19 Sep 2024 14:11:39 GMT
Received: from [139.30.201.77] (139.30.201.77) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Sep
 2024 16:11:37 +0200
Message-ID: <3ea4c557-df8f-4312-84f6-8dc0b2c2a5f1@uni-rostock.de>
Date: Thu, 19 Sep 2024 16:11:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: insert scheduler ticks when userspace does not yield
Content-Language: de-DE
To: Benjamin Berg <benjamin@sipsolutions.net>, <linux-um@lists.infradead.org>
CC: Benjamin Berg <benjamin.berg@intel.com>
References: <20240913201756.1223327-1-benjamin@sipsolutions.net>
From: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Autocrypt: addr=Benjamin.Beichler@uni-rostock.de; keydata=
 xjMEW08D4RYJKwYBBAHaRw8BAQdARRw5LUE0LoG/3A8AuH6shJZQcVbm0p/m5fCc3FkaJ6vN
 NEJlbmphbWluIEJlaWNobGVyIDxCZW5qYW1pbi5CZWljaGxlckB1bmktcm9zdG9jay5kZT7C
 lgQTFggAPhYhBOqpEBj9dq+XmH8UxxVpu/kKw5GKBQJiL1tzAhsjBQkNDl+SBQsJCAcCBhUK
 CQgLAgQWAgMBAh4BAheAAAoJEBVpu/kKw5GK/fIA/AsNIaUC4L3WUn7HqKRU4ccUwMRlS2yr
 7Ql08OWoNFI0AQD7td2pcr1LYqDPr0jj+0thDJ2T5XLyeDnun9iyleplA844BFtPA+ESCisG
 AQQBl1UBBQEBB0BcpmVLLpJQJPcC7Y8iIFOpshER+LqiAQiJSS6kZc7YUAMBCAfCiAQYFggA
 JhYhBOqpEBj9dq+XmH8UxxVpu/kKw5GKBQJiL1t0AhsMBQkNDl+SABQJEBVpu/kKw5GKCRAV
 abv5CsORisHWAQDM4ToSmmwlB1bTM+OT42FqgM6R5mpUoEOI4wdfPvw2SAD/XJPzeWWgIsIN
 DtlwmFu6Z0g7RszoHSIslLQb7dfMlQc=
Organization: =?UTF-8?Q?Universit=C3=A4t_Rostock?=
In-Reply-To: <20240913201756.1223327-1-benjamin@sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------YMg8A1OhrPlBQf0z9HLLAGlW"
X-Originating-IP: [139.30.201.77]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: BE96A3EDC38E73804945BE924F5450603E7BA15BB2B59220B36EA99945E88FF42000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_071146_814288_7250F552 
X-CRM114-Status: GOOD (  13.51  )
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

--------------YMg8A1OhrPlBQf0z9HLLAGlW
Content-Type: multipart/mixed; boundary="------------QVPNDJDLQVjXGCiXZQlrlhZc";
 protected-headers="v1"
From: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Message-ID: <3ea4c557-df8f-4312-84f6-8dc0b2c2a5f1@uni-rostock.de>
Subject: Re: [PATCH] um: insert scheduler ticks when userspace does not yield
References: <20240913201756.1223327-1-benjamin@sipsolutions.net>
In-Reply-To: <20240913201756.1223327-1-benjamin@sipsolutions.net>

--------------QVPNDJDLQVjXGCiXZQlrlhZc
Content-Type: multipart/mixed; boundary="------------KNaEtGhiWbqNXS6vKuHrcfbP"

--------------KNaEtGhiWbqNXS6vKuHrcfbP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCkNvdWxkIHRoaXMgYWxzbyBlbGltaW5hdGUvYWRkcmVzcyB0aGUgYnVzeS1sb29w
IGhhY2sgaW4gdGltZXJfcmVhZCBpbiANCnRpbWUuYz8NCg0KQW5kIGFub3RoZXIgcXVlc3Rp
b246IFdoeSB5b3UgcmVtb3ZlIG9ubHkgMSBleHRyYSBqaWZmeSBpbiB0aGUgdGltZXIgDQpj
YWxsYmFja3MgYW5kIG5vdCBhbGwgdGhlIGV4dHJhIGppZmZpZXM/IElzIHRoZXJlIGFsd2F5
cyBvbmx5IDEgb3IgY291bGQgDQp0aGVyZSBiZSBtdWx0aXBsZT8NCg0KcmVnYXJkcw0KDQpC
ZW5qYW1pbiBCZWljaGxlcg0KDQpBbSAxMy4wOS4yMDI0IHVtIDIyOjE3IHNjaHJpZWIgQmVu
amFtaW4gQmVyZzoNCj4gRnJvbTogQmVuamFtaW4gQmVyZyA8YmVuamFtaW4uYmVyZ0BpbnRl
bC5jb20+DQo+IA0KPiBJbiB0aW1lLXRyYXZlbCBtb2RlIHVzZXJzcGFjZSBjYW4gZG8gYSBs
b3Qgb2Ygd29yayB3aXRob3V0IGFueSB0aW1lDQo+IHBhc3NpbmcuIFVuZm9ydHVuYXRlbHks
IHRoaXMgY2FuIHJlc3VsdCBpbiBPT00gc2l0dWF0aW9ucyBhcyB0aGUgUkNVDQo+IGNvcmUg
Y29kZSB3aWxsIG5ldmVyIGJlIHJ1bi4NCj4gDQo+IFdvcmsgYXJvdW5kIHRoaXMgYnkga2Vl
cGluZyB0cmFjayBvZiB1c2Vyc3BhY2UgcHJvY2Vzc2VzIHRoYXQgZG8gbm90DQo+IHlpZWxk
IGZvciBhIGxvdCBvZiBvcGVyYXRpb25zLiBXaGVuIHRoaXMgaGFwcGVucywgaW5zZXJ0IGEg
amlmZmllIGludG8NCj4gdGhlIHNjaGVkX2Nsb2NrIGNsb2NrIHRvIGFjY291bnQgdGltZSBh
Z2FpbnN0IHRoZSBwcm9jZXNzIGFuZCBjYXVzZSB0aGUNCj4gYm9va2tlZXBpbmcgdG8gcnVu
Lg0KPiANCj4gQXMgc2NoZWRfY2xvY2sgaXMgdXNlZCBmb3IgdHJhY2luZywgaXQgaXMgdXNl
ZnVsIHRvIGtlZXAgaXQgaW4gc3luYw0KPiBiZXR3ZWVuIHRoZSBkaWZmZXJlbnQgVk1zLiBB
cyBzdWNoLCB0cnkgdG8gcmVtb3ZlIGFkZGVkIHRpY2tzIGFnYWluIHdoZW4NCj4gdGhlIGFj
dHVhbCBjbG9jayB0aWNrcy4NCg0K
--------------KNaEtGhiWbqNXS6vKuHrcfbP
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

--------------KNaEtGhiWbqNXS6vKuHrcfbP--

--------------QVPNDJDLQVjXGCiXZQlrlhZc--

--------------YMg8A1OhrPlBQf0z9HLLAGlW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTqqRAY/Xavl5h/FMcVabv5CsORigUCZuwxGAUDAAAAAAAKCRAVabv5CsORiotc
AQDbwl41cmscXnL1TygwElvnPehW0occzbsSVu2gQnUtvQD/Txm/LN27Ns/c/kDXWA9m8xJvY1Uc
VVom8A9sRTfKnwU=
=ZSKk
-----END PGP SIGNATURE-----

--------------YMg8A1OhrPlBQf0z9HLLAGlW--


