Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364DBCDB47E
	for <linux-um@archiver.kernel.org>; Fri, 20 Oct 2023 09:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:To:From:References:Subject:MIME-Version:Date:Message-ID:Reply-To:
	Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6O+v3T/+Kkkg36U3L0DHbT+daZLahNkTrnrmcSqn7sE=; b=zfaZygNP318SQ5dbwaE+b/SDIO
	LlpOqQN/O/91dy2h91Zfb/kZ5OjljnKYYPFt0Wjm7uizH+y07gei2i8nEECLxMsegEOS5iFoVGvyJ
	jxKQoQYtswUMZIn03Bejj/n/2NxfUsArowVtdfMBgJK98bQ1edtcQUr1frTFeUCitzXQgWuKg6Yxw
	YZ3NNqToSWO4/cGYkc877iz2gq08D0rbxp7av2NRrnG1J8fmk8kpCIYKO1h0Bzjt/NgW+8ayX31gy
	wGggYQVkwLR6ZT4hJN3UCUlRbANtLGRLC6hqbycWExja4agAIVpLr6Yx3IiWY1qq9jo6LPAttaBGJ
	Qsxy6vtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtlbP-001efM-1E;
	Fri, 20 Oct 2023 09:15:31 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtlbL-001eeU-15
	for linux-um@lists.infradead.org;
	Fri, 20 Oct 2023 09:15:30 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 20 Oct 2023 09:15:17 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1697793317; bh=M0v6FYrk4FUb2d/1d82BrH6MsaU+yzF6lEmNb+m7GkM=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 kh2pNX0AT/aUj1fJ1c2d0FcFJmeVEUWY+X6Zdi+LaEFHvo/QT919ZEY8Lvo6nq6NVwVApGllzchR5HVpSHgkDw==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1697793317; bh=M0v6FYrk4FUb2d/1d82BrH6MsaU+yzF6lEmNb+m7GkM=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 GAHqhYuKZ9+Fd3mfyEb51eKXMbwFhhsn9X/zXqkjHbZaCIy3Oh935Gm1I3w20VkDvjvH0nK2227cRN1BAg2dhcCqa0l+aEoQZVjkPJBza2SVo0NIrsQ2ZVAj5+j06wLG47zcPj+UXyQmodQUHiQsSGry/qrnbz34p3NWupg6HIY=
Received: from [139.30.201.32] (139.30.201.32) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 20 Oct
 2023 11:15:16 +0200
Message-ID: <6082036a-c7f9-4bd5-8234-14957ed9953d@uni-rostock.de>
Date: Fri, 20 Oct 2023 11:15:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] um: irqs: process outstanding IRQs when unblocking
 signals
Content-Language: de-DE
References: <20231018123643.1255813-1-benjamin@sipsolutions.net>
From: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=C3=A4t_Rostock?=
To: <linux-um@lists.infradead.org>
In-Reply-To: <20231018123643.1255813-1-benjamin@sipsolutions.net>
X-Originating-IP: [139.30.201.32]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 5336704F66AE4A520A8E72AA98B91A96E59BD43D58D4AACD00A33EF703EFE04F2000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_021528_307583_19AD0773 
X-CRM114-Status: GOOD (  20.35  )
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
Content-Type: multipart/mixed; boundary="===============8845295105900341306=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

--===============8845295105900341306==
Content-Language: de-DE
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------CJ4nyJztFnobHEnYeOqQM0Og"

--------------CJ4nyJztFnobHEnYeOqQM0Og
Content-Type: multipart/mixed; boundary="------------nA8qlqoy3KHDLF7ekbSSO0z4";
 protected-headers="v1"
From: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
To: linux-um@lists.infradead.org
Message-ID: <6082036a-c7f9-4bd5-8234-14957ed9953d@uni-rostock.de>
Subject: Re: [PATCH 1/4] um: irqs: process outstanding IRQs when unblocking
 signals
References: <20231018123643.1255813-1-benjamin@sipsolutions.net>
In-Reply-To: <20231018123643.1255813-1-benjamin@sipsolutions.net>

--------------nA8qlqoy3KHDLF7ekbSSO0z4
Content-Type: multipart/mixed; boundary="------------Q1ddVga4OpIcRobjEXyBxWSi"

--------------Q1ddVga4OpIcRobjEXyBxWSi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

