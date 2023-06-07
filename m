Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D0EC83005
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 09:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZGA3e+Ja5FwUnJXpEmzD+0WZGVgCrcgvBPNHXXjuW94=; b=dOiG2mFmR2GwF1
	hxx4fvDjrUqC7rBXKDquUJkpHgF5V5onHkW8BGTd1BZXMktnFJbDqVbihN4C6+5PfhgDti8Dh2HCS
	cfLRBo+SbcVtZgKhs9gKsb65Q6J4wrSNPIC1WqCgM8e2KI46uN1C1h4Fvc0qhaI3fKXWpmM5Tl0Yf
	eaFQNq1krRYIPmC2FHAPKkuAcZ6qu8s9isq07EAlkHE+XXxQGVkKUiDdMvDFESAHP9ZPA8Ls1czbj
	aCBbVqQo/dxO9H/SV30FFGAF8chHTmd0rbsu567Jx+tdTC+Rj/HEgXq/PJG13jTKkLF6ZrmsUChkX
	cuPQ17myjzOMuxd3KMJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6pjr-005K3h-2q;
	Wed, 07 Jun 2023 09:45:59 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6pjn-005Jzw-2x
	for linux-um@lists.infradead.org;
	Wed, 07 Jun 2023 09:45:57 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5147e8972a1so1170748a12.0
        for <linux-um@lists.infradead.org>; Wed, 07 Jun 2023 02:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1686131150; x=1688723150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79vzDiF+tHrnH1dRnmQpod9DfGlW5ryqo0lz5n79FPI=;
        b=FJamJYdT3if+5bC5MiBpMp+FFu/lOoO4qwlYSJv9n0/h/OCDUjBN+06Y5+uXbPlxGg
         WzF23UIBA7vCWADd8Vks7i2cG2U4opcA9P/78wHN/K4fj8HGhf6KnCl8YjjpgJJVnvlB
         hiZSt/O06mq6yVTGbe1Xbm78hWMDypBHvsUI14YH2ldWO/fNP5glJNykhF7/3t13XEm8
         J+PFP/ZVX+XFyUteBqBkDLqr81iNO7g4hjhPuN5y9T9TIVwh6rNLUX/Nk3vsBKiV6F+x
         GXhYFeACevO08CL9xeeLqMtmWxMOgxDUBpFi70eYskDjDqEfgVaRrrjyxsUtCDN7+EvU
         utwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686131150; x=1688723150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79vzDiF+tHrnH1dRnmQpod9DfGlW5ryqo0lz5n79FPI=;
        b=JmMMuCG/0DkJWRoKoyC3vqoMx8KbrRMNSfEj5Lj0Y60PUkYcP2lGQ19zLeQJUBlG+M
         3sbSrQfYW/erNx3qAacPfmuqTz7hAoUzthV6XCljDrxC65ZRf9NZm4P4+8EmAymcG24S
         EtFzdhRDPGtk35z7hzDHng0eoRZIeG+M3BjNBgT83xNUS08GTxSGHzZ7Hq1ySWyPUky1
         w5YYOu5oNAgEQnpkRyvsvoOFuFGu/Vj4Js2C65yOw/pM8if/oBIXVi/n6Q2KBfcuatBS
         tkl+z8A0eipJ1aWB2YGsy76+Tlwmv6obuq539KfIKO6iiUg17gu/JsqoKYmEw7MlrkuY
         TLxQ==
X-Gm-Message-State: AC+VfDxo+8Cs0xyUuk7Oc6C7Q9A6qwwKEDHoHRp80hB2P2UxON7FZxaj
	PnUaQO8cJbJw7bYigjnEEkyRjX9SKy5cdIWsFryU6g==
X-Google-Smtp-Source: ACHHUZ6S5zCcoB3bV8vZmXpO8sNjvRC4rvkXRPMqlcDG+MUEcxQoM5+7tlD1+Znnck9OUJnJex1d7ZYhdubt6xLn55E=
X-Received: by 2002:aa7:c3c3:0:b0:516:3261:17d with SMTP id
 l3-20020aa7c3c3000000b005163261017dmr3783303edr.20.1686131149770; Wed, 07 Jun
 2023 02:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-29-hch@lst.de>
In-Reply-To: <20230606073950.225178-29-hch@lst.de>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 7 Jun 2023 11:45:39 +0200
Message-ID: <CAMGffEk2LB0CDqR6DJczhejkkyK1Q5Ybu-wJ_fr99O0fXa-pew@mail.gmail.com>
Subject: Re: [PATCH 28/31] block: replace fmode_t with a block-specific type
 for block open flags
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>, Josef Bacik <josef@toxicpanda.com>, 
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>, Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com, 
	linux-block@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org, 
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_024555_961203_05B76F5F 
X-CRM114-Status: GOOD (  12.22  )
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

