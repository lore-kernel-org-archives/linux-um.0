Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB92C7EE29
	for <linux-um@archiver.kernel.org>; Fri,  9 Jun 2023 18:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nGg576+OAKzoJKDnkPA4RYBdTuibOS+xW17DajG615w=; b=VkYhmnfmyIrl6h
	rvQ5bIezlZ24uYFlp1Qfesr8PT5CPuuwyifKUEGLXR23CeADC0skJq2lJmq7kWgpxaKTrRFGFjwxp
	SXe9n1WMQvfqgb5XpVbWz9Koxtw008qiCTq4uSN3Xq4DKwFBL0DcVS/2unviiR+0tRYpx0pygASjQ
	8ufNrr5k31fqjHNmXsjeDtiYqjFJi/v+KKl22sIt/9qgvyn8aG1WxB1zmGitKz1CrEDfwf5x+Aoz2
	we9WaKvzpzUGkoiiYS9jLBtbUnPNMhYjGN46d4C4xfycXyBfBKPutA3c7QHRjJuKEAmKqWmhIRdfZ
	OVf5/4NtUhuTKXuYxyQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7gcK-00Dor7-0Q;
	Fri, 09 Jun 2023 18:13:44 +0000
Received: from mail-ej1-f42.google.com ([209.85.218.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7gcH-00Doq2-1w;
	Fri, 09 Jun 2023 18:13:42 +0000
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-977d3292be0so55136766b.1;
        Fri, 09 Jun 2023 11:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686334418; x=1688926418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2Xux0G0tFdJlDzvQzZhcAqUXfykTqTn9g16hyE21ys=;
        b=NV0CkBw4nmWEwuzFqyTgE8pMc6ohHI50RCmpRM7cASpGjLsaMap4qtpeBttp1CVMP+
         PJFTAiyy8tV4MwYEzq+Orpp94bz2dMrP+MmnKY/csTMgkNejNE9ZnmRznMciU+zpTpY7
         bPNZ4p10ZIvf05uPIgpS7ARcYLwDCRBj2AE2gzzKhiUhbrxsm5k3NP0SXxsYL0L0ic+9
         qSS1rvcmw8QV2cbSke37bmYxXv3vrqmtNhPsuyaRe+gxFjSrIAfMUMxYXmQABefirrQ0
         DcrVWwgNHQoQOdjOctypsGLJaXZYaVCvxKQphTg/PiNdgpVozz5ef+bNROFS7fxGpkfM
         lrqA==
X-Gm-Message-State: AC+VfDwyB5usC5qH7bD+Bg83h8xcx19AJwg1E8AHA3aF3OetGzbIvEmk
	PUW9tbWP8z+4Hdle+WDZFHCZVWeBupQ8Z1XnIUo=
X-Google-Smtp-Source: ACHHUZ7r7lbBrTdxRkyp2bTqJCFBDA6+Ddf+RviatN0r97z5LUsaxAu6Q2CxPlvVkZ/6P5sUxBvleBvx6ETeZa4XK48=
X-Received: by 2002:a17:906:1049:b0:974:56cb:9dfc with SMTP id
 j9-20020a170906104900b0097456cb9dfcmr1993996ejj.1.1686334417837; Fri, 09 Jun
 2023 11:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230608110258.189493-1-hch@lst.de> <20230608110258.189493-12-hch@lst.de>
In-Reply-To: <20230608110258.189493-12-hch@lst.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Jun 2023 20:13:23 +0200
Message-ID: <CAJZ5v0h61q6=JxjeUjjMz5k05HuRGWVKp_rK+9N8rug58kU_VQ@mail.gmail.com>
Subject: Re: [PATCH 11/30] swsusp: don't pass a stack address to blkdev_get_by_path
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>, Josef Bacik <josef@toxicpanda.com>, 
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>, 
	Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com, 
	linux-block@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org, 
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Hannes Reinecke <hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_111341_642144_B64FA3DF 
X-CRM114-Status: GOOD (  17.44  )
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

T24gVGh1LCBKdW4gOCwgMjAyMyBhdCAxOjAz4oCvUE0gQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBs
c3QuZGU+IHdyb3RlOgo+Cj4gaG9sZGVyIGlzIGp1c3QgYW4gb24tc3RhY2sgcG9pbnRlciB0aGF0
IGNhbiBlYXNpbHkgYmUgcmV1c2VkIGJ5IG90aGVyIGNhbGxzLAo+IHJlcGxhY2UgaXQgd2l0aCBh
IHN0YXRpYyB2YXJpYWJsZSB0aGF0IGRvZXNuJ3QgY2hhbmdlLgo+Cj4gU2lnbmVkLW9mZi1ieTog
Q2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Cj4gUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWlu
ZWNrZSA8aGFyZUBzdXNlLmRlPgoKQWNrZWQtYnk6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxA
a2VybmVsLm9yZz4KCj4gLS0tCj4gIGtlcm5lbC9wb3dlci9zd2FwLmMgfCA1ICsrKy0tCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0t
Z2l0IGEva2VybmVsL3Bvd2VyL3N3YXAuYyBiL2tlcm5lbC9wb3dlci9zd2FwLmMKPiBpbmRleCA4
MWFlYzNiMmM2MDUxMC4uYjAzZmYxYTMzYzdmNjggMTAwNjQ0Cj4gLS0tIGEva2VybmVsL3Bvd2Vy
L3N3YXAuYwo+ICsrKyBiL2tlcm5lbC9wb3dlci9zd2FwLmMKPiBAQCAtMTUxMCw2ICsxNTEwLDgg
QEAgaW50IHN3c3VzcF9yZWFkKHVuc2lnbmVkIGludCAqZmxhZ3NfcCkKPiAgICAgICAgIHJldHVy
biBlcnJvcjsKPiAgfQo+Cj4gK3N0YXRpYyB2b2lkICpzd3N1c3BfaG9sZGVyOwo+ICsKPiAgLyoq
Cj4gICAqICAgICAgc3dzdXNwX2NoZWNrIC0gQ2hlY2sgZm9yIHN3c3VzcCBzaWduYXR1cmUgaW4g
dGhlIHJlc3VtZSBkZXZpY2UKPiAgICovCj4gQEAgLTE1MTcsMTQgKzE1MTksMTMgQEAgaW50IHN3
c3VzcF9yZWFkKHVuc2lnbmVkIGludCAqZmxhZ3NfcCkKPiAgaW50IHN3c3VzcF9jaGVjayhib29s
IHNuYXBzaG90X3Rlc3QpCj4gIHsKPiAgICAgICAgIGludCBlcnJvcjsKPiAtICAgICAgIHZvaWQg
KmhvbGRlcjsKPiAgICAgICAgIGZtb2RlX3QgbW9kZSA9IEZNT0RFX1JFQUQ7Cj4KPiAgICAgICAg
IGlmIChzbmFwc2hvdF90ZXN0KQo+ICAgICAgICAgICAgICAgICBtb2RlIHw9IEZNT0RFX0VYQ0w7
Cj4KPiAgICAgICAgIGhpYl9yZXN1bWVfYmRldiA9IGJsa2Rldl9nZXRfYnlfZGV2KHN3c3VzcF9y
ZXN1bWVfZGV2aWNlLAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbW9kZSwgJmhvbGRlciwgTlVMTCk7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBtb2RlLCAmc3dzdXNwX2hvbGRlciwgTlVMTCk7Cj4gICAgICAgICBpZiAo
IUlTX0VSUihoaWJfcmVzdW1lX2JkZXYpKSB7Cj4gICAgICAgICAgICAgICAgIHNldF9ibG9ja3Np
emUoaGliX3Jlc3VtZV9iZGV2LCBQQUdFX1NJWkUpOwo+ICAgICAgICAgICAgICAgICBjbGVhcl9w
YWdlKHN3c3VzcF9oZWFkZXIpOwo+IC0tCj4gMi4zOS4yCj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11
bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtdW0K