QW0gMTguMTAuMjAyMyB1bSAxNDozNiBzY2hyaWViIGJlbmphbWluQHNpcHNvbHV0aW9ucy5u
ZXQ6DQo+IEZyb206IEJlbmphbWluIEJlcmcgPGJlbmphbWluLmJlcmdAaW50ZWwuY29tPg0K
PiANCj4gV2hlbiBpbiB0aW1lLXRyYXZlbCBtb2RlLCB0aGUgZXZlbnRmZCBldmVudHMgYXJl
IHJlYWQgZXZlbiB3aGVuIHNpZ25hbHMNCj4gYXJlIGJsb2NrZWQgYXMgU0lHSU8gc3RpbGwg
bmVlZHMgdG8gYmUgcHJvY2Vzc2VkLiBJbiB0aGlzIGNhc2UsIHRoZQ0KPiBldmVudCBpcyBj
bGVhcmVkIG9uIHRoZSBldmVudGZkIGJ1dCB0aGUgSVJRIHN0aWxsIG5lZWRzIHRvIGJlIGZp
cmVkDQo+IGxhdGVyLg0KPiANCj4gV2UgZGlkIGFscmVhZHkgZW5zdXJlIHRoYXQgdGhlIFNJ
R0lPIGhhbmRsZXIgaXMgcnVuIGFnYWluLiBIb3dldmVyLCB0aGUNCj4gRkRzIGFyZSBjb25m
aWd1cmVkIHRvIGJlIGxldmVsIHRyaWdnZXJlZCwgc28gdGhhdCBldmVudGZkIHdpbGwgbm90
DQo+IG5vdGlmeSBhZ2Fpbi4gQXMgc3VjaCwgYWRkIHNvbWUgbG9naWMgdG8gbWFyayB0aGUg
SVJRIGFzIHBlbmRpbmcgYW5kDQo+IHByb2Nlc3MgaXQgYXQgdGhlIG5leHQgb3Bwb3J0dW5p
dHkuDQo+IA0KPiBUbyBhdm9pZCBkdXBsaWNhdGlvbiwgcmV1c2UgdGhlIGxvZ2ljIHVzZWQg
Zm9yIHRoZSBzdXNwZW5kL3Jlc3VtZSBjYXNlLg0KPiBUaGlzIGRvZXMgbm90IHJlYWxseSBj
aGFuZ2UgYW55dGhpbmcgZXhjZXB0IGZvciBkZWxheWluZyBydW5uaW5nIHRoZQ0KPiBJUlFz
IHdpdGggdGltZXRyYXZlbF9oYW5kbGVyIGF0IGEgc2xpZ2h0bHkgbGF0ZXIgcG9pbnQgaW4g
dGltZSAoYW5kDQo+IHBvc3NpYmx5IHJ1bm5pbmcgbm9uLXRpbWV0cmF2ZWwgSVJRcyB0aGF0
IHNob3VsZG4ndCBoYXBwZW4gZWFybGllcikuDQo+IFdoaWxlIGF0IGl0LCBtb3ZlIG1hcmtp
bmcgYXMgcGVuZGluZyBpbnRvIGlycV9ldmVudF9oYW5kbGVyIGFzIHRoYXQgaXMNCj4gdGhl
IG1vcmUgbG9naWNhbCBwbGFjZSBmb3IgaXQgdG8gaGFwcGVuLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQmVuamFtaW4gQmVyZyA8YmVuamFtaW4uYmVyZ0BpbnRlbC5jb20+DQoNCkkgYWxz
byBub3RpY2VkIHRoaXMgcHJvYmxlbSwgYnV0IGFmdGVyIGEgZGlzY3Vzc2lvbiB3aXRoIEpv
aGFubmVzIEJlcmcgDQphYm91dCB0aGlzLCB3ZSBjb21lIHRvIHRoZSBjb25jbHVzaW9uLCB0
aGF0IGFsbCBkcml2ZXJzIHdpdGggaW50ZXJydXB0cyANCm5lZWQgdG8gZGVhbCB3aXRoIHRp
bWUgdHJhdmVsIG1vZGUgdmlhIHRoZWlyIG93biB0aW1lIHRyYXZlbCBoYW5kbGVyLiANCldo
YXQgSSBhY3R1YWxseSBkaWQsIHdhcyB0byB3cml0ZSBhIHRyaXZpYWwgaGFuZGxlciBmb3Ig
ZS5nLiwgdGhlIHNlcmlhbCANCmxpbmUsIHdoaWNoIHNpbXBseSBvbmx5IGNhbGwgdGltZV90
cmF2ZWxfYWRkX2lycV9ldmVudChldikuDQoNCkknbSBub3QgZW50aXJlbHkgc3VyZSwgd2hh
dCB0aGUgcmlnaHQgd2F5IHRvIGRvIGl0LCBhbHRob3VnaCB0aGUgb3V0Y29tZSANCnNlZW1z
IHRvIGJlIHRoZSBzYW1lLCBhcyB3aXRoIG5vIHRpbWUgYWR2YW5jZSB0aGUgYWN0dWFsIHNp
bXVsYXRpb24gDQp0aW1lLCB3aGVuIHRoZSBpbnRlcnJ1cHQgaXMgaGFuZGxlZCBpcyB0aGUg
c2FtZS4NCg0KSSBhY3R1YWxseSBhbHNvIGhhdmUgc29tZSBvdGhlciBzaWduaWZpY2FudCBi
dWcgZml4ZXMgb24gdGltZSB0cmF2ZWwgaW4gDQpteSB0cmVlLCBidXQgSSB3YXMgdG9vIGxh
enkgdG8gc2VuZCB0aGVtIGhlcmUsIGFyZSB5b3UgaW50ZXJlc3RlZCBpbiANCnRha2luZyBh
IGxvb2sgYXQgdGhlbT8NCg==
--------------Q1ddVga4OpIcRobjEXyBxWSi
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

--------------Q1ddVga4OpIcRobjEXyBxWSi--

--------------nA8qlqoy3KHDLF7ekbSSO0z4--

--------------CJ4nyJztFnobHEnYeOqQM0Og
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTqqRAY/Xavl5h/FMcVabv5CsORigUCZTJFIwUDAAAAAAAKCRAVabv5CsORihHM
AQDQ31KTDvVDMLJ8lOBOMVvqhOUUNHWxDnY79PY9SH8mqwD/f3oj5ORKMOI5hhpy8X/vup6c2Mfq
yiP2qmL3KuZe1gc=
=q4Iq
-----END PGP SIGNATURE-----

--------------CJ4nyJztFnobHEnYeOqQM0Og--



--===============8845295105900341306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============8845295105900341306==--


