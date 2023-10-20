Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284CDCDB474
	for <linux-um@archiver.kernel.org>; Fri, 20 Oct 2023 12:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:
	Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1j5MKo/OaYdGgxUznYan7KrekV3O9xBUATXFJSGaelI=; b=qZap1EtfuwlAHWdbmkunY/ZDZ4
	vWjzuE5w77S3SMT6QnJqlIusZDcJqQm4RKeIYcbyc2cEEn/v6Um1myZFW7gSJKEw4QJJNfeT8xn+b
	dPockMljC3pkg58+Jj2R6vAZLdA/qoE3om6KZSE8fqUgtlfs/7uQrrqwqHQBKb8WxvKQOIvoABXyC
	mV1nUhk3WdHtGOhHZlFy6b9dvmgDVOwnwOXZffxQvEjZ6WcWIegxv3cGN31i9wfuzC0gdnlv1h9uF
	MyigBaZK7h7kVfqkieMw++SLsTv3a5EJaiAPxPRE0wv1c1VtmcaGHedxSk0EY2ANMRR0Hq4rHf/Mb
	3rmo5cTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtoGm-002DAM-2x;
	Fri, 20 Oct 2023 12:06:24 +0000
Received: from mx2.uni-rostock.de ([139.30.22.72])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtoGi-002D9b-24
	for linux-um@lists.infradead.org;
	Fri, 20 Oct 2023 12:06:23 +0000
Received: from 139.30.22.84 by mx2.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 20 Oct 2023 12:06:12 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1697803572; bh=z+zKcuFnjawO6Ce3uWBb9R1XWpBbhF/fxA1kbaWRZQw=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 qyGA6g5+7lKyx3Qxy7Ixl8PWneKJVWN5O+ar15g4RwD71Q/prtnv/ShIIJhBlTnuX0O+hgpqktEW+q/EzJGsCg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1697803572; bh=z+zKcuFnjawO6Ce3uWBb9R1XWpBbhF/fxA1kbaWRZQw=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 n3n3NKdX9BDVzBrZqSXVV+TInhC9yRrvgCTkudaKk7kay7O7OhH8y5OqZew77/Pk+GIe7haLy/ilEGSaRy7JZeMbIeFoo8Np7eolG5biu2H4sCQjQWwZwve5uq30MDNv13TNfVSSvJaoIVZqABU9ByVQMskraNB2CegaLbKD9ok=
Received: from [139.30.201.32] (139.30.201.32) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 20 Oct
 2023 14:06:09 +0200
Message-ID: <d77b66af-249d-4dd1-b78f-730d252bcf84@uni-rostock.de>
Date: Fri, 20 Oct 2023 14:06:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] um: irqs: process outstanding IRQs when unblocking
 signals
Content-Language: de-DE
To: Johannes Berg <johannes@sipsolutions.net>, <linux-um@lists.infradead.org>
References: <20231018123643.1255813-1-benjamin@sipsolutions.net>
 <6082036a-c7f9-4bd5-8234-14957ed9953d@uni-rostock.de>
 <11ab4d47dd8fdcdc2148e00618cc496866016883.camel@sipsolutions.net>
 <549de9c0-05f8-437e-8460-5b013b0cd87b@uni-rostock.de>
 <348de3de5cbd6df96ac51bb07d6e485b2ecc5cc8.camel@sipsolutions.net>
From: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=C3=A4t_Rostock?=
In-Reply-To: <348de3de5cbd6df96ac51bb07d6e485b2ecc5cc8.camel@sipsolutions.net>
X-Originating-IP: [139.30.201.32]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: F55ACF615B432760CC0BBAC819299204B2B38DCBD83B587A1E4E162F84C315002000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_050621_623290_9792F8DD 
X-CRM114-Status: GOOD (  21.36  )
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
Content-Type: multipart/mixed; boundary="===============0393549698506424329=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

--===============0393549698506424329==
Content-Language: de-DE
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------0TBmIeuYnR3uI1BY4WxpJ0Nz"

