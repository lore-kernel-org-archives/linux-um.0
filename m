Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97A9C77B7A
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 09:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h8lSSLMTTot187x11daQxIIj4MVr+b9+fZW5yn2Q2TM=; b=vZ/qHSaf6bQ4+N
	mLKIlQByzhIax5Sgvyluy6P1VN7f+rpCEwFfLCP3vowix1LeW9JFZJubElG0EiTnA53CAUw1+GOX1
	+CGwEhzCRlU5eRh923vGdkb5gghTLVdCj/6tWF012vOVUOqDSjsOKj/ul0aPTTPJydaOaprt3xE4y
	I9yoaMp40jrbZZ7gq/5VNxG02iVDhn1MRlR6s5jUnM8z4aAq2xuN2wF8kLB0GNFr0yllSHFIvnUwZ
	1CJtMGDZaVcmPUYexpt1GA7OQ6MShIZD8RoHGcARaraQwr9kdsxU8VDW7BRSMBdjuePHs5yp7G6M9
	k+ZPI5usPbiCMDUKGbLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6pgs-005Inb-2X;
	Wed, 07 Jun 2023 09:42:54 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6pgq-005Im4-1j
	for linux-um@lists.infradead.org;
	Wed, 07 Jun 2023 09:42:53 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51491b87565so1176258a12.1
        for <linux-um@lists.infradead.org>; Wed, 07 Jun 2023 02:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1686130971; x=1688722971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTSJC08M16dk7ac+qC1NLiFtaB9M/5yyS+Z15P92ssA=;
        b=T8ER5TNAg8z1wij3zxfOUWFCDItlghCiuUXhsaqzc4ZwLofamB8RtpTyQLSVJ9h2UJ
         K5p37hopSMXQsov3IbM/+pXTCPYzGIBfMzkaAwZATA27zGzqc2RsatdEeeSYzb8OJe7S
         EtKjbCR7ypq1BPl33V5iDYjnSNzEbZ8SSmlT2bsu8chvDUII0Eyuhqg1weJGkPNF54UA
         at62NLYWJFIfELcet832L35oN/vTBLLRmhbv4E6euKkZT5GIkiCfz/SvQVjjr0TSQFn4
         eMDgRORV7ULS7YCAm2XXby1mXqhN+JgUeFWJ6iq0dvTYt+w3IowjHJDt6ezXaXQ0V0f7
         BdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686130971; x=1688722971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTSJC08M16dk7ac+qC1NLiFtaB9M/5yyS+Z15P92ssA=;
        b=XFyf4MNQqO7ydY8m0bbf+xIfSTTmTZUrn52cPfudRWuPrVsSUBg6VFtjFXYw8i2t/7
         jv0whCw2dk2iVHmzzfN9RyU+DAios1mgbTyEg0sRoVUFDOLbS2ILtJs5itCml2ZiRtbT
         Wz9WiSODCcsLo/ssguxRCsJK4YtGZbgqTaU02WZuqXvctVmTvLKUBV4c5q2ruAlot4JC
         6HmHvsvwKCRmyLnyPGCIei5n11/2yE+MsTMY9D6GKNnUseQQyQzdFWP8hGRSMDJ3NQTR
         ZIsETkSakuki74ttRj38qpsm0zgYCU8g9ZqrFhJHFBLhByxaiKD0glpudXrU6kyAO7z/
         IsWQ==
X-Gm-Message-State: AC+VfDy+ansp54wI5TeH9LYwI1g9rn0yDtwtWlnB7d8Tf4oDeoxjNRRn
	ByfIpWQE7c42GGwST+nIXE3q0RsigS5K73EQR0eQpw==
X-Google-Smtp-Source: ACHHUZ5i8f5AUVXLioiA4Msh4foVuVuox1MKnFKi4fucw3rKEDDzkk1m6bVkvWRpki6Lz1RgGXGnv70bM2LGvyL4BxY=
X-Received: by 2002:aa7:cd55:0:b0:514:8e6f:7113 with SMTP id
 v21-20020aa7cd55000000b005148e6f7113mr3506396edw.22.1686130971195; Wed, 07
 Jun 2023 02:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-10-hch@lst.de>
In-Reply-To: <20230606073950.225178-10-hch@lst.de>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 7 Jun 2023 11:42:40 +0200
Message-ID: <CAMGffEkKpHzatfeJhKtJQMTNckJGc7sJQ_LWFg-KvazvOD4DWw@mail.gmail.com>
Subject: Re: [PATCH 09/31] block: pass a gendisk to ->open
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
X-CRM114-CacheID: sfid-20230607_024252_571968_5CF827B8 
X-CRM114-Status: GOOD (  11.63  )
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
c3QuZGU+IHdyb3RlOgo+Cj4gLT5vcGVuIGlzIG9ubHkgY2FsbGVkIG9uIHRoZSB3aG9sZSBkZXZp
Y2UuICBNYWtlIHRoYXQgZXhwbGljaXQgYnkKPiBwYXNzaW5nIGEgZ2VuZGlzayBpbnN0ZWFkIG9m
IHRoZSBibG9ja19kZXZpY2UuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8
aGNoQGxzdC5kZT4KPiAtLS0KPiAgYXJjaC91bS9kcml2ZXJzL3ViZF9rZXJuLmMgICAgICAgICAg
fCAgNSArKy0tLQo+ICBhcmNoL3h0ZW5zYS9wbGF0Zm9ybXMvaXNzL3NpbWRpc2suYyB8ICA0ICsr
LS0KPiAgYmxvY2svYmRldi5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQo+ICBkcml2
ZXJzL2Jsb2NrL2FtaWZsb3AuYyAgICAgICAgICAgICB8ICA4ICsrKystLS0tCj4gIGRyaXZlcnMv
YmxvY2svYW9lL2FvZWJsay5jICAgICAgICAgIHwgIDQgKystLQo+ICBkcml2ZXJzL2Jsb2NrL2F0
YWZsb3AuYyAgICAgICAgICAgICB8IDE2ICsrKysrKystLS0tLS0tLQo+ICBkcml2ZXJzL2Jsb2Nr
L2RyYmQvZHJiZF9tYWluLmMgICAgICB8ICA2ICsrKy0tLQo+ICBkcml2ZXJzL2Jsb2NrL2Zsb3Bw
eS5jICAgICAgICAgICAgICB8IDMwICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCj4gIGRy
aXZlcnMvYmxvY2svbmJkLmMgICAgICAgICAgICAgICAgIHwgIDggKysrKy0tLS0KPiAgZHJpdmVy
cy9ibG9jay9wa3RjZHZkLmMgICAgICAgICAgICAgfCAgNiArKystLS0KPiAgZHJpdmVycy9ibG9j
ay9yYmQuYyAgICAgICAgICAgICAgICAgfCAgNCArKy0tCj4gIGRyaXZlcnMvYmxvY2svcm5iZC9y
bmJkLWNsdC5jICAgICAgIHwgIDQgKystLQpBY2tlZC1ieTogSmFjayBXYW5nIDxqaW5wdS53YW5n
QGlvbm9zLmNvbT4gIyBmb3Igcm5iZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC11bQo=
