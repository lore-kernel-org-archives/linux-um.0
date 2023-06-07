Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D1FC7EE2E
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 09:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uzX+YWvtk3gQieQCzT/G1zLUyD8FxHjkcd2iZV1YY9A=; b=hpkBg4RMjy5Z7h
	d9jFhnZhImujDa/TZM5rqrMH6gV+tr1F6OjxGZTwlB6bcba45dps0werKHp6PJJFz8B2MpexO1ZGO
	4tq9Wz3s6nhum8FdfbYZcZtZXu7Q6n5fyLba6GJDwemnP1DFbnYwYQdeDgEqDh9adFPLU0rfPKDau
	Sa5HcWTRybFs0v/wjnzdg2wzjLzBg9Nt7yUhYO1ZFiwFO7cx0hlx2VSZoxAU25trPwH6dhYNnJRwV
	1HqDlHoWpMpRWmHb+hhBqR0uNuXlP1NhvgicqvXJ4naKBBxQJskKyskhEkxOAHFFNyMcVsIq+OKBt
	aWNNFNwIdPaYg7kTjCmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6pfV-005IGv-0e;
	Wed, 07 Jun 2023 09:41:29 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6pfS-005IFb-2M
	for linux-um@lists.infradead.org;
	Wed, 07 Jun 2023 09:41:27 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5169f614977so595473a12.3
        for <linux-um@lists.infradead.org>; Wed, 07 Jun 2023 02:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1686130883; x=1688722883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hFPeu/3BJQ1XAEBfX/WbvMEVzeUhOBPi58IZ/Esj6w=;
        b=DQ2W7u0kTQ72LzKcRWTgSG5Ic2en/sUZGdoBco91l0Mccvv0oAQBf/skoCqaEe9seE
         +dzp3Di1fk566WbDYFELqWJPFl5MunPBPZMeITsSShGZc7BDokFlIiDQLZFB4ZrSewGv
         3oX0GYhrvTDmISog+YzCJR1YtaZTCauUpfCjvwOk/JH+2E22rzqjqm0VAxXGE6uAZmC+
         EGD5OJ0fSz21kp9IqsqErfAtnLdYe5oeRENAmZus9bszHTyvCXJZvWktYhQnQZuZ89iJ
         k32HqmMpJwKqRO7v+RyJDkZmScyggr+L8hspyToZJsfDu3VkwGwgCJBAnl1PESLHhwEf
         au/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686130883; x=1688722883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hFPeu/3BJQ1XAEBfX/WbvMEVzeUhOBPi58IZ/Esj6w=;
        b=NhDAZ/D/LdkJwzlq26/OvWy4Vc7vRWrAfbxTNF1AaOhQIron+7u9U5rcMxJcrN7Ojq
         xAcogJkikE9kgYrcO5V9RckGV11OUcYWef826Sm3HcChoZMPtirEQgdAT1JIu00auP6E
         t68hubH7UNW01YSIOBzKewX2KxZKXk8WqzDbU+vKVNmWgxt9Wr6bv2uSkrYWTQg/byK5
         IdJxeLwXZSamh73DnNnTfQYyIj87gjtVyO/iqxXEOU9JDPO6t2VKDduHl9QaJFP8QI7R
         cPWf0ibkLsVW19F4i7Acuo/k3UoEDSXguRopl/XNTaZ3uOJH88wGOb+S7Jd8hCi8FSTB
         uD4A==
X-Gm-Message-State: AC+VfDztuGHEl78i2J3qEctTN8AfP8RT4PjYDHPw0fUOy1XcaSXOa6tA
	01mdqUi/RA+hqNNyiiKGTEZgNrbJ49qENRqPtPYe7Q==
X-Google-Smtp-Source: ACHHUZ78LLb5/9Eve9DZQqNC/TRa3vxkXV4pVMAtKfHjnQnscHPEcmWv/7uCCN4Q8kcsT8KuG+XDWcwCZO/ggZjCnJk=
X-Received: by 2002:a17:907:2d8c:b0:94e:e97b:c65 with SMTP id
 gt12-20020a1709072d8c00b0094ee97b0c65mr5404803ejc.60.1686130883637; Wed, 07
 Jun 2023 02:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-11-hch@lst.de>
In-Reply-To: <20230606073950.225178-11-hch@lst.de>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 7 Jun 2023 11:41:12 +0200
Message-ID: <CAMGffEkqXCkxpA+qqDVfx0echCPvNpWgK3hZWbb11F6cv2EQ-A@mail.gmail.com>
Subject: Re: [PATCH 10/31] block: remove the unused mode argument to ->release
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
X-CRM114-CacheID: sfid-20230607_024126_769355_EB09D476 
X-CRM114-Status: GOOD (  11.26  )
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
c3QuZGU+IHdyb3RlOgo+Cj4gVGhlIG1vZGUgYXJndW1lbnQgdG8gdGhlIC0+cmVsZWFzZSBibG9j
a19kZXZpY2Vfb3BlcmF0aW9uIGlzIG5ldmVyIHVzZWQsCj4gc28gcmVtb3ZlIGl0Lgo+Cj4gU2ln
bmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Cj4gLS0tCj4gIGFyY2gv
dW0vZHJpdmVycy91YmRfa2Vybi5jICAgICAgICAgIHwgIDQgKystLQo+ICBhcmNoL3h0ZW5zYS9w
bGF0Zm9ybXMvaXNzL3NpbWRpc2suYyB8ICAyICstCj4gIGJsb2NrL2JkZXYuYyAgICAgICAgICAg
ICAgICAgICAgICAgIHwgMTQgKysrKysrKy0tLS0tLS0KPiAgZHJpdmVycy9ibG9jay9hbWlmbG9w
LmMgICAgICAgICAgICAgfCAgMiArLQo+ICBkcml2ZXJzL2Jsb2NrL2FvZS9hb2VibGsuYyAgICAg
ICAgICB8ICAyICstCj4gIGRyaXZlcnMvYmxvY2svYXRhZmxvcC5jICAgICAgICAgICAgIHwgIDQg
KystLQo+ICBkcml2ZXJzL2Jsb2NrL2RyYmQvZHJiZF9tYWluLmMgICAgICB8ICA0ICsrLS0KPiAg
ZHJpdmVycy9ibG9jay9mbG9wcHkuYyAgICAgICAgICAgICAgfCAgMiArLQo+ICBkcml2ZXJzL2Js
b2NrL2xvb3AuYyAgICAgICAgICAgICAgICB8ICAyICstCj4gIGRyaXZlcnMvYmxvY2svbmJkLmMg
ICAgICAgICAgICAgICAgIHwgIDIgKy0KPiAgZHJpdmVycy9ibG9jay9wa3RjZHZkLmMgICAgICAg
ICAgICAgfCAgNCArKy0tCj4gIGRyaXZlcnMvYmxvY2svcmJkLmMgICAgICAgICAgICAgICAgIHwg
IDIgKy0KPiAgZHJpdmVycy9ibG9jay9ybmJkL3JuYmQtY2x0LmMgICAgICAgfCAgMiArLQpBY2tl
ZC1ieTogSmFjayBXYW5nIDxqaW5wdS53YW5nQGlvbm9zLmNvbT4gIyBmb3Igcm5iZAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGlu
ZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
