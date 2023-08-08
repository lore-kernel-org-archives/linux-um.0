Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A794C41513
	for <linux-um@archiver.kernel.org>; Tue,  8 Aug 2023 17:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1vKbnGDZNfHIGz7sUvesjWzjHHiDC+ux3F2RfLm3Ee0=; b=etA67cRNXheJf1
	fgsLgf35Q01q4H0N8aTqCy6CUBus7KPBaA2klum3JhDZKJhYu4GTqwq0Uf52MlVBVroKNA2qF81in
	Vy3KBfcR4rVQlWqAxPIZ09RG3qpOckIjYc8A9DugonC3IbDK6I0Ptl6WYmXpi2PEt24MFz+uYSJ0Q
	zUTBaivRT//U1xo2w30mRhRg1rX8TSH5BisTm2TqRMOs/2zs1oXYZ1pxN1sSLeYjXZy1yQtnvVZV6
	w+eTYZE6I5Tyenal0z+wr/ESUQy2r0DbFj9iP7+MNGOTALefBCNuvPYduVpbpSnhyH/KbbGhN3ibv
	ul5LMW8Je4rTJF2CtTzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTQPm-0037HP-1a;
	Tue, 08 Aug 2023 17:22:38 +0000
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTQPj-0037Gm-1g
	for linux-um@lists.infradead.org;
	Tue, 08 Aug 2023 17:22:36 +0000
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7659cb9c42aso429724585a.3
        for <linux-um@lists.infradead.org>; Tue, 08 Aug 2023 10:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691515353; x=1692120153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QToAetuOKqk6KlcwFnxlW4pv9tJbYlRSUo8zVZOIBoo=;
        b=x3+okNrHxwteJVxE9P7xvlSvMXSMSfFQLXfreCFLO+KwUMB1ZcLkHHWvsw8C1crZfi
         94/Wv7lhK1/n5VulvtHVY0DXE3MdbInnralMazMsyNkQDLoupBzwQrKVvYxj5pWCPA2+
         WooLZaDnpKfes/b0/A19G1uhHVaDc6CtW3H8qRJQbZD/TSJWWVeoMtgCgplEmW8gs49P
         W3K3dooGHhgco6o69EVttAFhlfEznGqM92TBQQtIVdGvnekAS6qEq1nOM0ZLwHCthmHf
         2OSXnBlD1FDXktBAf9BSUKU7BeBPbN/XWswa9E1b+ewibdmiaCVyqIksW5wmwYo85QZt
         EFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515353; x=1692120153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QToAetuOKqk6KlcwFnxlW4pv9tJbYlRSUo8zVZOIBoo=;
        b=Ee2cE2BZsl7dgTA0QDAwy9r3aM4+O7Du7uB2ea3fHAVWy3VcLhHLyK1prRgSjC+pd/
         3XYfQWwxvAELRhrou+2gqg79CgqgbuL3qBb4Lb+kP5nR05KIcxqvOXb9gAOZ+QGC+7h0
         h1nvsInVOkHNpN0coJnxNJhzCgrEudqgzBV6ZsBPq96RCjPSoy/XgYkFZxsbMCNtaNnu
         OCfD1Giyj8kzbic1gOF4AAr/BZxXUS8+eyi7HMfzmWFMYsVuu1Oiw0KB5LZCw1no4nXx
         /1bWqnruGh45AsYXEWeQh2JDsJsm+RDMrLp4c9Ox87HfNrgePWvwxZ2edQId1rfi4daw
         2U4g==
X-Gm-Message-State: AOJu0YzPN7MFFKiCMGcIsC7u40VcRLKsWA5HtqGSKhP1ym4Jmm591Ep6
	Se9sFM6OEnJ4gBlE3boQ2PdL06ql94D3cArTEkJX2A==
X-Google-Smtp-Source: AGHT+IGx1Hvm8GzUNEC4qBxcvszi1ZgPs7hwI3gCJ7ARlCRyZ6+kA7nZ6709ZdZ9q/d5dH8ck5s7td3mHpji47CG91s=
X-Received: by 2002:a0c:cc03:0:b0:63f:7b35:6ad8 with SMTP id
 r3-20020a0ccc03000000b0063f7b356ad8mr88500qvk.23.1691515353160; Tue, 08 Aug
 2023 10:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230808-um_hostaudio-v1-1-3d40fbe1fb1e@google.com>
In-Reply-To: <20230808-um_hostaudio-v1-1-3d40fbe1fb1e@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 8 Aug 2023 10:22:21 -0700
Message-ID: <CAKwvOd=+GHvgFhZyWbZsR8+-Z0WzVAvncM-mhcycR1q244GykA@mail.gmail.com>
Subject: Re: [PATCH] uml: audio: fix -Wmissing-variable-declarations
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	kernel test robot <lkp@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_102235_574410_AF84B2EB 
X-CRM114-Status: GOOD (  20.41  )
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

