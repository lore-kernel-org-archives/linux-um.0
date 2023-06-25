Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931ADC001DD
	for <linux-um@archiver.kernel.org>; Sun, 25 Jun 2023 21:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i74c3Iglfe2XexQbxscB9Y93DfrjH04IUfLEd/ZPBIU=; b=252d0cf6NwbrSE
	XBzYD/d8gGzzRSrcWopMGHIGNX9QnxT/+eZUx1c/q0FXHqSaTm7/9yQtYPdJbyuzbZgsGMtjelKf3
	XcGDYo5gn0Lr0C1FFshWXpTtf0iI8WwmcUL6z/7XBelZj5o6VPVOmuqOE0vciqI8c2mhzx8vVMs/7
	jW6HypTajHIukRn9BnFEJOmSJVO0nSUlB9+krfpcPAotzLDqnmrSSJu71p90BkyY1kevrzarlesd/
	wFLjnG3FFKmd5QoRKPR3XD1LXhDUCPqema7SnCOtgx0cdmGPuh+CNpWDJlnsh1DqqWxir4w/GFZjY
	BSKM+ZI8nM96NH3BAZzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDXDh-008k7Z-0N;
	Sun, 25 Jun 2023 21:24:29 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDXDe-008k6g-1x
	for linux-um@lists.infradead.org;
	Sun, 25 Jun 2023 21:24:27 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fa9850bfd9so1101745e9.0
        for <linux-um@lists.infradead.org>; Sun, 25 Jun 2023 14:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687728263; x=1690320263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zJ2LafRfz7os09FITqhIzXchpbb/yMPyJ2Us3fSNtf0=;
        b=iTWoODUdaYt63IT2LCFFmF27v13vBU9cMCV96V34jkX9XShSfvrMiace/hecHAvK+0
         4vn4p2/zz9GSXEnpBM20uJ/iZlwZ+9WVjEKijGCZJ8AvTE3qb5MSmfjbZgIaw6YJfLe9
         WDUh34UW//HY8Dc/ItqAQsBhZwNr/XIhdjADfnlp3WlhxWJdOClYv2zcDffRZheFOUWB
         tYpErS6IaBm6ybKKh+47GuC1BShx0GrlNSnOsONy1IQsLm0YoEayGjCe60gnHaNIwXpH
         EKwUt7pNCwC/7GGfUEuYnQO2kJyx2Q9x/jv1O3BK/shZ6VwAZHMPhdVVMUlsTIghuGP9
         nDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687728263; x=1690320263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJ2LafRfz7os09FITqhIzXchpbb/yMPyJ2Us3fSNtf0=;
        b=keSp581gvwNpDC8OnKkRuRuznWsF0LfOwBIxDQ0o2emkdekYHyQvgV9JssBdwUUj0W
         2bVb9hslP+RifN13r+kDW2IuEAnCFIMy4sA5clCrJjGfoixVCSXjM5PmQj/X7NZq/Wj5
         S9ye394m+QCM2T4Si56SmRVNfs1+c5TW9eGI/xwwVcxvMEJOEMKg40U+pTNILVGA85q4
         tHzNRo6i8x8/4ah1ECqQUzzZWEZXxb1AzracT2TtiLHw3a2K3K3m7drxhTRHAjiXNzdq
         bWjCvVlpYawmiHbwCHVjGP8syKwnvL7vgW+H+hG9B3rNmrvcQUuf0fuegkViswjMw9oe
         4Y9w==
X-Gm-Message-State: AC+VfDzHOTQq6Ib2VkzSKJ9eRVYmsAumYS1kYLv6Wg7ipUcOHGN0Jlcu
	PIazfBncjtOHFbeZLupP/Xb51w==
X-Google-Smtp-Source: ACHHUZ7owkSsDH94uGEOz/gQMPWu+sjhTMek700bGa8JgoZcFLJS995GaovHAQT/FzjooRzNe5f+tQ==
X-Received: by 2002:a1c:e914:0:b0:3f8:facf:7626 with SMTP id q20-20020a1ce914000000b003f8facf7626mr18367949wmc.20.1687728263150;
        Sun, 25 Jun 2023 14:24:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.212.184])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c228400b003f7e4d143cfsm5665000wmf.15.2023.06.25.14.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 14:24:22 -0700 (PDT)
Message-ID: <b751e028-598e-14fd-1f2b-34d1b9eed599@linaro.org>
Date: Sun, 25 Jun 2023 23:24:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [patch 04/17] ia64/cpu: Switch to arch_cpu_finalize_init()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 linux-ia64@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 Richard Henderson <richard.henderson@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Chris Zankel <chris@zankel.net>,
 Tom Lendacky <thomas.lendacky@amd.com>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.137045745@linutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230613224545.137045745@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230625_142426_645429_9FDC5BE1 
X-CRM114-Status: UNSURE (   9.82  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

T24gMTQvNi8yMyAwMTozOSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOgo+IGNoZWNrX2J1Z3MoKSBp
cyBhYm91dCB0byBiZSBwaGFzZWQgb3V0LiBTd2l0Y2ggb3ZlciB0byB0aGUgbmV3Cj4gYXJjaF9j
cHVfZmluYWxpemVfaW5pdCgpIGltcGxlbWVudGF0aW9uLgo+IAo+IE5vIGZ1bmN0aW9uYWwgY2hh
bmdlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4
LmRlPgo+IENjOiBsaW51eC1pYTY0QHZnZXIua2VybmVsLm9yZwo+IC0tLQo+ICAgYXJjaC9pYTY0
L0tjb25maWcgICAgICAgICAgICB8ICAgIDEgKwo+ICAgYXJjaC9pYTY0L2luY2x1ZGUvYXNtL2J1
Z3MuaCB8ICAgMjAgLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgIGFyY2gvaWE2NC9rZXJuZWwvc2V0
dXAuYyAgICAgfCAgICAzICstLQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIyIGRlbGV0aW9ucygtKQoKUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxw
aGlsbWRAbGluYXJvLm9yZz4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVt
Cg==