--------------0TBmIeuYnR3uI1BY4WxpJ0Nz
Content-Type: multipart/mixed; boundary="------------p0EqcM4FjKZz5WxGPSUOLSly";
 protected-headers="v1"
From: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Message-ID: <d77b66af-249d-4dd1-b78f-730d252bcf84@uni-rostock.de>
Subject: Re: [PATCH 1/4] um: irqs: process outstanding IRQs when unblocking
 signals
References: <20231018123643.1255813-1-benjamin@sipsolutions.net>
 <6082036a-c7f9-4bd5-8234-14957ed9953d@uni-rostock.de>
 <11ab4d47dd8fdcdc2148e00618cc496866016883.camel@sipsolutions.net>
 <549de9c0-05f8-437e-8460-5b013b0cd87b@uni-rostock.de>
 <348de3de5cbd6df96ac51bb07d6e485b2ecc5cc8.camel@sipsolutions.net>
In-Reply-To: <348de3de5cbd6df96ac51bb07d6e485b2ecc5cc8.camel@sipsolutions.net>

--------------p0EqcM4FjKZz5WxGPSUOLSly
Content-Type: multipart/mixed; boundary="------------6xJH1vHnYXDQMXzKQhBaGzTu"

--------------6xJH1vHnYXDQMXzKQhBaGzTu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

