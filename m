Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FF6C7EE2E
	for <linux-um@archiver.kernel.org>; Sat, 10 Jun 2023 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cneDs3sdWNOnk5+iHQcEFb1KXNbHUnfxrIbLrVuivWY=; b=RlOtTA5XQJmMpa
	pMTlHi9Yirwf9F+pDwX14sESwXnXo88fKMDXGE50yxopp46e/AyzILI8N3c7GCfU20XMAMOUs+ohd
	npl68i2ZuUgkhhSLGWRUnM4+wExx4Ks6k7qlLWBq/KgiVLDgMmc6WI7Ci1L/XveuVMTXK7gwncR4r
	whqP1s8Cf+Sv7/o76Wq1WXORondzozpE8MjjzwE+YRfdxKDv+3+XRFhzvXcDX81kZ8x/uXvVhH8E9
	xPuzvUYhCguiz44083Fz948fasLsbU2LgZ96jtbolrwGg/H7W9gU8yVTOk/NmiB4am1NIGPl2G9ld
	Vn33pn81bCAexRdD4vPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7uPL-00FajA-1U;
	Sat, 10 Jun 2023 08:57:15 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7uPJ-00Fai4-1h
	for linux-um@lists.infradead.org;
	Sat, 10 Jun 2023 08:57:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CC03060F56
	for <linux-um@lists.infradead.org>; Sat, 10 Jun 2023 08:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF18C433A0
	for <linux-um@lists.infradead.org>; Sat, 10 Jun 2023 08:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686387419;
	bh=Iee+wypTexQUR8K2T7uMz0+4RhthbX1msBu1bBQDFD4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tmI+uD684n12jhr1gJvdv1lzVx+1kzV9/wjIrBYQYAhNHNhnFSWhuStvVoqawNSE2
	 Pu7/jDE/P8YbbaUVHhESPG5uJvfDmAyCh+dmgL5LeuMjjistVEaDbJQWbXeNEafxbl
	 d4uDmqf9vM6QQeR1TirlavuXcbpV9fORi4PwFolfm1MWEYp8FR9ii3DP+WIsYeSJX9
	 5J7/NvKro6ada38cS3UbKICBkQuUmYWM7EYDOuz7p/Evp5+Abh01aqavNgPpNBze7N
	 FLSJk94PV2A4kezMAZwIqweP9+S3bYvue3rboJcMug6p3DkeQkSs/vJkS0d5vL+QDE
	 iDMqSDkIDY4Sg==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-39ab96e6aefso1180822b6e.1
        for <linux-um@lists.infradead.org>; Sat, 10 Jun 2023 01:56:59 -0700 (PDT)
X-Gm-Message-State: AC+VfDzJnIzHF9DYD4+dR2vvOyvaIlcXe1JNRiC6N2iDET6WoxALINE7
	0rZOKfRoQAHoLw5vXYhD2zBQYxhkTD4ISWzDFIA=
X-Google-Smtp-Source: ACHHUZ45B9+vJu0Lfsj9S9kDUxsN76ThLC0nxg1vRtcpilnc8du/wMOz5B2KLxi2xKZM6nJKmyX/LNJ2HwyK2ORMZ9U=
X-Received: by 2002:a05:6808:1b1f:b0:398:9fa:655e with SMTP id
 bx31-20020a0568081b1f00b0039809fa655emr729889oib.31.1686387418474; Sat, 10
 Jun 2023 01:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230608142428.256985-1-masahiroy@kernel.org> <20230608142428.256985-4-masahiroy@kernel.org>
In-Reply-To: <20230608142428.256985-4-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 10 Jun 2023 17:56:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQfqXU+MFucqsaQmKALgz1f909G0+6ycEUd6+kgeiv2ww@mail.gmail.com>
Message-ID: <CAK7LNAQfqXU+MFucqsaQmKALgz1f909G0+6ycEUd6+kgeiv2ww@mail.gmail.com>
Subject: Re: [PATCH v7 03/11] kbuild: generate KSYMTAB entries by modpost
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	linux-um@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230610_015713_629386_C00AE5B4 
X-CRM114-Status: GOOD (  13.17  )
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

T24gVGh1LCBKdW4gOCwgMjAyMyBhdCAxMToyNOKAr1BNIE1hc2FoaXJvIFlhbWFkYSA8bWFzYWhp
cm95QGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4gQ29tbWl0IDdiNDUzNzE5OWE0YSAoImtidWlsZDog
bGluayBzeW1ib2wgQ1JDcyBhdCBmaW5hbCBsaW5rLCByZW1vdmluZwo+IENPTkZJR19NT0RVTEVf
UkVMX0NSQ1MiKSBtYWRlIG1vZHBvc3Qgb3V0cHV0IENSQ3MgaW4gdGhlIHNhbWUgd2F5Cj4gd2hl
dGhlciB0aGUgRVhQT1JUX1NZTUJPTCgpIGlzIHBsYWNlZCBpbiAqLmMgb3IgKi5TLgo+Cj4gRm9y
IGZ1cnRoZXIgY2xlYW51cHMsIHRoaXMgY29tbWl0IGFwcGxpZXMgYSBzaW1pbGFyIGFwcHJvYWNo
IHRvIHRoZQo+IGVudGlyZSBkYXRhIHN0cnVjdHVyZSBvZiBFWFBPUlRfU1lNQk9MKCkuCj4KPiBU
aGUgRVhQT1JUX1NZTUJPTCgpIGNvbXBpbGF0aW9uIGlzIHNwbGl0IGludG8gdHdvIHN0YWdlcy4K
Pgo+IFdoZW4gYSBzb3VyY2UgZmlsZSBpcyBjb21waWxlZCwgRVhQT1JUX1NZTUJPTCgpIGlzIGNv
bnZlcnRlZCBpbnRvIGEKPiBkdW1teSBzeW1ib2wgaW4gdGhlIC5leHBvcnRfc3ltYm9sIHNlY3Rp
b24uCj4KPiBGb3IgZXhhbXBsZSwKPgo+ICAgICBFWFBPUlRfU1lNQk9MKGZvbyk7Cj4gICAgIEVY
UE9SVF9TWU1CT0xfTlNfR1BMKGJhciwgQkFSX05BTUVTUEFDRSk7Cj4KPiB3aWxsIGJlIGVuY29k
ZWQgaW50byB0aGUgZm9sbG93aW5nIGFzc2VtYmx5IGNvZGU6Cj4KPiAgICAgLnNlY3Rpb24gIi5l
eHBvcnRfc3ltYm9sIiwiYSIKPiAgICAgX19leHBvcnRfc3ltYm9sX19mb286Cj4gICAgICAgICAg
ICAgLmFzY2l6ICIiCj4gICAgICAgICAgICAgLmJhbGlnbiA0Cj4gICAgICAgICAgICAgLmxvbmcg
Zm9vIC0gLgoKCkkgaG9wZSB0aGlzIHdpbGwgd29yayBmb3IgYWxsIGFyY2hlcywgYnV0CnVuZm9y
dHVuYXRlbHksIHRoZSAwZGF5IGJvdCByZXBvcnRlZCBicmVha2FnZXMKb24geHRlbnNhLgoKSSB3
aWxsIHJlc3RvcmUgdGhlIGNvZGUgaW4gdjYuCgoKCgoKCgotLSAKQmVzdCBSZWdhcmRzCk1hc2Fo
aXJvIFlhbWFkYQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
