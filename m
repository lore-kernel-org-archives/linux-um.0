Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC42EB64D9
	for <linux-um@archiver.kernel.org>; Thu,  6 Jul 2023 13:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:Subject:References:Cc:
	To:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iV084hpCJjwZvGVSL7R9QjUPIvKQgEs6t76YEMNw9Ng=; b=B+qSustjE52NVj
	WNNEEZH1/nduQfzifSm+K6lmhIji69oTj/OAqSEmvfT4kujfG3H+cmNLYBwRn7Q20OGJQbkpH9vXI
	XrU4zsavQMZYjwlmI8sljqQ9O1CIdv3+wd0LTqN+5X+jj9fB0o66nIN+ss2btPepyk/1ZqcokIqR8
	Wmt3YvsjO2TVAckHeLJXmxVVXgQXo3j6fSOKRob/v5JfPdoS5qW8cZB1Wx+TcfGUtgTH869Su4EJ/
	3TFl7IcPNS/VQZwaomJBGyUZrcT2fqRZliTtKMmpIMWASEk7R+mnyHYXF+JY8R+jQCTtIOakgRT7q
	z3VrV68XnFP6NTiih+dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHOr8-001kK3-0f;
	Thu, 06 Jul 2023 13:17:10 +0000
Received: from mout.web.de ([212.227.17.12])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHOr5-001kJ8-2s
	for linux-um@lists.infradead.org;
	Thu, 06 Jul 2023 13:17:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688649411; x=1689254211; i=markus.elfring@web.de;
 bh=fJlXmmzrOj95xU1VQlbv9j2MSr7jZ+WZV76JS7dAp9E=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=mBmBI9kMnPmztdWkReSjAjEq8uIsKlvRoFvR1xMXfyHoJ+/YfClYHh/bvk6BYH8QuJXAsRI
 ZzfwwUht+M9+HLKhIDhV18JV3uhmyD4mB7ny61daRYojw3NJkeuUIWOmjaU5Lg6hUP6h1nZmK
 4epvTlGJ5U4Xy7T8cvXBi+WdI7ZjNRQNTu0bugDEJdwftgfLYOAsnWM6WZzUj7d5HuJG4g0jp
 bC/M7pr4T98kTN2pxHq8p9VIxXkFe6Zet0Uj4TyiPaLfA3qiDymua2ruhuNwwufvtdlRs+gS1
 gS2uD6jEGMNruNKcBEBiIII//18Zqvg5X292EL/TtGQ6OUoh867w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MumJF-1pzSIC0hGt-00rjd2; Thu, 06
 Jul 2023 15:16:51 +0200
Message-ID: <b8e14b6c-da2d-ac6e-7cdb-077b2c2a6390@web.de>
Date: Thu, 6 Jul 2023 15:16:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Minjie Du <duminjie@vivo.com>, opensource.kernel@vivo.com,
 linux-um@lists.infradead.org, bpf@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Richard Weinberger <richard@nod.at>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230706013911.695-1-duminjie@vivo.com>
Subject: Re: [PATCH v4] um: vector: Fix exception handling in
 vector_eth_configure()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230706013911.695-1-duminjie@vivo.com>
X-Provags-ID: V03:K1:+zxh/YLDLGmRjkJRUeka2Do+HFkJNyd5nBqotS+CMLGEpowdfC2
 56FEq4o+q4TLsXDVv1XrEMDYLJhD9TLyAEkNtbffpq+70+8mwAXlLqUG7gt9r3pmbP1644s
 huAnrnlVUtHX5FxfkctCw2ovdd6q6+PRr4D7RmW1ric/p45x2pWNhv85m8WWI3VOrJGlRDF
 oALM1U/TmnDGBil+69g2w==
