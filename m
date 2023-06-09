Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9332C7EE43
	for <linux-um@archiver.kernel.org>; Fri,  9 Jun 2023 21:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DeMzgRoV2pAIxvb8kHwggDRo30ESEWx3gY8SZmQCcKw=; b=DwxiejKheABNvD
	L6lAdYMMuykLyZXhY8DOcjxWAR0pGhxeFWIopDsqZNUWJtKrt878l+dIXXjUOHffqgJ8qzA1bFeCO
	BYZ15ednhHS1BPbYfDAPJyMJul1ejU3rmgwViaFqbMzhNszlttOTsvU2WZrlYJofi6GRDDGxWp1Up
	Ms8256ESAzv+6LJw0+ogbAv6YSFF3PVyHHjU8xDeaJS7Cak+qNewPG/MpzbWZ1Cbw7hZBYI7t7FJj
	piKpI3vZuwZxYILBFr+Jmts/OQKj+5anB4zbXh6lRubcOzdNxELx2i/069z2M6aZ9IXILRe1JfNZ/
	ElQQTrePFK9Od9M63BgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7jdr-00EJDR-2I;
	Fri, 09 Jun 2023 21:27:31 +0000
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7jdo-00EJC7-2S
	for linux-um@lists.infradead.org;
	Fri, 09 Jun 2023 21:27:29 +0000
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-39ca0c2970aso638600b6e.3
        for <linux-um@lists.infradead.org>; Fri, 09 Jun 2023 14:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686346046; x=1688938046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79ZPKjidrQgRLDsSa7QpphQvIoGIPOgBv8OBV9Mr61s=;
        b=OmL+6fhI7tyv31jaIEJF48y0gvfk2e7g/YcVV/TchHMCLdNaYV2CzWK8kQuzD/dv/9
         rTU/i+ZudaE16UswrcKoUpeeGi0HUwFPVBnaSmKQJJOgVa3Eq8V+n13qwOa752MnSl2G
         nxSEwD1NWrt7mf//t+SmSBmJgTuVeV4gMU1migsjs0jZD+MD/nkUl4208EAkmiOfnr0o
         Pdk+OX2fGo1y9OhDkE4XlcZQatI4VjvMhgKaQB1qeRRUCtJwzQdeRdjYq8AuTXidJNg7
         oCxH6RjrmVM9T2O6vCylxuSqnorPvIGwyHfKmEZm3JLiWuPEakfE+DbsSrv+OlhDMV7Z
         9diA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686346046; x=1688938046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79ZPKjidrQgRLDsSa7QpphQvIoGIPOgBv8OBV9Mr61s=;
        b=KG4FwOg2ezBkbm2H69EdJPSUDkgDTXlfLyK8vvqEbHD+uk7rqVaQbnaEWm+xYajaI4
         s9zdJlpOt8FDIRYPc3gxr+cy9jkUU7WPdTFy1eVlWSVqZkUTD0aCSNejvsEk5/83LGsY
         SoRfOknchRj1Nd7OiPJW0TBwucRuOludZcH9kjLMxU0Dw558FbfTzIoC2L2XyBzhr1TM
         Pp73O3S4Wtzsdu3tLRsV+vsoXoqGPEY8Bmr+rEiwbEQTLb36gpgao9t0NeY6bSBXOKHN
         dpmLIlQliftduvhSA1ZwBA3isX+ZDQdjF6TLWD7Y/rx5Krn7QBi90BPZxT4jmgVvD8fj
         mGKg==
X-Gm-Message-State: AC+VfDworwv9LLNho+7+X+AJuZnhmXH6hXHbbONH+ir0S8c1IiuK/PG5
	xmyNghnWxqiXWkESUoHabMFMf0DKs+Eiv3NfeCnLnQ==
X-Google-Smtp-Source: ACHHUZ50Fx2ISvtOB/iuSEZqXAVM8l4sckFy6gt9/EnvPJel+X8zQgM7yZZYCTQwM1yl0Jrlq/5lb1VPEjdiLi0n0ec=
X-Received: by 2002:a05:6358:c519:b0:129:c7b0:27fb with SMTP id
 fb25-20020a056358c51900b00129c7b027fbmr2233226rwb.26.1686346046206; Fri, 09
 Jun 2023 14:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230608142428.256985-1-masahiroy@kernel.org> <20230608142428.256985-11-masahiroy@kernel.org>
