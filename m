Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DDCC7EE25
	for <linux-um@archiver.kernel.org>; Fri,  9 Jun 2023 21:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5S4fTwciXHndszs9yoCZimP363IWjhSl2T1rmPSROic=; b=nxvStwp9js/zTf
	2e6VXGoh3sQF2Hdy+fD+trw6stVUucqFq24ierEOUnJAXj5Pe82IQXf3gNaDFej5SMxZqXNsi5xQ+
	fQk5oAZlnam5tn0q8iUC99xh72oQYe4EBnEaMpHLuVuKcquutmYWOJvHdAwBQGX5hxb9NIlHe48ut
	bEb+WkwwSY3EyosasfNl7lPzA9IhgkHvfBO7pYuh+qnEoXumGxgu7eggTCNAA6sWsZRa0gnzXhyVz
	OtXjunKPqclZWTza6/Nhdt0D+1qGJfyL+/tUqyptQCkEKhYJLFIo4ejh2nUfWlanM7Q/r7+ZlXyhM
	zQnLeVfK46nKFIs1AzRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7jkc-00EJyj-2D;
	Fri, 09 Jun 2023 21:34:30 +0000
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7jkY-00EJxi-2t
	for linux-um@lists.infradead.org;
	Fri, 09 Jun 2023 21:34:29 +0000
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-786de394130so683277241.2
        for <linux-um@lists.infradead.org>; Fri, 09 Jun 2023 14:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686346463; x=1688938463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FN7hLjtGJs/FHfbPpMcVi+yulUaow7LlgvAA4nlJ4w=;
        b=nEu1dhFS/KtCJDrV9IiJxcofM8hEfF4Yh5M0CT2zPHVw9p7uUR+7X/q+mO6or7fg13
         4t7MKvtxOxBkMp5q/90V9gqNpWv1osewkly9NgAjG5a1ItSAmVgHV2n8YVrtPhcAXD5q
         72F1aUSJMkn/Y3AVYE285NL+5fLG8+LsviR916j9pE1rH3qij9/lZz9WPTdYRMAnq2fW
         hZ/LW+QC9IpHjVAUBIDkxh+GVJE1iZIVL97D09Giiu602q/C0/4cadJhK2FD9464X0US
         ulBD/w4ikCH5vDRva0aLIgzmVPlCcwcYDJvwosSoZyyd1JtOdRWNUxvMdNWGMFqZRzcz
         2mQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686346463; x=1688938463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FN7hLjtGJs/FHfbPpMcVi+yulUaow7LlgvAA4nlJ4w=;
        b=B441Kj+7kNFT3oWnmUDa3MEuGHkvEowAfIIrIDouNPOtML/sEf2Mku3fyFrEokQ6uS
         +3fjFXZzMDEfur6PvIaxT23whOVVSsUbig6MDkFg8yPvlTvyDjZ7y6DIMqr251X2SP5D
         DH1Nh9lNbCUhSWv7KOF0dseUTFGKc+VdwpiO8CP4YWzagyPbbyT6vQ68RK2Wq+02/AaN
         1Un5s4xBo9c0ayykzzx8pAD6DohwFQrOyzEKwZbG7nfvBwRYSRI4qdHofxgUZ08qk7Tm
         7JM1HPT5s5ikt/l1X4lHTPhaauRvbrK3/TzLJ7rFx4YtqOkJ/s19MAjBL+GdGFSX2SEq
         +AYQ==
X-Gm-Message-State: AC+VfDyPKNwjhZYftc+BpYKg6F1VH1W4RwmOqNBunSXswQ2IOP8zgwlw
	P/R69ORjyakCCMiWlR2KfcmKewuStIvm/1oSItLR/A==
X-Google-Smtp-Source: ACHHUZ5dZIj+NcWZhmKd0sqgT54E3562rWqntSqlVozz38btjF3YrZvwyqmTlR6qel9ulhipKI5BX2tu1ca7p0SoSoA=
X-Received: by 2002:a67:b408:0:b0:43b:402c:adfa with SMTP id
 x8-20020a67b408000000b0043b402cadfamr1046504vsl.19.1686346462660; Fri, 09 Jun
 2023 14:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230608142428.256985-1-masahiroy@kernel.org> <20230608142428.256985-12-masahiroy@kernel.org>
