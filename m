Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F39C3064D
	for <linux-um@archiver.kernel.org>; Tue,  2 Jul 2024 14:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	From:References:CC:To:Subject:MIME-Version:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OlQdh3xJCOkTAbWxSnyfnavkb8E5xI3i5MxJvn6nk4E=; b=GbESMMxQoJ9d1QnUkCvfis/zcp
	nBI1k+2W3Dc8DQyLXUKnoopvyAQ2TVulJJ69lib/y5mWKTxiNZxM7XpWoEnlsoLOIQrXGu2MO0iPL
	zDUaoh/p1LmdHJ0EzTVcoGisvl5XT2WZvX5ITDacIcyG+1iZfFfNX/ScI4cayWiUaEtwTDfoPuUgc
	rs4rJ/IL2dIw8E6bkpVgTeFJ9z6S6f0eAHBB/qE3oYmSRkzbpVtmFi269b9uOUlPtppk3q/bx+X/r
	zOOX5MWrzTfZjWKXhERVVOTrEzbgqRGqq2RSed4FKgj/IGqbW1xzqdr6ELOS3LX2AZ/P4HqgKYOLn
	KQKVxVPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOea0-0000000730E-3uSQ;
	Tue, 02 Jul 2024 14:34:00 +0000
Received: from mx2.uni-rostock.de ([139.30.22.72])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOeZv-000000072z7-28xM
	for linux-um@lists.infradead.org;
	Tue, 02 Jul 2024 14:33:58 +0000
Received: from 139.30.22.84 by mx2.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Tue, 02 Jul 2024 14:33:47 GMT
Received: from [139.30.201.72] (139.30.201.72) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 2 Jul
 2024 16:33:46 +0200
Message-ID: <1a67bbbe-bf50-4ea0-a4cf-6d6ffa48caa4@uni-rostock.de>
Date: Tue, 2 Jul 2024 16:33:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] um: add shared memory optimisation for
 time-travel=ext
Content-Language: de-DE
To: Johannes Berg <johannes@sipsolutions.net>, <linux-um@lists.infradead.org>
CC: Johannes Berg <johannes.berg@intel.com>, Mordechay Goodstein
	<mordechay.goodstein@intel.com>
References: <20240701233155.4e9de8a682eb.I2ca8d006b67feeb866ac2017af7b741c9e06445a@changeid>
 <20240701233155.5611a2fb21be.Ie41206c8ce4507fe26b991937f47e86c24ca7a31@changeid>
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
In-Reply-To: <20240701233155.5611a2fb21be.Ie41206c8ce4507fe26b991937f47e86c24ca7a31@changeid>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------70veyK009B0vZ92bXX0QXPmi"
X-Originating-IP: [139.30.201.72]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 326BE42D7069CE1AE9B787F97D0895B8A3EA02594DC08E6A61881B478BF2F4D42000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_073355_905413_F2E4A52E 
X-CRM114-Status: GOOD (  10.59  )
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

--------------70veyK009B0vZ92bXX0QXPmi
Content-Type: multipart/mixed; boundary="------------CVIm6CAV7cH3zuhQ7VSo28lb";
 protected-headers="v1"
From: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>,
 Mordechay Goodstein <mordechay.goodstein@intel.com>
Message-ID: <1a67bbbe-bf50-4ea0-a4cf-6d6ffa48caa4@uni-rostock.de>
Subject: Re: [PATCH v3 4/4] um: add shared memory optimisation for
 time-travel=ext
References: <20240701233155.4e9de8a682eb.I2ca8d006b67feeb866ac2017af7b741c9e06445a@changeid>
 <20240701233155.5611a2fb21be.Ie41206c8ce4507fe26b991937f47e86c24ca7a31@changeid>
In-Reply-To: <20240701233155.5611a2fb21be.Ie41206c8ce4507fe26b991937f47e86c24ca7a31@changeid>

--------------CVIm6CAV7cH3zuhQ7VSo28lb
Content-Type: multipart/mixed; boundary="------------wMZioRGNkhLFqKFPZ4ew6RDr"

--------------wMZioRGNkhLFqKFPZ4ew6RDr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

TWF5YmUgYSBiaXQgcGVkYW50aWMsIGJ1dCB0aGlzIGRvdCBzaG91bGQgYmUgcGFydCBvZiB0
aGUgb3RoZXIgcGF0Y2ggOy0pDQoNCkFtIDAxLjA3LjIwMjQgdW0gMjM6MzEgc2NocmllYiBK
b2hhbm5lcyBCZXJnOg0KDQo+ICAgDQo+IEBAIC0xMjQsNyArMTQ1LDggQEAgZW51bSB1bV90
aW1ldHJhdmVsX29wcyB7DQo+ICAgCSAqLw0KPiAgIAlVTV9USU1FVFJBVkVMX0dFVF9UT0QJ
CT0gOCwNCj4gICANCj4gLQkvKiogQFVNX1RJTUVUUkFWRUxfQlJPQURDQVNUOiBTZW5kL1Jl
Y2VpdmUgYSBicm9hZGNhc3QgbWVzc2dlDQo+ICsJLyoqDQo+ICsJICogQFVNX1RJTUVUUkFW
RUxfQlJPQURDQVNUOiBTZW5kL1JlY2VpdmUgYSBicm9hZGNhc3QgbWVzc2FnZS4NCj4gICAJ
ICoJVGhpcyBtZXNzYWdlIGNhbiBiZSB1c2VkIHRvIHN5bmMgYWxsIGNvbXBvbmVudHMgaW4g
dGhlIHN5c3RlbQ0KPiAgIAkgKgl3aXRoIGEgc2luZ2xlIG1lc3NhZ2UsIGlmIHRoZSBjYWxl
bmRlciBnZXRzIHRoZSBtZXNzYWdlLCB0aGUNCj4gICAJICoJY2FsZW5kZXIgYnJvYWRjYXN0
IHRoZSBtZXNzYWdlIHRvIGFsbCBjb21wb25lbnRzLCBhbmQgaWYgYQ0KPiBAQCAtMTM1LDQg
KzE1NywxMzQgQEAgZW51bSB1bV90aW1ldHJhdmVsX29wcyB7DQo+ICAgCVVNX1RJTUVUUkFW
RUxfQlJPQURDQVNUCQk9IDksDQo+ICAgfTsNCj4gICANCg0KDQo=
--------------wMZioRGNkhLFqKFPZ4ew6RDr
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

--------------wMZioRGNkhLFqKFPZ4ew6RDr--

--------------CVIm6CAV7cH3zuhQ7VSo28lb--

--------------70veyK009B0vZ92bXX0QXPmi
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTqqRAY/Xavl5h/FMcVabv5CsORigUCZoQPywUDAAAAAAAKCRAVabv5CsORihG/
AQCCt2LKSyYTvwj1N+TNiNbwKSYH8uOyq0Yif02qON6eZgD8Cx68A5CUxheQks54BLn5ZkXUZuq/
rp+LAOJ1kmsMLwE=
=ELVc
-----END PGP SIGNATURE-----

--------------70veyK009B0vZ92bXX0QXPmi--