In-Reply-To: <20230608142428.256985-11-masahiroy@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 9 Jun 2023 14:26:57 -0700
Message-ID: <CAKwvOdny3yGugmEUUK_Zm7WNUeKHZrCk+9j-svGi9URHZVpDng@mail.gmail.com>
Subject: Re: [PATCH v7 10/11] modpost: show offset from symbol for section
 mismatch warnings
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-um@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_142728_798507_0DDAEB65 
X-CRM114-Status: GOOD (  16.25  )
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
b3lAa2VybmVsLm9yZz4gd3JvdGU6Cj4KPiBDdXJyZW50bHksIG1vZHBvc3Qgb25seSBzaG93cyB0
aGUgc3ltYm9sIG5hbWVzIGFuZCBzZWN0aW9uIG5hbWVzLCBzbyBpdAo+IHJlcGVhdHMgdGhlIHNh
bWUgbWVzc2FnZSBpZiB0aGVyZSBhcmUgbXVsdGlwbGUgcmVsb2NhdGlvbnMgaW4gdGhlIHNhbWUK
PiBzeW1ib2wuIEl0IGlzIGNvbW1vbiB0aGUgcmVsb2NhdGlvbiBzcGFucyBhY3Jvc3MgbXVsdGlw
bGUgaW5zdHJ1Y3Rpb25zLgo+Cj4gSXQgaXMgYmV0dGVyIHRvIHNob3cgdGhlIG9mZnNldCBmcm9t
IHRoZSBzeW1ib2wuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJv
eUBrZXJuZWwub3JnPgoKVGhhbmtzIGZvciB0aGUgcGF0Y2ghClJldmlld2VkLWJ5OiBOaWNrIERl
c2F1bG5pZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xlLmNvbT4KCj4gLS0tCj4KPiAgc2NyaXB0cy9t
b2QvbW9kcG9zdC5jIHwgNCArKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9tb2QvbW9kcG9zdC5jIGIv
c2NyaXB0cy9tb2QvbW9kcG9zdC5jCj4gaW5kZXggODVkZjNmM2JhOWVlLi40MDk2N2VkODE2ZGYg
MTAwNjQ0Cj4gLS0tIGEvc2NyaXB0cy9tb2QvbW9kcG9zdC5jCj4gKysrIGIvc2NyaXB0cy9tb2Qv
bW9kcG9zdC5jCj4gQEAgLTExNDcsOCArMTE0Nyw4IEBAIHN0YXRpYyB2b2lkIGRlZmF1bHRfbWlz
bWF0Y2hfaGFuZGxlcihjb25zdCBjaGFyICptb2RuYW1lLCBzdHJ1Y3QgZWxmX2luZm8gKmVsZiwK
Pgo+ICAgICAgICAgc2VjX21pc21hdGNoX2NvdW50Kys7Cj4KPiAtICAgICAgIHdhcm4oIiVzOiBz
ZWN0aW9uIG1pc21hdGNoIGluIHJlZmVyZW5jZTogJXMgKHNlY3Rpb246ICVzKSAtPiAlcyAoc2Vj
dGlvbjogJXMpXG4iLAo+IC0gICAgICAgICAgICBtb2RuYW1lLCBmcm9tc3ltLCBmcm9tc2VjLCB0
b3N5bSwgdG9zZWMpOwo+ICsgICAgICAgd2FybigiJXM6IHNlY3Rpb24gbWlzbWF0Y2ggaW4gcmVm
ZXJlbmNlOiAlcysweCV4IChzZWN0aW9uOiAlcykgLT4gJXMgKHNlY3Rpb246ICVzKVxuIiwKPiAr
ICAgICAgICAgICAgbW9kbmFtZSwgZnJvbXN5bSwgKHVuc2lnbmVkIGludCkoZmFkZHIgLSBmcm9t
LT5zdF92YWx1ZSksIGZyb21zZWMsIHRvc3ltLCB0b3NlYyk7Cj4KPiAgICAgICAgIGlmIChtaXNt
YXRjaC0+bWlzbWF0Y2ggPT0gRVhUQUJMRV9UT19OT05fVEVYVCkgewo+ICAgICAgICAgICAgICAg
ICBpZiAobWF0Y2godG9zZWMsIG1pc21hdGNoLT5iYWRfdG9zZWMpKQo+IC0tCj4gMi4zOS4yCj4K
CgotLSAKVGhhbmtzLAp+TmljayBEZXNhdWxuaWVycwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC11bQo=
