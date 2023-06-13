Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20988C7EE2E
	for <linux-um@archiver.kernel.org>; Tue, 13 Jun 2023 07:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dahRl1fJPQgKUsIykkTdkOTBYDnsP9fcz6khN8s2kCg=; b=OE63c++DLpfi13
	/3srnmogQtebaIZTJ13u0gTGaDCPtyTGFPTFbm3Hltd67YNiwS6jHXGURmeEclPWQ9p2WOfpXh7sQ
	JuDu5qTHicuUE9shAkpQ+3UYKDsbqCpmIM6mJdpGCh9kqiUOYFu0bVy5TsPOiJ+MrO/sVfrUtTgs/
	wQgkoXWNLhb1I4e1MUlNimwxDWdey34D30+wJVdnlU/Ssh1/HMsD/1TxFboxHREk8bJqyTB/C+K3p
	5WOSasBHf+igesn25w+NJ+b7DhKxfjR9kU/8mz1LdcgTnJGrOQDuH69D7j5WAnfCTUXkbzhmumGHf
	AgXqtu61uBI5j4vFibUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8ySp-007DOE-2G;
	Tue, 13 Jun 2023 07:29:15 +0000
Received: from mail-qt1-f178.google.com ([209.85.160.178])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8ySl-007DM1-1F;
	Tue, 13 Jun 2023 07:29:12 +0000
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-3f9df7eb837so6658881cf.2;
        Tue, 13 Jun 2023 00:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686641349; x=1689233349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKEzJjzBKla4S0x8jxwIAxVSx314J/aF9PC4BBXNBUc=;
        b=gr15ZMPxidCmvH/Z5KHqP8EpAOBodhg2opqJeYsVQv1T7iRGMnYkmlfi7/04JIC5lN
         82CyHNu124wKESr4QoRWqu4GT81QC2rykvO2UUqkgrHg3GZMvwmn7Qa0DgBUnXcGaMMK
         lu4HOOsrVQ6qDs69ghvzoql3UQw5EX2UlON+qjLgYNQZZizogYVxLre29XYIqthTgwSP
         b+HXMy+M52uFM0KoP8eh8XP+g5Qz/F9aq+p34MSfRzIqmQKs+eJ+QHMO97I7VryHJeKh
         +0XtBTewaxdtJVTBT/e7hB53Em2DRofZoh+ZKgUtmmHijjMtbtfp8jibRIOI8hns/kTu
         0jcg==
X-Gm-Message-State: AC+VfDwV0VYcLC5JO2aXQqgOPzLYJG9Rk8nsytNaO4EiL6gSng5W5h2Y
	sgiq8gm3ex/dOqzPHeBN81zpGHIMuYHAXQ==
X-Google-Smtp-Source: ACHHUZ74CdlSFGf5ZLxHxHXcd4aHLRQRVbklKCwPrbZSdrNGogXd0J5RRu+u+mryJS5gcKtG5g9w3Q==
X-Received: by 2002:ac8:5708:0:b0:3f9:e6ac:f352 with SMTP id 8-20020ac85708000000b003f9e6acf352mr11621093qtw.51.1686641349468;
        Tue, 13 Jun 2023 00:29:09 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id t12-20020a5b0dcc000000b00bb138b444dcsm2904851ybr.36.2023.06.13.00.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 00:29:08 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-56d1cb6a607so25707277b3.2;
        Tue, 13 Jun 2023 00:29:08 -0700 (PDT)
X-Received: by 2002:a0d:d611:0:b0:56d:ddc:cdbb with SMTP id
 y17-20020a0dd611000000b0056d0ddccdbbmr1077781ywd.25.1686641348561; Tue, 13
 Jun 2023 00:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230612210423.18611-1-vishal.moola@gmail.com> <20230612210423.18611-26-vishal.moola@gmail.com>
In-Reply-To: <20230612210423.18611-26-vishal.moola@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 13 Jun 2023 09:28:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUk2OM+j_j8XSkMxRnNqmKy3qwUA8Mq-RA+p+ByfY-+4g@mail.gmail.com>
Message-ID: <CAMuHMdUk2OM+j_j8XSkMxRnNqmKy3qwUA8Mq-RA+p+ByfY-+4g@mail.gmail.com>
Subject: Re: [PATCH v4 25/34] m68k: Convert various functions to use ptdescs
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org, 
	Hugh Dickins <hughd@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_002911_421915_FA73BBC0 
X-CRM114-Status: GOOD (  14.44  )
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

T24gTW9uLCBKdW4gMTIsIDIwMjMgYXQgMTE6MDXigK9QTSBWaXNoYWwgTW9vbGEgKE9yYWNsZSkK
PHZpc2hhbC5tb29sYUBnbWFpbC5jb20+IHdyb3RlOgo+IEFzIHBhcnQgb2YgdGhlIGNvbnZlcnNp
b25zIHRvIHJlcGxhY2UgcGd0YWJsZSBjb25zdHJ1Y3Rvci9kZXN0cnVjdG9ycyB3aXRoCj4gcHRk
ZXNjIGVxdWl2YWxlbnRzLCBjb252ZXJ0IHZhcmlvdXMgcGFnZSB0YWJsZSBmdW5jdGlvbnMgdG8g
dXNlIHB0ZGVzY3MuCj4KPiBTb21lIG9mIHRoZSBmdW5jdGlvbnMgdXNlIHRoZSAqZ2V0KnBhZ2Uq
KCkgaGVscGVyIGZ1bmN0aW9ucy4gQ29udmVydAo+IHRoZXNlIHRvIHVzZSBwYWdldGFibGVfYWxs
b2MoKSBhbmQgcHRkZXNjX2FkZHJlc3MoKSBpbnN0ZWFkIHRvIGhlbHAKPiBzdGFuZGFyZGl6ZSBw
YWdlIHRhYmxlcyBmdXJ0aGVyLgo+Cj4gU2lnbmVkLW9mZi1ieTogVmlzaGFsIE1vb2xhIChPcmFj
bGUpIDx2aXNoYWwubW9vbGFAZ21haWwuY29tPgoKQWNrZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZl
biA8Z2VlcnRAbGludXgtbTY4ay5vcmc+CgpHcntvZXRqZSxlZXRpbmd9cywKCiAgICAgICAgICAg
ICAgICAgICAgICAgIEdlZXJ0CgotLSAKR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90
cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZwoKSW4gcGVyc29u
YWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBo
YWNrZXIuIEJ1dAp3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInBy
b2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtdW0K
