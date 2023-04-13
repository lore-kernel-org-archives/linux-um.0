Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38236C77B6E
	for <linux-um@archiver.kernel.org>; Thu, 13 Apr 2023 22:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2zKf8O9TJDMIfvatSZ72f+2+jXSgiYViMgD3qzSrCCI=; b=RpyXbTgFuCEV7Q
	50b+1ISIbFOWLR0piSlbhDyoEUa1+emFlvPJrmL0oU4xtOfuOWPu6f8Kfn//h2YK/CTIwKyrllhAx
	BezizVdw1hMRXQAPGu7nx9nSYyMa9/AYgYolDgEaMY1K1t1MpzArcEhJD/VW3VbDYTaoV/BhXwR17
	hFgjtnIiD1UqUqJRrjetmmKsNHI2PQRruJF0rnnCjehfWPCGPCtS93DY1K5Jp+SbrxHDSzzfp6NNM
	V+O3HeUmEeqGezNYcXh+xR8xa8W1DKsmSL3wFxo+tFbtrQDIR2wmdBtUmOU0IB04irIyuHWKsvIrw
	qKl+8O9DErobk1GP4zdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pn5Ss-007GBz-2g;
	Thu, 13 Apr 2023 22:30:50 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pn5Sp-007GBQ-2y
	for linux-um@lists.infradead.org;
	Thu, 13 Apr 2023 22:30:49 +0000
Received: by mail-wr1-x42c.google.com with SMTP id g5so19052399wrb.5
        for <linux-um@lists.infradead.org>; Thu, 13 Apr 2023 15:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681425044; x=1684017044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVVINTZFljE3D1m9vpMFDBIoPu6/jsAxERMDUpxwJvk=;
        b=jvnBGxoVOaXjZWgObqoYY20QdkOzuTppeMTq11LUtrtmrH39TKI6IEjtMa18vhvbE+
         V/B6Rt0J02oRGkpptjUmfUMqRoESxX4MgPDvFKD4mcK/3jlOc7U/xqWQtPEP+nwtGh6J
         w9liTpRWDcvVPxpIVGKJjTpI/CMqn39GhmJTbXiLxvNp5Ksfa71B93XQF+6R3065FNj3
         erQznfkm+hRcv4HOKXDsv0vmSiM9OO5gyNqldRSK8JD1MyF+0RYYPxxGVoyGi7drHLW6
         u/01IIzlOtSjYF2ljwl4YRfYZ1iidm0Nu7yLMiqRkdaj+EXTUXjSY7pgUOb0DDnjhZ1V
         kaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681425044; x=1684017044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVVINTZFljE3D1m9vpMFDBIoPu6/jsAxERMDUpxwJvk=;
        b=cvT8l2AoyxrHNHNe3zOuJNX41HvP/LC8Pkyzri5DQTfGl18HBatFdPqBEhmc3kWi6K
         kzs8eEjpriauvN3bxJdGw/ob6/gN2MaHV5efxjJU7ieGvYrt/8opcrEMAeNv69/95Nzz
         gHm3WYIXipjUW7Hqs0HIMR4/529RQRnL1pybjU55ifr/aPDZNwcGTojwWkn0eGyft4vm
         AIM9cArSKCwnNQWlcCykVMlM1dzsG27wDLmxrNk1T5fK/j6TmToFCqw1jeRPjlx61HrC
         N9JeN6gGg0hhRT892MHRpYlJS0i4+OpV+beYMFmJveXi9VI+gCx5qsvKlgGx8HVawipl
         KT2g==
X-Gm-Message-State: AAQBX9fvLY5HDnnh7f/g8kXcz7WH4bRsxRabkZrCyXk+EP/6EC6n1PNG
	Ov3IlOFsWl3NTDdthTVz+jATJsDbiYWIHEKcbos=
X-Google-Smtp-Source: AKy350aVcoL9hKB6wv6rez6DhxVCUF/c9Znwut2f+VDsazYCOESNHCMjqCGcXlu7/QmgaI1zzJvrgw==
X-Received: by 2002:a5d:5403:0:b0:2ef:ba50:20e7 with SMTP id g3-20020a5d5403000000b002efba5020e7mr2567438wrv.43.1681425044468;
        Thu, 13 Apr 2023 15:30:44 -0700 (PDT)
Received: from laptop-fedora.. ([79.175.90.109])
        by smtp.gmail.com with ESMTPSA id e32-20020a5d5960000000b002f02dbddc26sm2133889wri.68.2023.04.13.15.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 15:30:41 -0700 (PDT)
From: =?UTF-8?q?Marko=20Petrovi=C4=87?= <petrovicmarko2006@gmail.com>
To: linux-um@lists.infradead.org
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	=?UTF-8?q?Marko=20Petrovi=C4=87?= <petrovicmarko2006@gmail.com>
Subject: [PATCH 1/2] Document new xattrperm flag
Date: Fri, 14 Apr 2023 00:30:23 +0200
Message-Id: <20230413223024.11513-2-petrovicmarko2006@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413223024.11513-1-petrovicmarko2006@gmail.com>
References: <20230413223024.11513-1-petrovicmarko2006@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230413_153047_961782_ECA4BC64 
X-CRM114-Status: UNSURE (   9.31  )
X-CRM114-Notice: Please train this message.
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