UI-OutboundReport: notjunk:1;M01:P0:Q+EI21sMTfA=;f05Co5tj4tm7I8SeThT3KRNhKGv
 Vf5zAwzRjl40ZxScPalPI609jsgO+idpeH0rozpCRTT6ZBTbv/Ssx9jcf+zJ2KWQCGZZsrBNZ
 pOBsozHbz1oBWr4PDj0Hm5CEwy5vYFXz6PMIo1ouv0Pv70wJqyLTVdNzXqB4nswsKbwd3JVTl
 GfGWt1mvebsy5dt01i1+6U+uL0EAM89WFoEOvXezWUW+i9/sJFAsXawgOKG9OOajedxaU2v2F
 xKO2K0CeLEFYfuT3slqVnqS2prr3dXGMazuZIGCo1M9sbqyYvFBeLDnCeT/keisJw5sdRtGex
 6KDjwy+upLtRIrQ7W4UGhpikG4+Z35yhagRrXlM3dfrWsUuH28iX2XNSM3IUzycgWLIRP1q9T
 Xz8xrhNh+9YWusKqSM6FoF4W9YB61kR7AjvgCO3eEDB/GVx8K6cyIl4okSHC1w/cN4xwAG8ar
 E5/eoFaNK64v96FrOZoHqyYKrn9tQHyxUtVlkFsCrjyY/+jaD+QZKD7oP8llgj6xsumY5xhWz
 2UMQ9ixlp0C3qUtj8WgvLQ2JCeVE2RNaaHBX65sN+YUJyaF6N8gLMhgr48PRFzZxFDoFiQOsY
 3kKDmdGjeAowd20xKAAD+BfouvTD2VXvXytxEw3rxDhCCPakG8szD/3Hxn0K0jNg3a02qURsx
 KYpt25y7UX15IkN8jc9LvBqrigp7mIqQoNiK9Fyr1xSXsITIkwMWQK66sE1f/k/ABHc+lduHX
 SVfV/pae4b0sptXtkFbP7J+Tqzii9ceKZcCl929LflS01yUHRosnQReYa6UN6W7odN9rmrVVe
 HDwSA038EfKZ3jLsrp2EFnzvah+15kEl9FUwrrW6WKFVxXLlI9hACsaVu3XyB9/E1+q2DjrBW
 fqOv+AIVQGW/H7Ay9lPqOnOJMlAdTRhlcAyJsZr/CY3PcOV1pzYrbij7sAaxVp2Y6AyoT41GQ
 OxAh7A==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230706_061708_402180_D058EFFC 
X-CRM114-Status: UNSURE (   5.70  )
X-CRM114-Notice: Please train this message.
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

PiBUaHVzIHJlcGxhY2UgdGhlIGp1bXAgdGFyZ2V0Cj4gIm91dF91bmRvX3VzZXJfaW5pdCIgYnkg
Im91dF9mcmVlX25ldGRldiIuCgpTdWNoIHRleHQgc2hvdWxkIGJlIGNvbWJpbmVkIGludG8gYSBz
aW5nbGUgbGluZS4KKDcxIGNoYXJhY3RlcnMgZml0IHN0aWxsIGludG8ga25vd24gd29yZGluZyBj
b25zdHJhaW50cy4pCgoKPiBEZWxhdGUgdGhlIG9ycGhhbiBmdW5jdGlvbiAib3V0X3VuZG9fdXNl
cl9pbml0IgoKUGxlYXNlIGF2b2lkIHR5cG9zIGluIHN1Y2ggYSBzZW50ZW5jZS4KCiogSG93IGhl
bHBmdWwgaXMgdGhlIGF0dGVtcHQgdG8gbWVudGlvbiBhIGRlbGV0aW9uPwoKKiBXb3VsZCB5b3Ug
ZXZlbnR1YWxseSBsaWtlIHRvIHJlZmVyIHRvIGEgbGFiZWwgaW5zdGVhZCBvZiBhIOKAnGZ1bmN0
aW9u4oCdPwoKClJlZ2FyZHMsCk1hcmt1cwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC11bQo=
