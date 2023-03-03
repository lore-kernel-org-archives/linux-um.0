Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5A6C678D4
	for <linux-um@archiver.kernel.org>; Fri,  3 Mar 2023 07:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LTW3GEXdMsE9tt8Sz7t5rXaaIAIX6xUaFfjynFskzUg=; b=1toIQJizxXyjbg
	ox/PVa5NorACYcEYn22Lgmr8Lea9Mkoqxq3hK2ThgriHFg9T4caSu6w69MgE3R6oKmhg58MOWMjWJ
	pSd8jrmPpiOnS3jPVqnEHw6MOTxXW/wyh7CQcvyRO2kVc8cA1WX2Xw5tEjqGcxMhWAJDya07w0fpq
	CFtKjH6D8ZyCCykmrBYVyl5rkZWWbIBEdUdiVjfzuF4lOieJzFI4Pp0+Ld8Al4myltWOhNHdBJ0uS
	G8FAtmCaFtCWtXlFc6hLk/zniC3Rf10AugzHQ8LhgqfvV6rZheP97Os/QX5Ka5CauA0UVnXScTifx
	8OZXmkTEXzOwrHPML6Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY0AN-005HbG-Am; Fri, 03 Mar 2023 07:49:23 +0000
Received: from mail-qt1-f169.google.com ([209.85.160.169])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY0AJ-005HZy-TS
	for linux-um@lists.infradead.org; Fri, 03 Mar 2023 07:49:21 +0000
Received: by mail-qt1-f169.google.com with SMTP id y10so2029012qtj.2
        for <linux-um@lists.infradead.org>; Thu, 02 Mar 2023 23:49:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677829757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAR2N87vP4MjUgtQ2gw4JnK3iq+Hn4L+wybsd58CSxY=;
        b=hTNf98RT2Fu+NTtPUHkVYgAidi5Zgum5snp8ivGKYsVCaAJ65TTU5HybjU6D717huf
         iP+RN0Dc7ls+0dQdjECAZx9KcSSkPKY7w5ikRgZ954SlGH0yWsf/M6ZySr1Z+Mmqh2S5
         kshrwT4Mjnq/FopOy3HmwqP06WCmDaS1QXaRznnO5/l/Lq5ubiHZMMPMjCBfkVAwKieK
         4W5QpTEb8CTMgh83bMAcEsROiH+iAr62NepfWwx7diiNxUeLlnRXGSZt1NHHCq7hQ/5W
         Wemu8f56h5kIs2Tm4ZJYoAcKsnCaoP592PDnWz62MqYNBc9BDGCTwHamir91t9P3ypPo
         g5LQ==
X-Gm-Message-State: AO0yUKVSOygnMUd2SsJwIWGMtr7zn9u1buSyUT8UsUkgATpI2KqL6mBO
	VBMLDKlV/p4MnVjqv+rXqPILeaGIgWPT3Q==
X-Google-Smtp-Source: AK7set8VZZBtuuM3Swgy00O/9YKxrU0kUU1mOL4FFvmZIRAcQ9ALzXwMWNcQh4LO0cztxp7cE07Prg==
X-Received: by 2002:ac8:584d:0:b0:3b9:bdb0:7aa1 with SMTP id h13-20020ac8584d000000b003b9bdb07aa1mr1505209qth.41.1677829757174;
        Thu, 02 Mar 2023 23:49:17 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id dm37-20020a05620a1d6500b0073ba44fd6a2sm1265004qkb.1.2023.03.02.23.49.15
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 23:49:16 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-536bf92b55cso27987657b3.12
        for <linux-um@lists.infradead.org>; Thu, 02 Mar 2023 23:49:15 -0800 (PST)
X-Received: by 2002:a81:f105:0:b0:538:49a4:b1e0 with SMTP id
 h5-20020a81f105000000b0053849a4b1e0mr3042397ywm.2.1677829755610; Thu, 02 Mar
 2023 23:49:15 -0800 (PST)