In-Reply-To: <20230608142428.256985-12-masahiroy@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 9 Jun 2023 14:29:05 -0700
Message-ID: <CAKwvOdkZUmfUtO=uL9JgoJjeto28HNCQ-i7FT1Oy_C+mtNz-Dg@mail.gmail.com>
Subject: Re: [PATCH v7 11/11] linux/export.h: rename 'sec' argument to 'license'
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-um@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_143427_066554_EEDE18CC 
X-CRM114-Status: GOOD (  17.56  )
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

T24gVGh1LCBKdW4gOCwgMjAyMyBhdCA3OjI04oCvQU0gTWFzYWhpcm8gWWFtYWRhIDxtYXNhaGly
b3lAa2VybmVsLm9yZz4gd3JvdGU6Cj4KPiBOb3csIEVYUE9SVF9TWU1CT0woKSBpcyBwb3B1bGF0
ZWQgaW4gdHdvIHN0YWdlcy4gSW4gdGhlIGZpcnN0IHN0YWdlLAo+IGFsbCBvZiBFWFBPUlRfU1lN
Qk9ML0VYUE9SVF9TWU1CT0xfR1BMIGdvIGludG8gdGhlIHNhbWUgc2VjdGlvbiwKPiAuZXhwb3J0
X3N5bWJvbC4KPgo+ICdzZWMnIGRvZXMgbm90IG1ha2Ugc2Vuc2UgYW55IG1vcmUuIFJlbmFtZSBp
dCB0byAnbGljZW5zZScuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNYXNhaGlybyBZYW1hZGEgPG1hc2Fo
aXJveUBrZXJuZWwub3JnPgoKVGhhbmtzIGZvciB0aGUgcGF0Y2ghClJldmlld2VkLWJ5OiBOaWNr
IERlc2F1bG5pZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbT4KCj4gLS0tCj4KPiBDaGFuZ2Vz
IGluIHY3Ogo+ICAtIE5ldyBwYXRjaAo+Cj4gIGluY2x1ZGUvbGludXgvZXhwb3J0LmggfCA4ICsr
KystLS0tCj4gIGluY2x1ZGUvbGludXgvcG0uaCAgICAgfCA2ICsrKy0tLQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L2V4cG9ydC5oIGIvaW5jbHVkZS9saW51eC9leHBvcnQuaAo+IGluZGV4IGZl
ZDJlNTcxNzQ2MS4uYjQxMWZkYjg4NzIwIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvZXhw
b3J0LmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L2V4cG9ydC5oCj4gQEAgLTQ2LDExICs0NiwxMSBA
QCBleHRlcm4gc3RydWN0IG1vZHVsZSBfX3RoaXNfbW9kdWxlOwo+ICAgKiBiZSByZXVzZWQgaW4g
b3RoZXIgZXhlY3V0aW9uIGNvbnRleHRzIHN1Y2ggYXMgdGhlIFVFRkkgc3R1YiBvciB0aGUKPiAg
ICogZGVjb21wcmVzc29yLgo+ICAgKi8KPiAtI2RlZmluZSBfX0VYUE9SVF9TWU1CT0woc3ltLCBz
ZWMsIG5zKQo+ICsjZGVmaW5lIF9fRVhQT1JUX1NZTUJPTChzeW0sIGxpY2Vuc2UsIG5zKQo+Cj4g
ICNlbGlmIGRlZmluZWQoX19HRU5LU1lNU19fKQo+Cj4gLSNkZWZpbmUgX19FWFBPUlRfU1lNQk9M
KHN5bSwgc2VjLCBucykgIF9fR0VOS1NZTVNfRVhQT1JUX1NZTUJPTChzeW0pCj4gKyNkZWZpbmUg
X19FWFBPUlRfU1lNQk9MKHN5bSwgbGljZW5zZSwgbnMpICAgICAgX19HRU5LU1lNU19FWFBPUlRf
U1lNQk9MKHN5bSkKPgo+ICAjZWxpZiBkZWZpbmVkKF9fQVNTRU1CTFlfXykKPgo+IEBAIC02Nyw5
ICs2Nyw5IEBAIGV4dGVybiBzdHJ1Y3QgbW9kdWxlIF9fdGhpc19tb2R1bGU7Cj4gICNlbmRpZiAv
KiBDT05GSUdfTU9EVUxFUyAqLwo+Cj4gICNpZmRlZiBERUZBVUxUX1NZTUJPTF9OQU1FU1BBQ0UK
PiAtI2RlZmluZSBfRVhQT1JUX1NZTUJPTChzeW0sIHNlYykgICAgICAgX19FWFBPUlRfU1lNQk9M
KHN5bSwgc2VjLCBfX3N0cmluZ2lmeShERUZBVUxUX1NZTUJPTF9OQU1FU1BBQ0UpKQo+ICsjZGVm
aW5lIF9FWFBPUlRfU1lNQk9MKHN5bSwgbGljZW5zZSkgICBfX0VYUE9SVF9TWU1CT0woc3ltLCBs
aWNlbnNlLCBfX3N0cmluZ2lmeShERUZBVUxUX1NZTUJPTF9OQU1FU1BBQ0UpKQo+ICAjZWxzZQo+
IC0jZGVmaW5lIF9FWFBPUlRfU1lNQk9MKHN5bSwgc2VjKSAgICAgICBfX0VYUE9SVF9TWU1CT0wo
c3ltLCBzZWMsICIiKQo+ICsjZGVmaW5lIF9FWFBPUlRfU1lNQk9MKHN5bSwgbGljZW5zZSkgICBf
X0VYUE9SVF9TWU1CT0woc3ltLCBsaWNlbnNlLCAiIikKPiAgI2VuZGlmCj4KPiAgI2RlZmluZSBF
WFBPUlRfU1lNQk9MKHN5bSkgICAgICAgICAgICAgX0VYUE9SVF9TWU1CT0woc3ltLCkKPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wbS5oIGIvaW5jbHVkZS9saW51eC9wbS5oCj4gaW5kZXgg
YWFiYjZiZDhmODllLi4xODEwZDc3NmU4NGEgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9w
bS5oCj4gKysrIGIvaW5jbHVkZS9saW51eC9wbS5oCj4gQEAgLTM3NSwxNCArMzc1LDE0IEBAIGNv
bnN0IHN0cnVjdCBkZXZfcG1fb3BzIG5hbWUgPSB7IFwKPiAgfQo+Cj4gICNpZmRlZiBDT05GSUdf
UE0KPiAtI2RlZmluZSBfRVhQT1JUX0RFVl9QTV9PUFMobmFtZSwgc2VjLCBucykgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBcCj4gKyNkZWZpbmUgX0VYUE9SVF9ERVZfUE1fT1BTKG5hbWUs
IGxpY2Vuc2UsIG5zKSAgICAgICAgICAgICAgICAgICAgICAgICAgXAo+ICAgICAgICAgY29uc3Qg
c3RydWN0IGRldl9wbV9vcHMgbmFtZTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFwKPiAtICAgICAgIF9fRVhQT1JUX1NZTUJPTChuYW1lLCBzZWMsIG5zKTsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBcCj4gKyAgICAgICBfX0VYUE9SVF9TWU1CT0wobmFtZSwgbGlj
ZW5zZSwgbnMpOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAo+ICAgICAgICAgY29uc3Qg
c3RydWN0IGRldl9wbV9vcHMgbmFtZQo+ICAjZGVmaW5lIEVYUE9SVF9QTV9GTl9HUEwobmFtZSkg
ICAgICAgICBFWFBPUlRfU1lNQk9MX0dQTChuYW1lKQo+ICAjZGVmaW5lIEVYUE9SVF9QTV9GTl9O
U19HUEwobmFtZSwgbnMpICBFWFBPUlRfU1lNQk9MX05TX0dQTChuYW1lLCBucykKPiAgI2Vsc2UK
PiAtI2RlZmluZSBfRVhQT1JUX0RFVl9QTV9PUFMobmFtZSwgc2VjLCBucykgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcCj4gKyNkZWZpbmUgX0VYUE9SVF9ERVZfUE1fT1BTKG5hbWUsIGxp
Y2Vuc2UsIG5zKSAgICAgICAgICAgICAgICAgICAgICAgICAgXAo+ICAgICAgICAgc3RhdGljIF9f
bWF5YmVfdW51c2VkIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIF9fc3RhdGljXyMjbmFtZQo+ICAj
ZGVmaW5lIEVYUE9SVF9QTV9GTl9HUEwobmFtZSkKPiAgI2RlZmluZSBFWFBPUlRfUE1fRk5fTlNf
R1BMKG5hbWUsIG5zKQo+IC0tCj4gMi4zOS4yCj4KCgotLSAKVGhhbmtzLAp+TmljayBEZXNhdWxu
aWVycwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
