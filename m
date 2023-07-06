Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF15EB64D9
	for <linux-um@archiver.kernel.org>; Thu,  6 Jul 2023 13:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:Subject:References:Cc:
	To:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3Afu8vZcrcHQz+nXyYTCQCGnxyvoiQgnHvLOCmixeiI=; b=U+g92eJoL310gN
	CSDrBpinZLoEJrJ4RyRh5KA4Ifyn2y0cwBJXPWIJyuMRUq24RrjDZffgEApRpxBGuAmyiG4FEI15Y
	4+PhsM1EpHPM1A1V6zxtjjgoeOsaJjotlJDG2chrG4qmrehpjMSSram2P/7g47KvuXSTjGO92rtd4
	hGEsB7ErHK+HoO5TYscQp1SvBDT4cK0yiArq45dRNw258GfJ2JogqEDpYuLo7tkZOi/FM5iX8LiZ5
	dRMDNnpzS8BjQbfy/BEWAW4IBdMm2QiZT9/FkQi3OiNo1GPorTzKOQU/shctlep/jVzJZ5EdRT+3h
	sDXPYaFnmViqRjjFilFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHP4x-001m2x-1M;
	Thu, 06 Jul 2023 13:31:27 +0000
Received: from mout.web.de ([217.72.192.78])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHP4u-001m1z-1m
	for linux-um@lists.infradead.org;
	Thu, 06 Jul 2023 13:31:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688650263; x=1689255063; i=markus.elfring@web.de;
 bh=zU1+ngJqAXmM8EMrdKQSXHeJ0R/3OXaMxXgWEQx8xiA=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=dRrI9NCZpyFUXPPoXapCdZlS7ikRUA0LUP7KUPqTn86i6CeVaWSFqzMl4m3VGjOu9zQxS2L
 MnLiI/bN4JsEU6ha2OPOBTgz8f44i8Mv1PCTDpfYCZb1/D9uSN/2HL4CSEjyXqsAgty8Pa4HY
 IbPukRralXCqyq7lMQ/0hhjmjen3uZWhYnp2ASvBjU5s/G/TcprVingRPlPjL50/oXDc0sKno
 cfIxXKFO6ZpoX+4WRRG4dpjO2JtjQ+d9F0bYuVXn6pkIRkc8BzbAxZfm9apjOaOyU+cu3b0qO
 b4iFR7asgCYa3Mx4i4ctzubKqV24lxxdHdh3thS2TMmkmPHygRSg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3Eut-1qInBS23np-003kOi; Thu, 06
 Jul 2023 15:31:03 +0200
Message-ID: <19486cb7-354f-a66d-a5cf-2dab6621eb4a@web.de>
Date: Thu, 6 Jul 2023 15:31:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Minjie Du <duminjie@vivo.com>, linux-um@lists.infradead.org,
 bpf@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: opensource.kernel@vivo.com, LKML <linux-kernel@vger.kernel.org>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Richard Weinberger <richard@nod.at>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230706013911.695-1-duminjie@vivo.com>
Subject: Re: [PATCH v4] um: vector: Fix exception handling in
 vector_eth_configure()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230706013911.695-1-duminjie@vivo.com>
X-Provags-ID: V03:K1:Q8UYAR2dWW/gVhnhLUdBD7PKRHC8lgJuVkBojDHR5oGBAoH9pHp
 yaWX/eYhSwCQVv/gp70wOY8Qdopp5LJrkV73t8fVS1pKOHTWfkZJO8hwypU+9bDO/0ua/ca
 qKZq0UpZEJLXdb5zjULlZplv+TYvzXoeqGdBgon/rV3Bv+gZTXasH84ocKNHLs4vQ0AmXYq
 UJPUMjQ+B7xqNpn4tj1Sw==
UI-OutboundReport: notjunk:1;M01:P0:2wuXs4dTJP4=;B38QPAXbjFvX2Rq2hVMbB1VNLV6
 wcgw27AmT2xtfa1/sDmyKhO3hBK5EpfxI02rzuaIHUEbbXE+Px27rAnCV8OIif/Z1kp9bgpOS
 v2Zd3M9IpjvXRRzMVYnNNRrMxhweE21L6n7iQma95VsatlOeBsG3nVVOzo6cJYnQ6zg4kcx/x
 9ALh0Kt6oCDd2bqx+LvvpQpwLjiK6OIUhCP3PqSIucDrMItYzEPshp5OomjylOMDHJRHM2EpD
 oIU+bxxABsPWCTrrfytwP3TCyr97EjbAK3VNLjrcH863Aq6glO5QmiAYaD/xw1hdeCKITuYPE
 3hmjb8RMYqy7BEONiHVtm0Q0nNoFwyWtV3JyL02BuXSf+4CvCkNbYPKX0254b1bJmMogytlbE
 A+UYwjKaDhNxNveLyQEhJnblfFtYAccxzTiGCOaXbbrQXSNOS7u0ci0HDSUbfF8MLKahSvd6l
 zblfgETFtumhU/JwQsL3sDfj6ZDfYqr//aP4rE3ogd1VgWnv8yyzaURoGghiCC8rz2JvbdnIR
 40qUuvDqwV+iJ4qTkBFQFt1bG/tX3fYnB4XhzJW4W+Eypj6rvrcYl7U4NRv2+NsIgMCBIcPcL
 FRT+xJdyxxSLBuiY+JhRQIpg7aq5gdnyA/qpRndzTxWgyMgxG63L/uu4zxUIH9USQqHkoniX3
 4i3SLoMtgD+7lYCh8SXcDh9nrfaxrBRabA1CUdUHz8m1DHTze5YUDmgmneJ1JhgDjc36y7Dg9
 xtDGlmIZ5bBLbildFcyR/b2I//+i5c5S1d+aeK177/URgwJqeVUW78J7jG/+pXuNtLI/cK3pB
 Vkzf2KWcHfWWtLTv078osN82XdCCdOabdIfiwyF5t3ImZA5mE7Q61bb8VVw6BOIjdk97zDLBy
 bYU1fsshT3pNGFsGuwhV7fj25C7f/DuU4Wbeup5arBF93RuCbqHenStmoG/tMXzdkUSrcPVTJ
 6sxGEQ7u4baYrWVt5MhfKYPifXY=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230706_063124_873822_7A8A4AF3 
X-CRM114-Status: UNSURE (   5.60  )
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

PiBUaGUgcmVzb3VyY2UgY2xlYW51cCB3YXMgaW5jb21wbGV0ZSBpbiB0aGUgaW1wbGVtZW50YXRp
b24KPiBvZiB0aGUgZnVuY3Rpb24gInZlY3Rvcl9ldGhfY29uZmlndXJlIi4K4oCmCj4gUEFUQ0gg
djEtdjM6IE1vZGlmeSB0aGUgcGF0Y2ggZm9ybWF0LgrigKYKClN1Y2ggYSB2ZXJzaW9uIGRlc2Ny
aXB0aW9uIHNob3VsZCB1c3VhbGx5IGJlIHB1dCBpbnRvIGEgY29tbWVudCBhcmVhCihwYXRjaCBj
aGFuZ2Vsb2cpIGFmdGVyIGEgbWFya2VyIGxpbmUuCgpTZWUgYWxzbzoKaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUv
RG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3Q/aD12Ni40I242ODYK
CgpXb3VsZCB5b3UgbGlrZSB0byBhZGQgdGhlIHRhZyDigJxGaXhlc+KAnT8KClJlZ2FyZHMsCk1h
cmt1cwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