T24gVHVlLCBKdW4gNiwgMjAyMyBhdCA5OjQx4oCvQU0gQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBs
c3QuZGU+IHdyb3RlOgo+Cj4gVGhlIG9ubHkgb3ZlcmxhcCBiZXR3ZWVuIHRoZSBibG9jayBvcGVu
IGZsYWdzIG1hcHBlZCBpbnRvIHRoZSBmbW9kZV90IGFuZAo+IG90aGVyIHVzZXMgb2YgZm1vZGVf
dCBhcmUgRk1PREVfUkVBRCBhbmQgRk1PREVfV1JJVEUuICBEZWZpbmUgYSBuZXcKPiBibGtfbW9k
ZV90IGluc3RlYWQgZm9yIHVzZSBpbiBibGtkZXZfZ2V0X2J5XyosIC0+b3BlbiBhbmQgLT5pb2N0
bCBhbmQKPiBzdG9wIGFidXNpbmcgZm1vZGVfdC4KPgo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9w
aCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+IC0tLQo+ICBhcmNoL3VtL2RyaXZlcnMvdWJkX2tlcm4u
YyAgICAgICAgICB8ICA4ICsrKy0tLQo+ICBhcmNoL3h0ZW5zYS9wbGF0Zm9ybXMvaXNzL3NpbWRp
c2suYyB8ICAyICstCj4gIGJsb2NrL2JkZXYuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgMzIg
KysrKysrKysrKystLS0tLS0tLS0tLQo+ICBibG9jay9ibGstem9uZWQuYyAgICAgICAgICAgICAg
ICAgICB8ICA4ICsrKy0tLQo+ICBibG9jay9ibGsuaCAgICAgICAgICAgICAgICAgICAgICAgICB8
IDExICsrKystLS0tCj4gIGJsb2NrL2ZvcHMuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgMjYg
KysrKysrKysrKysrKy0tLS0tCj4gIGJsb2NrL2dlbmhkLmMgICAgICAgICAgICAgICAgICAgICAg
IHwgIDggKysrLS0tCj4gIGJsb2NrL2lvY3RsLmMgICAgICAgICAgICAgICAgICAgICAgIHwgNDIg
KysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgZHJpdmVycy9ibG9jay9hbWlmbG9wLmMg
ICAgICAgICAgICAgfCAxMiArKysrLS0tLS0KPiAgZHJpdmVycy9ibG9jay9hb2UvYW9lYmxrLmMg
ICAgICAgICAgfCAgNCArLS0KPiAgZHJpdmVycy9ibG9jay9hdGFmbG9wLmMgICAgICAgICAgICAg
fCAyNSArKysrKysrKystLS0tLS0tLQo+ICBkcml2ZXJzL2Jsb2NrL2RyYmQvZHJiZF9tYWluLmMg
ICAgICB8ICA3ICsrLS0tCj4gIGRyaXZlcnMvYmxvY2svZHJiZC9kcmJkX25sLmMgICAgICAgIHwg
IDIgKy0KPiAgZHJpdmVycy9ibG9jay9mbG9wcHkuYyAgICAgICAgICAgICAgfCAyOCArKysrKysr
KystLS0tLS0tLS0tCj4gIGRyaXZlcnMvYmxvY2svbG9vcC5jICAgICAgICAgICAgICAgIHwgMjIg
KysrKysrKy0tLS0tLS0tCj4gIGRyaXZlcnMvYmxvY2svbXRpcDMyeHgvbXRpcDMyeHguYyAgIHwg
IDQgKy0tCj4gIGRyaXZlcnMvYmxvY2svbmJkLmMgICAgICAgICAgICAgICAgIHwgIDQgKy0tCj4g
IGRyaXZlcnMvYmxvY2svcGt0Y2R2ZC5jICAgICAgICAgICAgIHwgMTcgKysrKysrLS0tLS0tCj4g
IGRyaXZlcnMvYmxvY2svcmJkLmMgICAgICAgICAgICAgICAgIHwgIDIgKy0KPiAgZHJpdmVycy9i
bG9jay9ybmJkL3JuYmQtY2x0LmMgICAgICAgfCAgNCArLS0KPiAgZHJpdmVycy9ibG9jay9ybmJk
L3JuYmQtc3J2LmMgICAgICAgfCAgNCArLS0KQWNrZWQtYnk6IEphY2sgV2FuZyA8amlucHUud2Fu
Z0Bpb25vcy5jb20+ICMgZm9yIHJuYmQuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LXVtCg==
