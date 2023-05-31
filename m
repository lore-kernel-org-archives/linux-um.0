Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7267C77B7A
	for <linux-um@archiver.kernel.org>; Wed, 31 May 2023 08:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bqz3xrkhaeDen64+wxHtg0UMKT1av//wPofx7wfaecQ=; b=n0w7bPewjPQtmJ
	/zf0zADB6D2G/37x0IPPkqjN30fVF/OVtcYqk4dj0AbwZFd+Phhh2hrtoXUJ5Tn24EQVneCglFWIZ
	R3XTaXO3QnzBALk0+VxR61+w2xd9T3jYojGdoKzcZQHu7jk5O2bsnCThN5aLSCBMsBsqYswgNu2+O
	y2uccC8knX1IhlZ04aNMBwgHAJsXcvcBNonknwJ0P5bGegx/NNK1Ig+dDl5cDoe617bvy89REb2zl
	WJNnS9+B7clkWWBDAzqKKvKunIAhS83B1tuTrONxk8kCfxy3RjZxwyrxhvChkFXwAiqh0zH58/Jgn
	C6W7ev4y+ppdWZHbSXBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4Gph-00GYww-0L;
	Wed, 31 May 2023 08:05:25 +0000
Received: from mail-yb1-f179.google.com ([209.85.219.179])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4Gpe-00GYuY-1t
	for linux-um@lists.infradead.org;
	Wed, 31 May 2023 08:05:24 +0000
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-bad97da58adso6131721276.1
        for <linux-um@lists.infradead.org>; Wed, 31 May 2023 01:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685520318; x=1688112318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxrLCY7viWKO0bQukw/w0leEI6ByM9jS8ud+syXrPAA=;
        b=H79wspBMc9UCcFuIvSnckstXd4oBcEBYqTyNwM7E8I9yQn+A81ALXkyueJSrtenq4C
         UXhrH/VqxdBjxcwO2OvLQzdOvjy0e4MWPsoglnLT3gS1hkjWj3KEzRd3bHXdZAJqZZwv
         siC7KcmLf1zCFtJAeG5wJkhTBqrYmBpWN9Pvxq+yx1VrVyjXREJKE4JTvnEPEVkRVEo/
         u/Z/QmaRbqhxG0GlAotQX37ANm/ftyToKMSI8VPEeykOc/haGdnT+vOzXgdh2aLxICVL
         v4XhrcwYZ0o94sAFTplUEdTru8Av9MXScg+y+0TLKALCBUA7tQuFIlka6dSDewoXffHM
         u+hg==
X-Gm-Message-State: AC+VfDzMhHLUP87O7gE95MoojGHHl3Pazkmbx5fXrXu9/QKO+ssMDFxM
	sr9rheme7hzOYjAabtKzy7wNYN8OoKkNTA==
X-Google-Smtp-Source: ACHHUZ4gX/s1zLMQiEmWLsbO4biAd1eSjP8ZW9if7Nbfhzip9jPI8iMXPTWtFYLp9CQEtzo2tTpt3Q==
X-Received: by 2002:a81:524f:0:b0:565:5478:713a with SMTP id g76-20020a81524f000000b005655478713amr5135709ywb.49.1685520318595;
        Wed, 31 May 2023 01:05:18 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id y140-20020a81a192000000b005620e503c7csm2915793ywg.80.2023.05.31.01.05.16
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 01:05:17 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-565eb83efe4so51934567b3.0
        for <linux-um@lists.infradead.org>; Wed, 31 May 2023 01:05:16 -0700 (PDT)
X-Received: by 2002:a0d:ccd3:0:b0:561:e89d:e263 with SMTP id
 o202-20020a0dccd3000000b00561e89de263mr4627466ywd.52.1685520316792; Wed, 31
 May 2023 01:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230530164004.986750-1-azeemshaikh38@gmail.com>
 <202305311135.zGMT1gYR-lkp@intel.com> <09A0C6FA-669F-4B73-9620-43AEA17E5D0C@kernel.org>
 <103925562.158061.1685514200368.JavaMail.zimbra@nod.at>
In-Reply-To: <103925562.158061.1685514200368.JavaMail.zimbra@nod.at>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 31 May 2023 10:05:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU70uRxnMNb8KCJe8M3BRPPxowRXtj+POcrh+KLkfQyAA@mail.gmail.com>
Message-ID: <CAMuHMdU70uRxnMNb8KCJe8M3BRPPxowRXtj+POcrh+KLkfQyAA@mail.gmail.com>
Subject: Re: [PATCH] uml: Replace all non-returning strlcpy with strscpy
To: Richard Weinberger <richard@nod.at>
Cc: Kees Cook <kees@kernel.org>, Azeem Shaikh <azeemshaikh38@gmail.com>, 
	kernel test robot <lkp@intel.com>, Maxim Krasnyansky <maxk@qti.qualcomm.com>, 
	oe-kbuild-all <oe-kbuild-all@lists.linux.dev>, linux-hardening@vger.kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_010522_623028_1E615D68 
X-CRM114-Status: GOOD (  17.90  )
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

T24gV2VkLCBNYXkgMzEsIDIwMjMgYXQgODoyM+KAr0FNIFJpY2hhcmQgV2VpbmJlcmdlciA8cmlj
aGFyZEBub2QuYXQ+IHdyb3RlOgo+IC0tLS0tIFVyc3Byw7xuZ2xpY2hlIE1haWwgLS0tLS0KPiA+
Pj4+IGFyY2gvdW0vb3MtTGludXgvZHJpdmVycy90dW50YXBfdXNlci5jOjE0OToxNzogZXJyb3I6
IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mCj4gPj4+PiBmdW5jdGlvbiAnc3Ryc2NweSc7IGRpZCB5
b3UgbWVhbiAnc3RybmNweSc/Cj4gPj4+PiBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNs
YXJhdGlvbl0KPiA+PiAgICAgMTQ5IHwgICAgICAgICAgICAgICAgIHN0cnNjcHkoaWZyLmlmcl9u
YW1lLCBwcmktPmRldl9uYW1lLAo+ID4+ICAgICBzaXplb2YoaWZyLmlmcl9uYW1lKSk7Cj4gPj4g
ICAgICAgICB8ICAgICAgICAgICAgICAgICBefn5+fn5+Cj4gPj4gICAgICAgICB8ICAgICAgICAg
ICAgICAgICBzdHJuY3B5Cj4gPj4gICBjYzE6IHNvbWUgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBh
cyBlcnJvcnMKPiA+Cj4gPiBBaCwgeWVhaCwgdGhpcyBpcyBhbm90aGVyICJub3QgYWN0dWFsbHkg
aW4gdGhlIGtlcm5lbCIgY2FzZXMuIExldCdzIGlnbm9yZSB0aGlzCj4gPiBzdHJsY3B5IGZvciBu
b3cuCj4KPiBXZWxsLCBhY3R1YWxseSBpdCdzIGFub3RoZXIgY2FzZSBvZiAibm90IGV2ZW4gY29t
cGlsZSB0ZXN0ZWQiLiA6LSgKCiJCdXQgdGhlIEFJIHNhaWQgaXQgd2FzIGNvcnJlY3Q/IT8iIDst
KQoKR3J7b2V0amUsZWV0aW5nfXMsCgogICAgICAgICAgICAgICAgICAgICAgICBHZWVydAoKLS0g
CkdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIg
LS0gZ2VlcnRAbGludXgtbTY4ay5vcmcKCkluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0
ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQKd2hlbiBJJ20gdGFs
a2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcg
bGlrZSB0aGF0LgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZh
bGRzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
