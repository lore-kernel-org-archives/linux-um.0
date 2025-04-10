Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F7AC369A6
	for <linux-um@archiver.kernel.org>; Thu, 10 Apr 2025 12:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:From:Subject:Cc:To:
	Message-Id:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EZ4z/28EfxfO3oxZfrJLQlmuqBAgYz/OgMCvp3sNkQo=; b=SrEZtLIF/1P71xHiGjVvMQgwrQ
	YmzKL+wRZyH2tCQD4V6psohhgTqQBi93BHaZ4Sl1wSPDfwdTo1xN0P/ULhiYLVnxdq3zPufkmuJou
	LO1YPXZry0A/xQoMM2sIiFE8VfjIjyvxrQKYvpMTSQRLYcYZfITYqQTstJr++0YIzRDD7uNPFm9Ma
	2Ly95vCezEGV/wZAMKnFJjLEXi9ObmV0aBX26wRRB7Rxq7YHfcKUXehYa2pGYrABTtpwv+aY7qdMd
	oS1Tc7GrtGvsmtfog+aOnZ623uPCJOjE7iAgE5qNfy/FMEAOR28xEwfFNPaXCIVuUb1fsIbaJ0CTD
	PbpGxrWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2rTN-0000000AaQY-19f2;
	Thu, 10 Apr 2025 12:57:37 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2rSp-0000000AaM2-10zO
	for linux-um@lists.infradead.org;
	Thu, 10 Apr 2025 12:57:04 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-22423adf751so6918975ad.2
        for <linux-um@lists.infradead.org>; Thu, 10 Apr 2025 05:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744289822; x=1744894622; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZ4z/28EfxfO3oxZfrJLQlmuqBAgYz/OgMCvp3sNkQo=;
        b=WM/wauRMG8g0qlLXYmKCMlV0f42Huw0j5peSI170xMEuVw/SeHMWVLodao9WagiGoq
         ncjd9aRGzfZZh2498Q/D1vZ1W6n7XWe1oUX7Sgw/lpELAY0RNldAMakZaKm9LM9dbYhV
         NWGC4GtlMwVWsDyeLFdWr3BBl6vs5STOMAlYPDAA9dGp5Onvt9UuOxuoM2TDQmgZzXF9
         IkIq+hSiIQlApLRr/hLPzEEJlvPBx6esAGPHfRInIYz4Lkf6Tj6cTQYaJ6YaWkKBMPqh
         RQsiq5CoLGB1b3xMco4+848Fxt6vFFFwfp07Pc8ny3X7hJtjlUEEpf7J/yq2G8EA1qge
         rucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744289822; x=1744894622;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EZ4z/28EfxfO3oxZfrJLQlmuqBAgYz/OgMCvp3sNkQo=;
        b=JrELnDnygW0d5F6UEABMFhomkYP/zMciBaPtW3tO5J1OL6fElYKdBw+Ug+GyDmxMVL
         IGTtTTZ4WGi+NeuT085xFjMQc3hjaeFcmb+jWQhNF5OOKxeETfO/7gVCtb+WRfiSFr2E
         tzThLkwQbnfQmXkehclQ/sKEhDJAsxrtPOmbVNFgJVn+0b9fPxFmHscZBWcLXi81BalB
         dH5rtGvAW9g7Z+rRU1q9BhAzeNe8w3AcG/Flze/vJ1RGhcv6XcjFj7ubQDqZ7Z1NXgR7
         i8d9fL4tFYuU+80AMj6jcDjesqH8WWoD/Y092+wVEVQjX2mKoKj9PpUDKejbl/NN/smY
         vAeA==
X-Forwarded-Encrypted: i=1; AJvYcCXFKJyue6WJayo/FgU8GhNKoI7Oln0Dh3jBJEHVH8cc8Qkh9r+A3lezRkPXMxYv24ZQvyNHNGm/sQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwJdCpT4On5NVSK8sxd9FD8LoNxkO2yz/Hz6pHFVLjT0HwSD9/0
	PDzAoLVTTnK8pJw/nKpWMXwAeY7XZAqB0KuUD0aioal3DOKqAQt1
X-Gm-Gg: ASbGncsdR3/opXyuAMxZP+bzpX0bHah7Vi/eYt4AqMsUFEtmASinFDA3RP9qzW7wKi2
	ie//McmLFa5xtNPxJAEr2rC4bU1NNgl8QRg4C8bOe7j3NTjh3kSvOqqgxBvadBdNz6AHh9q0Bgz
	K8g3ccK88ovJa89FP6lBEgHtPvRvaFQjm0QtDmZ32DolUMZkeRibQH1BGrGJw+mc8oUFgmYDRHp
	kdfvd5248mW4FF9axJUeElzLiU924u9vokWMHupAKLLjpARfRgwNRnFrsUCcLLrjXCxlqiqPocj
	Wk/LIruPnYbeNN+CbggHSwdn8GK3jtDsArpMWpd4vq7fQDrJ30b1R4O7g/Jof7dR4GED3cTi/Eg
	Q8SUxJee3AR8XKZcb+85rXIw=