T24gVHVlLCBBdWcgOCwgMjAyMyBhdCAxMDoyMeKAr0FNIE5pY2sgRGVzYXVsbmllcnMKPG5kZXNh
dWxuaWVyc0Bnb29nbGUuY29tPiB3cm90ZToKPgo+IEknbSBsb29raW5nIHRvIGVuYWJsZSAtV21p
c3NpbmctdmFyaWFibGUtZGVjbGFyYXRpb25zIGJlaGluZCBXPTEuIDBkYXkKPiBib3Qgc3BvdHRl
ZCB0aGUgZm9sbG93aW5nIGluc3RhbmNlOgo+Cj4gICBhcmNoL3VtL2RyaXZlcnMvaG9zdGF1ZGlv
X2tlcm4uYzozMTY6Mzogd2FybmluZzogbm8gcHJldmlvdXMgZXh0ZXJuCj4gICBkZWNsYXJhdGlv
biBmb3Igbm9uLXN0YXRpYyB2YXJpYWJsZSAnbW9kdWxlX2RhdGEnCj4gICBbLVdtaXNzaW5nLXZh
cmlhYmxlLWRlY2xhcmF0aW9uc10KPiAgIH0gbW9kdWxlX2RhdGE7Cj4gICAgIF4KPiAgIGFyY2gv
dW0vZHJpdmVycy9ob3N0YXVkaW9fa2Vybi5jOjMxMzoxOiBub3RlOiBkZWNsYXJlICdzdGF0aWMn
IGlmIHRoZQo+ICAgdmFyaWFibGUgaXMgbm90IGludGVuZGVkIHRvIGJlIHVzZWQgb3V0c2lkZSBv
ZiB0aGlzIHRyYW5zbGF0aW9uIHVuaXQKPiAgIHN0cnVjdCB7Cj4gICBeCj4KPiBUaGlzIHN5bWJv
bCBpcyBub3QgcmVmZXJlbmNlZCBieSBtb3JlIHRoYW4gb25lIHRyYW5zbGF0aW9uIHVuaXQsIHNv
IGdpdmUKPiBpdCBzdGF0aWMgc3RvcmFnZS4KPgo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCBy
b2JvdCA8bGtwQGludGVsLmNvbT4KPiBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xs
dm0vMjAyMzA4MDgxMDAwLnRUTDFFbFRyLWxrcEBpbnRlbC5jb20vCgpeIEQnb2gsIHdyb25nIHJl
cG9ydCwgdGhpcyBzaG91bGQgYmUKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGx2bS8yMDIzMDgw
ODEwNTAuc1pFdzRjUTUtbGtwQGludGVsLmNvbS8KUmVzZW5kaW5nLgoKPiBTaWduZWQtb2ZmLWJ5
OiBOaWNrIERlc2F1bG5pZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbT4KPiAtLS0KPiAgYXJj
aC91bS9kcml2ZXJzL2hvc3RhdWRpb19rZXJuLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2FyY2gvdW0vZHJp
dmVycy9ob3N0YXVkaW9fa2Vybi5jIGIvYXJjaC91bS9kcml2ZXJzL2hvc3RhdWRpb19rZXJuLmMK
PiBpbmRleCA1YjA2NGQzNjBjYjcuLmM0MmI3OTNiY2U2NSAxMDA2NDQKPiAtLS0gYS9hcmNoL3Vt
L2RyaXZlcnMvaG9zdGF1ZGlvX2tlcm4uYwo+ICsrKyBiL2FyY2gvdW0vZHJpdmVycy9ob3N0YXVk
aW9fa2Vybi5jCj4gQEAgLTMxMCw3ICszMTAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVf
b3BlcmF0aW9ucyBob3N0bWl4ZXJfZm9wcyA9IHsKPiAgICAgICAgIC5yZWxlYXNlICAgICAgICA9
IGhvc3RtaXhlcl9yZWxlYXNlLAo+ICB9Owo+Cj4gLXN0cnVjdCB7Cj4gK3N0YXRpYyBzdHJ1Y3Qg
ewo+ICAgICAgICAgaW50IGRldl9hdWRpbzsKPiAgICAgICAgIGludCBkZXZfbWl4ZXI7Cj4gIH0g
bW9kdWxlX2RhdGE7Cj4KPiAtLS0KPiBiYXNlLWNvbW1pdDogMTRmOTY0M2RjOTBhZGVhMDc0YTBm
ZmI3YTE3ZDMzN2VhZmM2YTVjYwo+IGNoYW5nZS1pZDogMjAyMzA4MDgtdW1faG9zdGF1ZGlvLTIx
ZDcyMDdkZWFlZAo+Cj4gQmVzdCByZWdhcmRzLAo+IC0tCj4gTmljayBEZXNhdWxuaWVycyA8bmRl
c2F1bG5pZXJzQGdvb2dsZS5jb20+Cj4KCgotLSAKVGhhbmtzLAp+TmljayBEZXNhdWxuaWVycwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0g
bWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
