Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88D0C77B7A
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 09:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+YqL9HLq5x2gVapWcXqVjUxljmWE419+q5LzfIaCC/o=; b=UbNupw2KKn3H8S
	Zmdj9xF8xw9AZ26O8YeXym1dToeC7QI6DrvKSF9b6AfyjAsVCLVzOTTorTgPYvAzVftuLIhs1YpoS
	A0VgZBPASa9adZvWCcMSKM+2v6+1Rc4pCVFPt75qecjan1tiIvjLA7waFE6ig9ibzxebEgEu28qVY
	yEx+YXSGnhiu8nieJXwqZ3higNtNp5QHcn8xXK11lZd7hUzetYqOTd/5hphGvLkXBS21x7i5lMd6v
	UulzxveHZ8zGdgvi+9/r/z5Tfyy3uoBCX6zMLNljmzLAHT8gpthlnIP142pV228ZMz/IM7LeEOHTu
	iW6a2J+3l/a8ANa1L8Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6pcr-005HXo-0i;
	Wed, 07 Jun 2023 09:38:45 +0000
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6pcp-005HVX-0L
	for linux-um@lists.infradead.org;
	Wed, 07 Jun 2023 09:38:44 +0000
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-977cf86aae5so578819266b.0
        for <linux-um@lists.infradead.org>; Wed, 07 Jun 2023 02:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1686130719; x=1688722719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjKWGYzTLmxl6ndmaqY1vhf0MYCxKeiBaM5D6TZOn9k=;
        b=YXuPeKYHXY8x573VqT+WBt2/3c0ykgaHJuCFCznCBd9Wetpo4vgup6yqqURCu0byaA
         Z/WQU4wI1a6QCL47tLiZRI6KTt32VZU/qDKhKKJKLQFyY7AmMCGDwrGB1pizVTFQERU7
         t/x6PD6wstNl8G+Np+qAroVsRlq5DhK6VHOceLAS64dGk9Gj3fcvwZo0Y8lemLlMRb9N
         lmkimh7iJEnOSo+NJeMchGTnQhFoj8noYEGMLBj46T+S0Fm4jsdixCjB8sRTniHot4zo
         HY10z3v3++4U48Fj0kZDnrEgImtyRX0sgkHyTWWoWMiMmGGRFIMZm1Lm0qh585DtYYsI
         wCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686130719; x=1688722719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjKWGYzTLmxl6ndmaqY1vhf0MYCxKeiBaM5D6TZOn9k=;
        b=US/Eke0iqEhsHeOOPb2VoqfXc31K1ig7eQuU6Oj9IR3fZQx7kXJ+C9VsIuewoyjg3K
         QV35GzjL+/vZdFskbdk4vw95FkPrfIEJjH9FwkPavG2iN+o9/qfUCnssqbrRc9e+U2OE
         dn0b3hw0bIwxErSh+zHCIlccdv1MRwR6aXK9+3jIykD8HX3HspHdulcfZMr3TI7zlc9y
         x2nbEf+l80zLLa263Q8v5F9L6ysowIzqkc37Euk7BI+DJaXisQcUrpPp/wQll+uN/SUn
         xRS9a/5cDpqTYLi+VgOt/9/QZ+nnp9YW5IYrxPUxuI8Cee8MyDLlYXUy56Tb5r/ykBw0
         AVBQ==
X-Gm-Message-State: AC+VfDwarclXK5qaKhnEXguGu8qiNI23aMAGfbZV5p4GS6RIaz/6ZLOy
	U73gNHz32w7bKLSojkXlKdhIzmP0pU+3GTg1xL4txw==
X-Google-Smtp-Source: ACHHUZ4JO4oLBtR+CLz1tcyt1M0aK5Az38dx3TKZ26TI2779MlmTOIaNGaUTpmyncHvDOVtnmf3szZ6EUx+OtsgHRJ4=
X-Received: by 2002:a17:907:3f22:b0:96b:1608:3563 with SMTP id
 hq34-20020a1709073f2200b0096b16083563mr5475281ejc.58.1686130718689; Wed, 07
 Jun 2023 02:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-15-hch@lst.de>
In-Reply-To: <20230606073950.225178-15-hch@lst.de>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 7 Jun 2023 11:38:27 +0200
Message-ID: <CAMGffEk8Zex5+u69YW9AXGQh-ch79mw7=Gn3L1M=qwvZCVa5VA@mail.gmail.com>
Subject: Re: [PATCH 14/31] rnbd-srv: don't pass a holder for non-exclusive blkdev_get_by_path
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
X-CRM114-CacheID: sfid-20230607_023843_139284_D262C0D5 
X-CRM114-Status: GOOD (  15.66  )
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

T24gVHVlLCBKdW4gNiwgMjAyMyBhdCA5OjQw4oCvQU0gQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBs
c3QuZGU+IHdyb3RlOgo+Cj4gUGFzc2luZyBhIGhvbGRlciB0byBibGtkZXZfZ2V0X2J5X3BhdGgg
d2hlbiBGTU9ERV9FWENMIGlzbid0IHNldCBkb2Vzbid0Cj4gbWFrZSBzZW5zZSwgc28gcGFzcyBO
VUxMIGluc3RlYWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxz
dC5kZT4KQWNrZWQtYnk6IEphY2sgV2FuZyA8amlucHUud2FuZ0Bpb25vcy5jb20+Cj4gLS0tCj4g
IGRyaXZlcnMvYmxvY2svcm5iZC9ybmJkLXNydi5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Js
b2NrL3JuYmQvcm5iZC1zcnYuYyBiL2RyaXZlcnMvYmxvY2svcm5iZC9ybmJkLXNydi5jCj4gaW5k
ZXggY2VjMjJiYmFlMmY5YTUuLmNlNTA1ZTU1MmY0ZDUwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
YmxvY2svcm5iZC9ybmJkLXNydi5jCj4gKysrIGIvZHJpdmVycy9ibG9jay9ybmJkL3JuYmQtc3J2
LmMKPiBAQCAtNzE5LDcgKzcxOSw3IEBAIHN0YXRpYyBpbnQgcHJvY2Vzc19tc2dfb3BlbihzdHJ1
Y3Qgcm5iZF9zcnZfc2Vzc2lvbiAqc3J2X3Nlc3MsCj4gICAgICAgICAgICAgICAgIGdvdG8gcmVq
ZWN0Owo+ICAgICAgICAgfQo+Cj4gLSAgICAgICBiZGV2ID0gYmxrZGV2X2dldF9ieV9wYXRoKGZ1
bGxfcGF0aCwgb3Blbl9mbGFncywgVEhJU19NT0RVTEUsIE5VTEwpOwo+ICsgICAgICAgYmRldiA9
IGJsa2Rldl9nZXRfYnlfcGF0aChmdWxsX3BhdGgsIG9wZW5fZmxhZ3MsIE5VTEwsIE5VTEwpOwo+
ICAgICAgICAgaWYgKElTX0VSUihiZGV2KSkgewo+ICAgICAgICAgICAgICAgICByZXQgPSBQVFJf
RVJSKGJkZXYpOwo+ICAgICAgICAgICAgICAgICBwcl9lcnIoIk9wZW5pbmcgZGV2aWNlICclcycg
b24gc2Vzc2lvbiAlcyBmYWlsZWQsIGZhaWxlZCB0byBvcGVuIHRoZSBibG9jayBkZXZpY2UsIGVy
cjogJWRcbiIsCj4gLS0KPiAyLjM5LjIKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC11bQo=