X-Google-Smtp-Source: AGHT+IGCRmoxS1zS4tW8gFl5fzI7gwL+BsMOXnOBUlG6VzNXgSR1hewla7A4SswFBn81JMiNi/32hw==
X-Received: by 2002:a17:903:1a68:b0:223:517c:bfa1 with SMTP id d9443c01a7336-22b42c28921mr46105425ad.38.1744289821807;
        Thu, 10 Apr 2025 05:57:01 -0700 (PDT)
Received: from localhost (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c95ca4sm29407145ad.124.2025.04.10.05.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 05:57:01 -0700 (PDT)
Date: Thu, 10 Apr 2025 21:56:50 +0900 (JST)
Message-Id: <20250410.215650.1951840861716787929.fujita.tomonori@gmail.com>
To: dakr@kernel.org
Cc: geert@linux-m68k.org, miguel.ojeda.sandonis@gmail.com,
 fujita.tomonori@gmail.com, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, logang@deltatee.com, sbates@raithlin.com,
 dinguyen@kernel.org, arnd@arndb.de
Subject: Re: [PATCH v1] um: fix incompatible argument type in iounmap()
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <Z_auq9XEUxMwKVoN@cassiopeiae>
References: <CANiq72mbci8kxEx5jrq=HVc6WKuJqq8NCLzNsjH1wFcJNoHm+w@mail.gmail.com>
	<CAMuHMdWtgSjxeGYJVNzeWPOCd9nUWeKQnCtFQaROQ1o=r_-QwQ@mail.gmail.com>
	<Z_auq9XEUxMwKVoN@cassiopeiae>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_055703_277546_04F85B85 
X-CRM114-Status: GOOD (  14.79  )
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

T24gV2VkLCA5IEFwciAyMDI1IDE5OjMwOjE5ICswMjAwDQpEYW5pbG8gS3J1bW1yaWNoIDxkYWty
QGtlcm5lbC5vcmc+IHdyb3RlOg0KDQo+PiBPbiBXZWQsIDkgQXByIDIwMjUgYXQgMTY6NDgsIE1p
Z3VlbCBPamVkYQ0KPj4gPG1pZ3VlbC5vamVkYS5zYW5kb25pc0BnbWFpbC5jb20+IHdyb3RlOg0K
Pj4gPiBPbiBXZWQsIEFwciA5LCAyMDI1IGF0IDg6MTbigK9BTSBGVUpJVEEgVG9tb25vcmkNCj4+
ID4gPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+IHdyb3RlOg0KPj4gPiA+DQo+PiA+ID4gQWxp
Z24gaW91bm1hcCgpIHNpZ25hdHVyZSB3aXRoIG90aGVyIGFyY2hpdGVjdHVyZXMuDQo+PiA+DQo+
PiA+IE1vc3QgaW5kZWVkIGhhdmUgYHZvbGF0aWxlYCwgYnV0IG5pb3MyIGFuZCBtNjhrIGRvbid0
IC0tIENjJ2luZyB0aGVtDQo+PiA+IGp1c3QgaW4gY2FzZS4NCj4+IA0KPj4gSW5kZWVkLiBBcHBh
cmVudGx5IHRoZSB2b2xhdGlsZSBrZXl3b3JkIGhhcyBub3QgYWx3YXlzIGJlZW4gdGhlcmUuLi4N
Cj4+IFdoeSBkb2VzIGlvdW5tYXAoKSBuZWVkIHRoZSB2b2xhdGlsZSBrZXl3b3JkPw0KPj4gV2h5
IGRvZXMgcGNpX2lvdW5tYXAoKSBub3QgaGF2ZSB0aGUgdm9sYXRpbGUga2V5d29yZD8NCj4gDQo+
IEkgdGhpbmsgbm9uZSBvZiB0aGUgZnVuY3Rpb25zIHdpdGhpbiBydXN0L2hlbHBlcnMvaW8uYyBu
ZWVkIHZvbGF0aWxlLCBzaW5jZSB0aGV5DQo+IGp1c3QgZGVmZXIgdG8gdGhlIGNvcnJlc3BvbmRp
bmcgQyBmdW5jdGlvbiAvIG1hY3JvLg0KDQpZZWFoLCBhbGwgdm9sYXRpbGUgaW4gdGhlIGZpbGUg
c2hvdWxkIGJlIHNhZmUgdG8gcmVtb3ZlLiBJJ2xsIGdvIHdpdGgNCnRoYXQgYXBwcm9hY2ggZm9y
IHRoZSBuZXh0IHZlcnNpb24uDQoNCkkgdGhpbmsgaXQgd291bGQgYmUgbmljZSB0byBoYXZlIHRo
ZSBzYW1lIGZ1bmN0aW9uIHNpZ25hdHVyZSBhY3Jvc3MNCmFsbCBhcmNoaXRlY3R1cmVzLCBidXQg
dGhhdCdzIGEgc2VwYXJhdGUgdG9waWMuDQoNClRoYW5rcywNCg==

