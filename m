Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E9CC74A5B
	for <linux-um@archiver.kernel.org>; Tue, 14 Mar 2023 12:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/Dsait2qjveopGBrEyEQ0vdGnV8f/C7HMGolf92ZlmM=; b=NsHpPrDm0EsWok
	VSRq9LdA0va8oQKQ+EdRWLzvL1ciSm6G7UFM+Q1aqq6+KvV2qerQbAptFTx0TUWRnEcSTIhY27Vd/
	1tdDl1Eo8AYLgfkoMV6P+odJWiGsznRk4aB34DMSCd0E7HuA/JHRR0GK3a1hS613RK7B+teP+3DCA
	XyzD+lLtt9RamGOTIoctjp/fPhdxvx+uWpxy5jWq4Tv5W+uS5YKH9vD3XBoxAKkhOgIL9B7CW06Bx
	hX7NlzkOn/N2Bj9YmdST9W6X+5PShXro4Pt1alpKzLE1Z2aMg3Rif1G8XbiHL11PTSG0nQHnKgb04
	6Yk8bOqHrtcL6eSjHzCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pc45Q-00ACvZ-1c;
	Tue, 14 Mar 2023 12:49:04 +0000
Received: from mail-il1-f169.google.com ([209.85.166.169])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pc45M-00ACsQ-0z;
	Tue, 14 Mar 2023 12:49:01 +0000
Received: by mail-il1-f169.google.com with SMTP id h5so4532316ile.13;
        Tue, 14 Mar 2023 05:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678798137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBpmO88aubLNx5ds9k4LYpaw6LJjHZV6232nWb27C40=;
        b=UnUSnr+Cwn/c3SZGKH6BfbJ6AZmG6Vh8mqpgV3mlUzO8yMRFMe9rODSI2NUnOlB+bj
         NuBek8gMBlS5fQWQ1031q/1A7QtB3Af31Jgh0EInxWs/zDwZKLikEyt9h/AHa5Wzo9Rb
         +bNGO+k/ZIzE7mdQ4YShQyxvwICBeMSI0zjyM1YnfsfkFmyyj3ya+xcfwSpFdVp/XPp6
         P9I/IUyp1NYGWxqSaTqFP1eMCCNuhOw9apBDEN7DtD1Jy31PzUdKg1Ie7VK2e4jdMMDw
         ehROLlsaBbebc9DMfqF6dCje/NHmQs8B6FjOc9NJauWsh4CABM2cHOD6Zj739qYN/EPW
         KQWw==
X-Gm-Message-State: AO0yUKXXwTVCuFer0fZNWaK7sNykdpI0Xcd79EBnQiKbMBUXIYXk2Gms
	SzhWO6exIrInW36Vj05B39Y3XRYR2qRsVQ==
X-Google-Smtp-Source: AK7set9zxted67qvDGTbsQDdQg9Ifl1ugWI5zrU6uQc/lpnjXfwrBF5+E2oQJ5yA9JwLeH3QDn/8Yw==
X-Received: by 2002:a05:6e02:1ca8:b0:322:fe79:8141 with SMTP id x8-20020a056e021ca800b00322fe798141mr2895133ill.1.1678798137489;
        Tue, 14 Mar 2023 05:48:57 -0700 (PDT)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id d4-20020a92ddc4000000b003230c7d6a3csm767235ilr.67.2023.03.14.05.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 05:48:56 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id 4so8573231ilz.6;
        Tue, 14 Mar 2023 05:48:55 -0700 (PDT)
X-Received: by 2002:a05:6902:1002:b0:b48:1359:4e28 with SMTP id
 w2-20020a056902100200b00b4813594e28mr461087ybt.12.1678798114483; Tue, 14 Mar
 2023 05:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230314121216.413434-1-schnelle@linux.ibm.com> <20230314121216.413434-2-schnelle@linux.ibm.com>
