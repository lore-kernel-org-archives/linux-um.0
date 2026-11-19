Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE58B606A320
	for <linux-um@archiver.kernel.org>; Thu, 19 Nov 2026 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Pw5UzZWo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=FjTiJ6W9qTo0WD5nPRI+7Hy3oCBcnzZkK8S1Z5hYMzg=; b=Pw5UzZWoSKDBc9w+LbbFBBaz0Z
	9HcTvMVcKOD/F1Xqlg3sUsdk/M9rxToA62/NFiVkgor6VojigQlvDBF+UYP0KshbwUlj2JyjOxIRj
	J1bJs7bVjLNC5MeMsZyj0PIz38FvkKZp/MoVLuo3BTjnU6R32FsZtUk3sIl5KN68mA+gm6v34bxjV
	CiFTWhtW1Oskg7RNyCDUpqo56VKX3vfNCzyYgVrpjc/JKZrRIp2hAbJa9LCtoPaG7ewSsGiVQp2if
	K30U/vVCwCcU+7Ei1U4OStBzVGYZI9dT/4CbgyDhCsQ27cr+tqShn4fBanBiTTaIcCbJPEBWIRm17
	BD4Ku+gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU0tR-0000000BmVT-2OLz;
	Thu, 19 Nov 2026 12:05:33 +0000
Received: from outboundhk.mxmail.xiaomi.com ([118.143.206.90])
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU0tP-0000000BmTo-1YzQ
	for linux-um@lists.infradead.org;
	Thu, 19 Nov 2026 12:05:32 +0000
X-CSE-ConnectionGUID: ucBGbq3PQE6B+21C7yyB6w==
X-CSE-MsgGUID: +V11zXHUScWQHUozlR1reQ==
X-IronPort-AV: E=Sophos;i="6.27,220,1786982400"; 
   d="scan'208";a="169763903"
From: =?utf-8?B?5a2f5Luk5r6z?= <menglingao@xiaomi.com>
To: "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
CC: "richard@nod.at" <richard@nod.at>, "anton.ivanov@cambridgegreys.com"
	<anton.ivanov@cambridgegreys.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>
Subject: [RFC] um: reproducible randomness for time-travel tests
Thread-Topic: [RFC] um: reproducible randomness for time-travel tests
Thread-Index: AQHdeB48ZMeYmFKZ00uqEq8J0Z40yw==
Date: Thu, 19 Nov 2026 12:05:15 +0000
Message-ID: <D2219FFB-73EF-4E27-B84A-5C8E550E3553@xiaomi.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7B95D1140BA034A9AF7A73073FEA81F@xiaomi.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_040531_568313_4105C8A7 
X-CRM114-Status: UNSURE (   3.24  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQpIaSBVTUwgbWFpbnRhaW5lcnMsDQoNCldlIHVzZSBVTUwncyB0aW1lLXRyYXZlbCBtb2RlIGZv
ciBCbHVldG9vdGgoQmx1ZVopIGludGVncmF0aW9uIHRlc3RzLiBUbyBtYWtlDQpydW5zIHJlcHJv
ZHVjaWJsZSwgd2UgY3VycmVudGx5IHVzZSBhbiBMRF9QUkVMT0FEIHNoaW0gdG8gY29udHJvbCB0
aGUNCnJhbmRvbSBkYXRhIHRoYXQgdGhlIFVNTCBrZXJuZWwgb2J0YWlucyBmcm9tIHRoZSBob3N0
Lg0KDQpXb3VsZCBVTUwgYWNjZXB0IGFuIG9wdC1pbiB3YXkgdG8gc3VwcGx5IHJlcHJvZHVjaWJs
ZSByYW5kb20gaW5wdXQgZm9yDQp0aW1lLXRyYXZlbCB0ZXN0cz8gTm9ybWFsIGJvb3RzIHdvdWxk
IGNvbnRpbnVlIHRvIHVzZSBob3N0IHJhbmRvbW5lc3MuDQpJJ2QgYXBwcmVjaWF0ZSBmZWVkYmFj
ayBvbiB0aGUgc2NvcGUgYW5kIGludGVyZmFjZSBiZWZvcmUgcHJlcGFyaW5nIGENCnBhdGNoLg0K
DQpUaGFua3MsDQpMaW5nYW8gTWVuZw0KIy8qKioqKirmnKzpgq7ku7blj4rlhbbpmYTku7blkKvm
nInlsI/nsbPlhazlj7jnmoTkv53lr4bkv6Hmga/vvIzku4XpmZDkuo7lj5HpgIHnu5nkuIrpnaLl
nLDlnYDkuK3liJflh7rnmoTkuKrkurrmiJbnvqTnu4TjgILnpoHmraLku7vkvZXlhbbku5bkurrk
u6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDkuo7lhajpg6jmiJbpg6jliIbl
nLDms4TpnLLjgIHlpI3liLbjgIHmiJbmlaPlj5HvvInmnKzpgq7ku7bkuK3nmoTkv6Hmga/jgILl
poLmnpzmgqjplJnmlLbkuobmnKzpgq7ku7bvvIzor7fmgqjnq4vljbPnlLXor53miJbpgq7ku7bp
gJrnn6Xlj5Hku7bkurrlubbliKDpmaTmnKzpgq7ku7bvvIEgVGhpcyBlLW1haWwgYW5kIGl0cyBh
dHRhY2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIFhJQU9NSSwg
d2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hvc2UgYWRk
cmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5l
ZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFs
IG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0aW9uKSBi
eSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBpcyBwcm9oaWJp
dGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0
aGUgc2VuZGVyIGJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgaXQhKioq
KioqLyMNCg==

