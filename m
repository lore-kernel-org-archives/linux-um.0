Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BBFC77B7A
	for <linux-um@archiver.kernel.org>; Thu,  1 Jun 2023 07:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1EqrbVUbR1ovJEyl82vCM0iT6GKpJ0PmOo3Ws9Qm/xQ=; b=jcMQepEnKSual5
	oVzDsA1eBLqwIy+YWJ055CV80lh1ED6I/iFtJXvtgZwDDf0a+tgcBy7MjD5BxQmGcr2DXl/ZCxKVw
	mMpFda3fGCPXL7zlDY89PjvuGRU86PLs3KpuL785dbL9XYQp2L7GcXJ4x2kruKEJbtfc3cgUTkWhe
	tmdve5rs0yvDil0fqadGToVP3f4j/CD6ZfrCZO5NNOB/shlTQf3F/oTWHkAtC6aJAE3i5+L3DwRoO
	8Sy0/CMgTaI/jEiUMg/+kFduVnp+APY1bSPzj16YdLa2BBUGQydfOXeTSQ+E1dPKxVKQ7R3cVJTKG
	pKhAvY2NSYiZePcgWnhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4cbk-002KuP-0S;
	Thu, 01 Jun 2023 07:20:28 +0000
Received: from mail-qk1-f179.google.com ([209.85.222.179])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4cbg-002Krf-0G;
	Thu, 01 Jun 2023 07:20:25 +0000
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-75b08ceddd1so62511485a.1;
        Thu, 01 Jun 2023 00:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685604021; x=1688196021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uahBQ1+NZ4LtBmJlKuzSeHMKUQpvPqnHtI00z7d7Eg4=;
        b=RljyYdyLYSa6MWmMpPg65FhO7fg76/krgiiIDqGv/F9SfZvMKcRMybqDeZvmM+f6Le
         cSMSZ7B9OPQAdE+kMb3Ipyfg0AGuOwvTz/Bq1TjTQciM8n06KCiIoridWPakiGym1E2F
         PpdiV2zk2xHWdukumtkYWmFsawJumaChQo8ExFrjQRVI8r/Rn9IBDCDhuKjoWtVUnbbO
         7SZmeWWyYxyyZx2Ax/9gNlPwxVaMUYcmF8a/pq8pGaOsLhEbsxfhYif7u+Z5RkPsR3Rr
         KhPg5cYx8tnjZ3ID71JlGpaUkEc3vEjF7T8Xph2HWyX84Vo4csBsJ8CUMENkK9I/15Bu
         /NGw==
X-Gm-Message-State: AC+VfDyhw4qv4eolfufzGHKMZUvNlROL2mEWqrBprlL4kJMUfNIAftGH
	Kv61o92SHu5mOZ5hXMap2aJpOYVG6q5W0w==
X-Google-Smtp-Source: ACHHUZ483CvQQlA3jGnFpRKI4cWO6wqfs3d6EYidLf9ssOcpkAo04jYqRHKSSRv0LWNF99TH/7oNTg==
X-Received: by 2002:a05:620a:460d:b0:75b:23a0:dea9 with SMTP id br13-20020a05620a460d00b0075b23a0dea9mr10524020qkb.39.1685604020737;
        Thu, 01 Jun 2023 00:20:20 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id n63-20020a0de442000000b00545b02d4af5sm5381466ywe.48.2023.06.01.00.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 00:20:19 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-bad97da58adso549349276.1;
        Thu, 01 Jun 2023 00:20:18 -0700 (PDT)
X-Received: by 2002:a25:6891:0:b0:ba8:7122:2917 with SMTP id
 d139-20020a256891000000b00ba871222917mr10052062ybc.0.1685604018484; Thu, 01
 Jun 2023 00:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230531213032.25338-1-vishal.moola@gmail.com> <20230531213032.25338-31-vishal.moola@gmail.com>
In-Reply-To: <20230531213032.25338-31-vishal.moola@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Jun 2023 09:20:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU4t4ac_eCH0UaX9F+GQ5-9kYjB_=e+pSfTkxG=3b8DsA@mail.gmail.com>
Message-ID: <CAMuHMdU4t4ac_eCH0UaX9F+GQ5-9kYjB_=e+pSfTkxG=3b8DsA@mail.gmail.com>
Subject: Re: [PATCH v3 30/34] sh: Convert pte_free_tlb() to use ptdescs
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
	Yoshinori Sato <ysato@users.sourceforge.jp>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_002024_122541_60C38784 
X-CRM114-Status: GOOD (  14.13  )
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

T24gV2VkLCBNYXkgMzEsIDIwMjMgYXQgMTE6MzPigK9QTSBWaXNoYWwgTW9vbGEgKE9yYWNsZSkK
PHZpc2hhbC5tb29sYUBnbWFpbC5jb20+IHdyb3RlOgo+IFBhcnQgb2YgdGhlIGNvbnZlcnNpb25z
IHRvIHJlcGxhY2UgcGd0YWJsZSBjb25zdHJ1Y3Rvci9kZXN0cnVjdG9ycyB3aXRoCj4gcHRkZXNj
IGVxdWl2YWxlbnRzLiBBbHNvIGNsZWFucyB1cCBzb21lIHNwYWNpbmcgaXNzdWVzLgo+Cj4gU2ln
bmVkLW9mZi1ieTogVmlzaGFsIE1vb2xhIChPcmFjbGUpIDx2aXNoYWwubW9vbGFAZ21haWwuY29t
PgoKTEdUTSwgc28KUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNh
c0BnbGlkZXIuYmU+CgpHcntvZXRqZSxlZXRpbmd9cywKCiAgICAgICAgICAgICAgICAgICAgICAg
IEdlZXJ0CgotLSAKR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBi
ZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZwoKSW4gcGVyc29uYWwgY29udmVyc2F0
aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dAp3
aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9y
IHNvbWV0aGluZyBsaWtlIHRoYXQuCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0g
TGludXMgVG9ydmFsZHMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