In-Reply-To: <20230314121216.413434-2-schnelle@linux.ibm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Mar 2023 13:48:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV9ZoB5XNiiVEG-zBzB9eN5RJSC42WMDD-RZfcg=2tr4g@mail.gmail.com>
Message-ID: <CAMuHMdV9ZoB5XNiiVEG-zBzB9eN5RJSC42WMDD-RZfcg=2tr4g@mail.gmail.com>
Subject: Re: [PATCH v3 01/38] Kconfig: introduce HAS_IOPORT option and select
 it as necessary
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-pci@vger.kernel.org, 
	Arnd Bergmann <arnd@kernel.org>, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_054900_347296_00C0C3FA 
X-CRM114-Status: GOOD (  19.93  )
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

T24gVHVlLCBNYXIgMTQsIDIwMjMgYXQgMToxM+KAr1BNIE5pa2xhcyBTY2huZWxsZSA8c2NobmVs
bGVAbGludXguaWJtLmNvbT4gd3JvdGU6Cj4gV2UgaW50cm9kdWNlIGEgbmV3IEhBU19JT1BPUlQg
S2NvbmZpZyBvcHRpb24gdG8gaW5kaWNhdGUgc3VwcG9ydCBmb3IgSS9PCj4gUG9ydCBhY2Nlc3Mu
IEluIGEgZnV0dXJlIHBhdGNoIEhBU19JT1BPUlQ9biB3aWxsIGRpc2FibGUgY29tcGlsYXRpb24g
b2YKPiB0aGUgSS9PIGFjY2Vzc29yIGZ1bmN0aW9ucyBpbmIoKS9vdXRiKCkgYW5kIGZyaWVuZHMg
b24gYXJjaGl0ZWN0dXJlcwo+IHdoaWNoIGNhbiBub3QgbWVhbmluZ2Z1bGx5IHN1cHBvcnQgbGVn
YWN5IEkvTyBzcGFjZXMgc3VjaCBhcyBzMzkwLiBBbHNvCj4gYWRkIGRlcGVuZGVuY2llcyBvbiBI
QVNfSU9QT1JUIGZvciB0aGUgSVNBIGFuZCBIQVZFX0VJU0EgY29uZmlnIG9wdGlvbnMKPiBhcyB0
aGVzZSBidXNzZXMgYWx3YXlzIGdvIGFsb25nIHdpdGggSEFTX0lPUE9SVC4KPgo+IFRoZSAiZGVw
ZW5kcyBvbiIgcmVsYXRpb25zIG9uIEhBU19JT1BPUlQgaW4gZHJpdmVycyBhcyB3ZWxsIGFzIGlm
ZGVmcwo+IGZvciBIQVNfSU9QT1JUIHNwZWNpZmljIHNlY3Rpb25zIHdpbGwgYmUgYWRkZWQgaW4g
c3Vic2VxdWVudCBwYXRjaGVzIG9uCj4gYSBwZXIgc3Vic3lzdGVtIGJhc2lzLgo+Cj4gQ28tZGV2
ZWxvcGVkLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGtlcm5lbC5vcmc+Cj4gU2lnbmVkLW9mZi1i
eTogTmlrbGFzIFNjaG5lbGxlIDxzY2huZWxsZUBsaW51eC5pYm0uY29tPgoKPiAgYXJjaC9tNjhr
L0tjb25maWcgICAgICAgfCAxICsKCkFja2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0
QGxpbnV4LW02OGsub3JnPgoKR3J7b2V0amUsZWV0aW5nfXMsCgogICAgICAgICAgICAgICAgICAg
ICAgICBHZWVydAoKLS0gCkdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGlu
dXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcKCkluIHBlcnNvbmFsIGNvbnZl
cnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBC
dXQKd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVy
IiBvciBzb21ldGhpbmcgbGlrZSB0aGF0LgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC0tIExpbnVzIFRvcnZhbGRzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVt
Cg==
