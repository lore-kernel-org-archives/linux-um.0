Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F2EC7EE2E
	for <linux-um@archiver.kernel.org>; Mon, 12 Jun 2023 10:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BD4zoQqGVncB13+FdAOTVl8pQ3lhqvvWhva5fA0vP7c=; b=BXCNH7+5Epwj7M
	YD7sMmoIcttQSQeXXVSKrHXCtR6pcxat9/YMOgsC4bbqwMxsmcRLaxOorPhAEo9Vezcw1Y6MVtloN
	TD3Gj6ChmWU3xO0M+QmVPBtaxt45UEQTbEjIh7ASKd6KNdpyPYi23jmZy0dg/u3JZwatq3sG+qk1t
	h51iDqg3FQ4F8GhTssNsDcpAVYQmukVF0OCRf6TedR0lTY5LiTSdfmRsTvEUyOOon/QeAIh9VqTem
	4O8NxWTQDiPOzwYZpnK3WsSdabFoYKsucgJjBoFhUlZuLHCLjx3a36/p0KICCfA3J6Mz/tRQMEPHI
	LDqtZCBj1qVJOOXM0awg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8eU3-003RC2-08;
	Mon, 12 Jun 2023 10:09:11 +0000
Received: from mail-yb1-f177.google.com ([209.85.219.177])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8eU0-003RBW-0z
	for linux-um@lists.infradead.org;
	Mon, 12 Jun 2023 10:09:09 +0000
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-bc476bf5239so2235718276.2
        for <linux-um@lists.infradead.org>; Mon, 12 Jun 2023 03:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686564545; x=1689156545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0KNjzjUscMpY94OwsETv2nblTfy9at4y8uMIjfaCTE=;
        b=TXevnj2v4L60Ek1UW44huXpA5YkQnk7x+jNOjBvDI/C9+AIS8EZHe1TfHPCxO6lt8O
         O/9zWivPWQO8Bop3btm2IrZP3pxAwe57F70d/qnRMEmequMPfWgRuEKs8N6TB8HHWiJF
         /ABCXAjkDUfb8WKQQbRdPXppIEOIhf/JQcfsBHobKv6322MkJaKRV3aUGyZJiFoMTGwG
         9GyCiF0VpUP8zmuyjp8XLujEmOTdgswSaV6+s7aU1YntFwy9PXrPXxkSbJflzwxXnd4b
         u8rJNtvY4oOyPOfBz0EluEZj+W9lcbhczpNuN6ZwqeS64ozPcwmAw/7cBVLdMWTOt4fD
         48yg==
X-Gm-Message-State: AC+VfDwpWlqp/9Ati0DuSibWrLkA6MVhbnx6KjE3ldlURTeAofYndMWV
	4J9Ux9Pp7QHJzk4WV6Rfv96ckFCPzlCTQw==
X-Google-Smtp-Source: ACHHUZ6CbrnHq0d/apjVWtUxdIOEdYvsecVANuoDUgP4fP8CfraC+bNElqEBgLeiUj22U6MadNms8w==
X-Received: by 2002:a25:8506:0:b0:bab:d9b1:ad63 with SMTP id w6-20020a258506000000b00babd9b1ad63mr6150857ybk.38.1686564542294;
        Mon, 12 Jun 2023 03:09:02 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id j81-20020a25d254000000b00bcbcb91e974sm410137ybg.16.2023.06.12.03.09.01
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 03:09:01 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-bacbc7a2998so4393679276.3
        for <linux-um@lists.infradead.org>; Mon, 12 Jun 2023 03:09:01 -0700 (PDT)
X-Received: by 2002:a25:4b41:0:b0:ba8:2e05:3e9c with SMTP id
 y62-20020a254b41000000b00ba82e053e9cmr8962689yba.24.1686564541590; Mon, 12
 Jun 2023 03:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgmbjQu3bVSa5JJhEymeQhkr7N3cjg-CoNLVituUnfW8w@mail.gmail.com>
 <20230612090911.1579029-1-geert@linux-m68k.org> <9c7f3e17-c1-1a3a-7e87-9b1ea25d9d7@linux-m68k.org>
 <ea22bff7-ecd2-018e-77a1-1d2edaa21355@linaro.org>
In-Reply-To: <ea22bff7-ecd2-018e-77a1-1d2edaa21355@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Jun 2023 12:08:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXUz5KatvuDxPZN5YEP-8SrqonbGCO-411CxWuKQn1PXA@mail.gmail.com>
Message-ID: <CAMuHMdXUz5KatvuDxPZN5YEP-8SrqonbGCO-411CxWuKQn1PXA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.4-rc6
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-spi@vger.kernel.org, linux-mips@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_030908_365972_7E41868A 
X-CRM114-Status: GOOD (  15.65  )
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

SGkgVHVkb3IsCgpPbiBNb24sIEp1biAxMiwgMjAyMyBhdCAxMTo0OOKAr0FNIFR1ZG9yIEFtYmFy
dXMgPHR1ZG9yLmFtYmFydXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4gT24gNi8xMi8yMyAxMDoyOCwg
R2VlcnQgVXl0dGVyaG9ldmVuIHdyb3RlOgo+ID4+IEpGWUksIHdoZW4gY29tcGFyaW5nIHY2LjQt
cmM2WzFdIHRvIHY2LjQtcmM1WzNdLCB0aGUgc3VtbWFyaWVzIGFyZToKPiA+PiAgLSBidWlsZCBl
cnJvcnM6ICs1Ly02Cj4gPgo+ID4gICArIC9raXNza2Ivc3JjL2RyaXZlcnMvc3BpL3NwaS1zdG0z
Mi1xc3BpLmM6IGVycm9yOiDigJhvcOKAmSBpcyB1c2VkCj4gPiB1bmluaXRpYWxpemVkIFstV2Vy
cm9yPXVuaW5pdGlhbGl6ZWRdOiAgPT4gNTIzOjI3LCA1NjQ6MjcKPgo+IFNlZW1zIHRoYXQgdGhl
IHJlcG9ydCBpcyBub3QgY29ycmVjdCBmb3IgdGhpcyBwYXJ0aWN1bGFyIGNhc2UgYXMgb3AgaXMK
PiBmaWxsZWQgZWl0aGVyIGJ5IG1lbWNweSBvciBtZW1zZXQgYmVmb3JlIHVzZS4KCkkgY2FuIHJl
cHJvZHVjZSB0aGUgaXNzdWUgd2l0aCBnY2MgMTIuMS4wLTJ1YnVudHUxfjIyLjA0LgpObyBpZGVh
IHdoYXQncyB3cm9uZy4gRGlzYWJsaW5nIENPTkZJR19GT1JUSUZZX1NPVVJDRSBkb2Vzbid0Cmhl
bHAuIFBlcmhhcHMgYW4gaXNzdWUgd2l0aCB0aGUgbWVtY3B5KCkgdXNlZCBieSBVTUw/CgpHcntv
ZXRqZSxlZXRpbmd9cywKCiAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0CgotLSAKR2VlcnQg
VXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVy
dEBsaW51eC1tNjhrLm9yZwoKSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNh
bCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dAp3aGVuIEknbSB0YWxraW5nIHRv
IGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRo
YXQuCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1h
aWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