QW0gMjAuMTAuMjAyMyB1bSAxMzozOSBzY2hyaWViIEpvaGFubmVzIEJlcmc6DQo+IE9uIEZy
aSwgMjAyMy0xMC0yMCBhdCAxMjozOCArMDIwMCwgQmVuamFtaW4gQmVpY2hsZXIgd3JvdGU6
DQo+Pg0KPj4gQ2FuIHlvdSBleHBsYWluLCB3aHkgYSB0aW1lIHRyYXZlbCBoYW5kbGVyIGZv
ciBzdGRpbiBtYXkgYmUgYmFkPyBJdA0KPj4gc291bmRzIGxpa2UgeW91IHdhbnQgdG8gYXZv
aWQgaXQsIGJ1dCBJIHNlZSBubyBpbW1lZGlhdGUgcHJvYmxlbS4NCj4+DQo+IA0KPiBJIG5l
ZWQgdG8gcmVhZCB0aGUgdGhyZWFkLCBidXQgdGhpcyBvbmUncyBlYXN5IDstKQ0KPiANCj4g
VGhlIHRoaW5nIGlzIHRoYXQgb24gc3VjaCBhIGNoYW5uZWwgeW91IGRvbid0IHNlbmQgYW4g
QUNLIHdoZW4geW91J3ZlDQo+IHNlZW4gdGhhdCB0aGVyZSdzIHNvbWV0aGluZyB0byBoYW5k
bGUuIEFzIGEgcmVzdWx0LCB0aGUgc2VuZGVyIHdpbGwNCj4gY29udGludWUgcnVubmluZyB3
aGlsZSB5b3UncmUgdHJ5aW5nIHRvIHJlcXVlc3QgYSBuZXcgc2NoZWR1bGUgZW50cnkNCj4g
ZnJvbSB0aGUgY29udHJvbGxlci4gQXMgYSByZXN1bHQsIGl0IG1heSBydW4gcGFzdCB5b3Vy
IG5ldyBzY2hlZHVsZQ0KPiBlbnRyeSBiZWNhdXNlIGl0IGRpZG4ndCBrbm93IGFib3V0IGl0
IHlldCAodGhpcyB3b3VsZCBsaWtlbHkgYnJpbmcgZG93bg0KPiB0aGUgY29udHJvbGxlciBh
bmQgY3Jhc2ggdGhlIHNpbXVsYXRpb24pLCBvciB0aGUgcmVsYXRpdmUgb3JkZXIgb2YgdGhl
DQo+IHR3byBlbnRyaWVzIGlzIHVuZGVmaW5lZCwgaW4gdGhlIHNlbnNlIHRoYXQgaXQgZGVw
ZW5kcyBvbiB0aGUgcHJvY2Vzcw0KPiBzY2hlZHVsaW5nIG9mIHRoZSBob3N0Lg0KU29ycnks
IGJ1dCBJIGRpZCBub3QgZ2V0IHRoaXMuIFdoYXQgbWF5IHJ1biBwYXN0IHRoZSBzY2hlZHVs
ZSBlbnRyeT8gSXMgDQp5b3VyIGFzc3VtcHRpb24sIHRoYXQgdGhlICJ0aGluZyIgY29ubmVj
dGVkIHRvIHN0ZGluIGlzIGFsd2F5cyB0b3RhbGx5IA0KdW5hd2FyZSBvZiB0aGUgdGltZSB0
cmF2ZWwgbW9kZT8NCg0KV2hlbiBvdXIgKHRvIGJlIHB1Ymxpc2hlZCkgc2ltdWxhdGlvbiBz
ZW5kIHNvbWV0aGluZyBvbiBzZXJpYWwgbGluZXMgKEkgDQp0aGluayBpdCBkb2VzIG5vdCBt
YXR0ZXIgd2hldGhlciBpdCBpcyBhIHNvY2tldCBvciBhIHBpcGUpLCB3ZSBleHBlY3QgDQp0
aGF0IHRoZSB1bWwgaW5zdGFuY2UgbmVlZHMgdG8gYmUgcnVuIGFzIGxvbmcgYXMgaXQgY2hh
bmdlcyBiYWNrIHRvIA0KaWRsZS93YWl0IHN0YXRlIGJlZm9yZSB0aGUgc2ltdWxhdGlvbiB0
aW1lIGlzIGFkdmFuY2VkLiBTaW5jZSB0aGUgYmFzaXMgDQptb2RlbCBvZiB0aGUgdGltZSB0
cmF2ZWwgbW9kZSBpcywgdGhhdCB5b3UgaGF2ZSBpbmZpbml0ZSBhbW91bnQgb2YgDQpwcm9j
ZXNzaW5nIHBvd2VyLCB0aGUgaW50ZXJydXB0IG5lZWRzIHRvIGJlIGFsd2F5cyBoYW5kbGVk
IGF0IHRoZSANCmN1cnJlbnQgdGltZS4NCg0KTWF5YmUgbXkgdGhpbmstbW9kZWwgb25seSBo
b2xkcyBmb3IgInNtYWxsZXIiIGFtb3VudHMgb2YgZGF0YSAobWF5YmUgb25lIA0KcGFnZSBv
ciBzb21ldGhpbmc/KSBvciBub3QgdGhlIGZyZWUtcnVubmluZyBtb2RlLCBidXQgSSdtIG5v
dCBjb21wbGV0ZWx5IA0KY29udmluY2VkLiA6LUQNCg0KTWF5YmUgd2UgbmVlZCB0byBkZWZp
bmUsIGEgYml0IG1vcmUgZm9ybWFsbHksIGhvdyB0aGUgKGRlc2lnbmVkKSANCnByb2Nlc3Np
bmcgbW9kZWwgb2YgaW50ZXJydXB0cyBpbiB0aW1lIHRyYXZlbCBtb2RlIGlzLg0KDQo+IA0K
PiBqb2hhbm5lcw0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCj4gbGludXgtdW0gbWFpbGluZyBsaXN0DQo+IGxpbnV4LXVtQGxpc3Rz
LmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC11bQ0KDQo=
--------------6xJH1vHnYXDQMXzKQhBaGzTu
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

--------------6xJH1vHnYXDQMXzKQhBaGzTu--

--------------p0EqcM4FjKZz5WxGPSUOLSly--

--------------0TBmIeuYnR3uI1BY4WxpJ0Nz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTqqRAY/Xavl5h/FMcVabv5CsORigUCZTJtMAUDAAAAAAAKCRAVabv5CsORimXH
AP9+Ua/nva4LHtl6kRwd5wL0Cr49hf1h3RH9wlZvBP+uPgEA67qa+r8tiE5/aX/CT2Dec6Ubqy6a
NLHf9Qra7thidw8=
=RIKU
-----END PGP SIGNATURE-----

--------------0TBmIeuYnR3uI1BY4WxpJ0Nz--



--===============0393549698506424329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============0393549698506424329==--