MIME-Version: 1.0
References: <20230302013822.1808711-1-sboyd@kernel.org> <20230302013822.1808711-2-sboyd@kernel.org>
 <CABVgOSkxOxpaHVtq1YpvNEshTZ3nic1p7NjV5DPdz066=tiS-A@mail.gmail.com>
In-Reply-To: <CABVgOSkxOxpaHVtq1YpvNEshTZ3nic1p7NjV5DPdz066=tiS-A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 3 Mar 2023 08:49:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVN=s-ytn03Kze5okA6rhzdWJ0cWxXV0vrtYXDvLoFMQw@mail.gmail.com>
Message-ID: <CAMuHMdVN=s-ytn03Kze5okA6rhzdWJ0cWxXV0vrtYXDvLoFMQw@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: Add linux,kunit binding
To: David Gow <davidgow@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	patches@lists.linux.dev, Brendan Higgins <brendan.higgins@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, Rob Herring <robh+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230302_234919_988308_A73E4570 
X-CRM114-Status: GOOD (  22.35  )
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

SGkgRGF2aWQsCgpPbiBGcmksIE1hciAzLCAyMDIzIGF0IDg6MTbigK9BTSBEYXZpZCBHb3cgPGRh
dmlkZ293QGdvb2dsZS5jb20+IHdyb3RlOgo+IE9uIFRodSwgMiBNYXIgMjAyMyBhdCAwOTozOCwg
U3RlcGhlbiBCb3lkIDxzYm95ZEBrZXJuZWwub3JnPiB3cm90ZToKPiA+IERvY3VtZW50IHRoZSBs
aW51eCxrdW5pdCBib2FyZCBjb21wYXRpYmxlIHN0cmluZy4gVGhpcyBib2FyZCBpcyBsb2FkZWQK
PiA+IGludG8gdGhlIExpbnV4IGtlcm5lbCB3aGVuIEtVbml0IGlzIHRlc3RpbmcgZGV2aWNldHJl
ZSBkZXBlbmRlbnQgY29kZS4KPgo+IEFzIHdpdGggdGhlIHNlcmllcyBhcyBhIHdob2xlLCB0aGlz
IG1pZ2h0IG5lZWQgdG8gY2hhbmdlIGEgbGl0dGxlIGJpdAo+IGlmIHdlIHdhbnQgdG8gZWl0aGVy
IHVzZSBkZXZpY2V0cmVlIG92ZXJsYXlzIGFuZC9vciBvdGhlcgo+IGFyY2hpdGVjdHVyZXMuCj4K
PiBUaGF0IGJlaW5nIHNhaWQsIEknbSBva2F5IHdpdGggaGF2aW5nIHRoaXMgdW50aWwgdGhlbjog
dGhlIG9ubHkgcmVhbAo+IHRvcGljIGZvciBiaWtlc2hlZGRpbmcgaXMgdGhlIG5hbWUuCj4gLSBJ
cyBLVW5pdCBiZXN0IGFzIGEgYm9hcmQgbmFtZSwgb3IgcGFydCBvZiB0aGUgdmVuZG9yIG5hbWU/
Cj4gLSBEbyB3ZSB3YW50IHRvIGluY2x1ZGUgdGhlIGFyY2hpdGVjdHVyZSBpbiB0aGUgbmFtZT8K
PiBTaG91bGQgaXQgYmUgImxpbnV4LGt1bml0IiwgImxpbnV4LWt1bml0LHVtbCIsICJsaW51eCxr
dW5pdC11bWwiLCBldGM/CgpJIHdvdWxkIG5vdCBpbmNsdWRlIGFuIGFyY2hpdGVjdHVyZSAob3Ig
dmlydHVhbGl6YXRpb24gbWV0aG9kKSwgYXMKdGhpcyBpcyBpbmRlcGVuZGVudCBvZiB0aGUgYXJj
aGl0ZWN0dXJlIG9yIHZpcnR1YWxpemF0aW9uIG1ldGhvZC4KCkdye29ldGplLGVldGluZ31zLAoK
ICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQKCi0tIApHZWVydCBVeXR0ZXJob2V2ZW4gLS0g
VGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3Jn
CgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxs
IG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBq
dXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4
LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC11bQo=