U2lnbmVkLW9mZi1ieTogTWFya28gUGV0cm92acSHIDxwZXRyb3ZpY21hcmtvMjAwNkBnbWFpbC5j
b20+Ci0tLQogLi4udG9fdjIucnN0ID0+IHVzZXJfbW9kZV9saW51eF9ob3d0b192My5yc3R9IHwg
MjAgKysrKysrKysrLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwg
MTEgZGVsZXRpb25zKC0pCiByZW5hbWUgRG9jdW1lbnRhdGlvbi92aXJ0L3VtbC97dXNlcl9tb2Rl
X2xpbnV4X2hvd3RvX3YyLnJzdCA9PiB1c2VyX21vZGVfbGludXhfaG93dG9fdjMucnN0fSAoOTkl
KQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdmlydC91bWwvdXNlcl9tb2RlX2xpbnV4X2hv
d3RvX3YyLnJzdCBiL0RvY3VtZW50YXRpb24vdmlydC91bWwvdXNlcl9tb2RlX2xpbnV4X2hvd3Rv
X3YzLnJzdApzaW1pbGFyaXR5IGluZGV4IDk5JQpyZW5hbWUgZnJvbSBEb2N1bWVudGF0aW9uL3Zp
cnQvdW1sL3VzZXJfbW9kZV9saW51eF9ob3d0b192Mi5yc3QKcmVuYW1lIHRvIERvY3VtZW50YXRp
b24vdmlydC91bWwvdXNlcl9tb2RlX2xpbnV4X2hvd3RvX3YzLnJzdAppbmRleCBhZjJhOTc0Mjk2
OTIuLjcwOWVlZjEwZGQ3ZCAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi92aXJ0L3VtbC91c2Vy
X21vZGVfbGludXhfaG93dG9fdjIucnN0CisrKyBiL0RvY3VtZW50YXRpb24vdmlydC91bWwvdXNl
cl9tb2RlX2xpbnV4X2hvd3RvX3YzLnJzdApAQCAtMTAwNywyMyArMTAwNywyMSBAQCBhbiBleGlz
dGluZyByb290X2ZzIGZpbGU6OgogCiAgICAjICBtb3VudCByb290X2ZzIHVtbF9yb290X2RpciAt
byBsb29wCiAKLQotWW91IG5lZWQgdG8gY2hhbmdlIHRoZSBmaWxlc3lzdGVtIHR5cGUgb2YgYGAv
YGAgaW4gYGBldGMvZnN0YWJgYCB0byBiZQotJ2hvc3RmcycsIHNvIHRoYXQgbGluZSBsb29rcyBs
aWtlIHRoaXM6OgotCi0gICAvZGV2L3ViZC8wICAgICAgIC8gICAgICAgIGhvc3RmcyAgICAgIGRl
ZmF1bHRzICAgICAgICAgIDEgICAxCi0KIFRoZW4geW91IG5lZWQgdG8gY2hvd24gdG8geW91cnNl
bGYgYWxsIHRoZSBmaWxlcyBpbiB0aGF0IGRpcmVjdG9yeQotdGhhdCBhcmUgb3duZWQgYnkgcm9v
dC4gIFRoaXMgd29ya2VkIGZvciBtZTo6Cit0aGF0IGFyZSBvd25lZCBieSByb290IHNvIHRoYXQg
dGhlIGtlcm5lbCBjYW4gYWNjZXNzIHRoZW0uCitUaGlzIHdvcmtlZCBmb3IgbWU6OgogCi0gICAj
ICBmaW5kIC4gLXVpZCAwIC1leGVjIGNob3duIGpkaWtlIHt9IFw7CisgICAjICBmaW5kIHVtbF9y
b290X2RpciAtdWlkIDAgLW5vdCAtdHlwZSBsIC1leGVjIGNob3duIGpkaWtlIHt9IFw7CiAKIE5l
eHQsIG1ha2Ugc3VyZSB0aGF0IHlvdXIgVU1MIGtlcm5lbCBoYXMgaG9zdGZzIGNvbXBpbGVkIGlu
LCBub3QgYXMgYQotbW9kdWxlLiAgVGhlbiBydW4gVU1MIHdpdGggdGhlIGJvb3QgZGV2aWNlIHBv
aW50aW5nIGF0IHRoYXQgZGlyZWN0b3J5OjoKK21vZHVsZS4gIFRoZW4gcnVuIFVNTCB3aXRoIHRo
ZSBhcHByb3ByaWF0ZSBrZXJuZWwgY29tbWFuZCBsaW5lCitwYXJhbWV0ZXJzOjoKIAotICAgdWJk
MD0vcGF0aC90by91bWwvcm9vdC9kaXJlY3RvcnkKKyAgIHJvb3Rmc3R5cGU9aG9zdGZzIHJ3IGhv
c3Rmcz11bWxfcm9vdF9kaXIseGF0dHJwZXJtCiAKLVVNTCBzaG91bGQgdGhlbiBib290IGFzIGl0
IGRvZXMgbm9ybWFsbHkuCitZb3Ugc2hvdWxkIGhhdmUgZXh0ZW5kZWQgYXR0cmlidXRlcyBzdXBw
b3J0ZWQgYW5kIGVuYWJsZWQgb24KK3lvdXIgaG9zdCBmaWxlc3lzdGVtIHNpbmNlIFVNTCB1c2Vz
IHRoZW0gdG8gc3RvcmUgY29ycmVjdCBmaWxlCitwZXJtaXNzaW9ucy4KIAogSG9zdGZzIENhdmVh
dHMKIC0tLS0tLS0tLS0tLS0tCi0tIAoyLjM5LjIKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LXVtCg==
