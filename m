Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC5ECA0FEC
	for <linux-um@archiver.kernel.org>; Fri,  1 Sep 2023 21:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+oeRfcZFXvarDWkBf6R78XsUZMp+lGv6/6uwlTxRb68=; b=WMnE6ch2ALPXU0
	tOBl1fyXaFJzkbQ752YHYmW5VFMarsGvHn9vPUJTfN4PbKvoaDqg/0MrTuwAOltGm0lEt1L+mKcqM
	FpCrBdH0YTxFmESjJbNCLV0FA2jeYCV2NE+bueNeT4F0pOffozbgD9VUQrB0ki7zI1Ag7adsYnpJR
	7emtQSoFaqWN1v77EThBf8XIF8j2fCbhVmF6d5fd2Eu2RxFFbsHVpnSzH86pBBjBlmBj1HQ2iKpsN
	mrdKKnt/UM+JbE4GRqHDTHmil2CBaUv42mGnjSdS7hSibpAeMWV4hFbWjuSf/3QYfRCpqLUECfEU3
	U7wAhs3dAuULEHwq0V/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qcBOQ-000Or2-0s;
	Fri, 01 Sep 2023 21:09:26 +0000
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qcBOM-000Opy-0H;
	Fri, 01 Sep 2023 21:09:23 +0000
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34df2a961a0so7797085ab.2;
        Fri, 01 Sep 2023 14:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693602560; x=1694207360; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+B2LETBRYo235Gzl9s8FV6KtOjZrwPltfhhztkFxvM=;
        b=ps2+4CvtoqYBgGBvSagffwXfsbFocgneZiHpdW0DXIAg1fDvjlg2EtXSQpMdvLYMXq
         UghFqEPUIj0W0SmhE9VDKp+BY5sljX0wcedqeTBKGDpfMJiraV738V/LjXbB5YhCTlEq
         9VER4Zs8d0pTXRGCgaEt5IESmsaw7fwVHGpB3Sx6xIuSQsT/9OVQVc/vLKD7qzutnsOK
         MhWfOfjW6Yt1tAYlyPFb9qzO8RM1GQSx5zgwJzdAHBd5upxK6DWEbi/4m7t090bnHVgd
         1t3xPcuaWm3jLCtascbcYTmo/+R+d4NHmkuTLocQpGwOwSJKNydeJwbPEeRzPF9q15Iy
         dVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693602560; x=1694207360;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+B2LETBRYo235Gzl9s8FV6KtOjZrwPltfhhztkFxvM=;
        b=MwFPatuI9RkphCDlZZhDTq9Qk5VVS46d0M70FIj6EHxmdIki+zIxEHpXbAcwSQvSTL
         a9CfoclOxq5zgJjjG3UEcJZqfnzUFwQntm9bXnZKJihnN0duUTW2Dnb3XhYQEAVhneHk
         hzi2VffcbfUbGhbfP1e8dRafjnS5j2/BpSInixo/25SCOYOAtKTIPVxZ/fiRKP8OqgKH
         GBLgbtgAKavgr+adkY2n6O1grYSUvYtc1VmlC/oHoUEXqzfWTTqNWJw+jaGIjf+Crljr
         hc3wWvy4K4FjHU6lHwNBSNySTwHVn8Ix1QYmZOU5e9lLN/N/kdduvdrV+L0MZWmLgWgL
         k/JA==
X-Gm-Message-State: AOJu0YyigwXYAbx1rdoTzajKiy2yuOZoe2qFWHNu8uNpDUtrv8kbuLtQ
	sVC0+F0c+i0NYh/bxfiCIBM=
X-Google-Smtp-Source: AGHT+IFbTKv1w6p0/+A5JTx82UybC+0oJ7K12y3+bx6yQvYDtzUEGH7puVOtPVweviTp68q8AP2PlQ==
X-Received: by 2002:a05:6e02:1062:b0:34c:cf1f:2a27 with SMTP id q2-20020a056e02106200b0034ccf1f2a27mr4042401ilj.0.1693602559809;
        Fri, 01 Sep 2023 14:09:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f11-20020a056638118b00b0042bb2448847sm1257257jas.53.2023.09.01.14.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 14:09:18 -0700 (PDT)
Date: Fri, 1 Sep 2023 14:09:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	Richard Henderson <richard.henderson@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Chris Zankel <chris@zankel.net>,
	Tom Lendacky <thomas.lendacky@amd.com>, semenzato@google.com
Subject: Re: [patch 17/17] x86/fpu: Move FPU initialization into
 arch_cpu_finalize_init()
Message-ID: <e0399977-5978-42cd-82cb-67b81f285498@roeck-us.net>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.902376621@linutronix.de>
 <ba1b11e5-b3f0-457b-8920-d57d470626c3@roeck-us.net>
 <6a09294e-2c07-585b-336b-20d07e7e08ba@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a09294e-2c07-585b-336b-20d07e7e08ba@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230901_140922_150470_795FEB69 
X-CRM114-Status: GOOD (  28.44  )
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

T24gRnJpLCBTZXAgMDEsIDIwMjMgYXQgMDk6MDI6MTlQTSArMDMwMCwgTmlrb2xheSBCb3Jpc292
IHdyb3RlOgo+IAo+IAo+IE9uIDEuMDkuMjMg0LMuIDIwOjMwINGHLiwgR3VlbnRlciBSb2VjayB3
cm90ZToKPiA+IEhpLAo+ID4gCj4gPiBPbiBXZWQsIEp1biAxNCwgMjAyMyBhdCAwMTozOTo0NkFN
ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6Cj4gPiA+IEluaXRpYWxpemluZyB0aGUgRlBV
IGR1cmluZyB0aGUgZWFybHkgYm9vdCBwcm9jZXNzIGlzIGEgcG9pbnRsZXNzCj4gPiA+IGV4ZXJj
aXNlLiBFYXJseSBib290IGlzIGNvbnZvbHV0ZWQgYW5kIGZyYWdpbGUgZW5vdWdoLgo+ID4gPiAK
PiA+ID4gTm90aGluZyByZXF1aXJlcyB0aGF0IHRoZSBGUFUgaXMgc2V0IHVwIGVhcmx5LiBJdCBo
YXMgdG8gYmUgaW5pdGlhbGl6ZWQKPiA+ID4gYmVmb3JlIGZvcmtfaW5pdCgpIGJlY2F1c2UgdGhl
IHRhc2tfc3RydWN0IHNpemUgZGVwZW5kcyBvbiB0aGUgRlBVIHJlZ2lzdGVyCj4gPiA+IGJ1ZmZl
ciBzaXplLgo+ID4gPiAKPiA+ID4gTW92ZSB0aGUgaW5pdGlhbGl6YXRpb24gdG8gYXJjaF9jcHVf
ZmluYWxpemVfaW5pdCgpIHdoaWNoIGlzIHRoZSBwZXJmZWN0Cj4gPiA+IHBsYWNlIHRvIGRvIHNv
Lgo+ID4gPiAKPiA+ID4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UuCj4gPiA+IAo+ID4gPiBUaGlzIGFs
bG93cyB0byByZW1vdmUgcXVpdGUgc29tZSBvZiB0aGUgY3VzdG9tIGVhcmx5IGNvbW1hbmQgbGlu
ZSBwYXJzaW5nLAo+ID4gPiBidXQgdGhhdCdzIHN1YmplY3QgdG8gdGhlIG5leHQgaW5zdGFsbG1l
bnQuCj4gPiA+IAo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGlu
dXRyb25peC5kZT4KPiA+IAo+ID4gVGhlIGJhY2twb3J0IG9mIHRoaXMgcGF0Y2ggaW50byBjaHJv
bWVvcy01LjEwIGFuZCBjaHJvbWVvcy01LjE1IHZpYSBzdGFibGUKPiA+IHJlbGFzZSBtZXJnZXMg
aXMgY2F1c2luZyB2YXJpb3VzIENocm9tZWJvb2tzIChub3QgYWxsIG9mIHRoZW0pIHRvIGNyYXNo
Cj4gPiBlYXJseSBkdXJpbmcgYm9vdC4gU3Vic2VxdWVudCBmaXhlcyBoYXZlIG5vdCBhZGRyZXNz
ZWQgdGhlIHByb2JsZW0gZm9yIHVzLAo+ID4gc28gd2UgYWxyZWFkeSByZXZlcnRlZCB0aGUgcGF0
Y2ggZnJvbSBjaHJvbWVvcy01LjE1IGFuZCB3aWxsIHJldmVydCBpdAo+ID4gZnJvbSBjaHJvbWVv
cy01LjEwIGFzIHdlbGwuCj4gPiAKPiA+IEkgZG9uJ3Qga25vdyBpZiB0aGlzIGlzIGEgQ2hyb21l
Ym9vayBzcGVjaWZpYyBwcm9ibGVtLCBvciBpZiBpdCBhZmZlY3RzCj4gPiBtYWlubGluZSwgc28g
dGhpcyBpcyBqdXN0IGEgaGVhZHMtdXAgaW4gY2FzZSBvdGhlcnMgZXhwZXJpZW5jZSBzaW1pbGFy
Cj4gPiBwcm9ibGVtcy4KPiAKPiAKPiBBbm90aGVyIHRoaW5nIC0gaWYgeW91IGNob29zZSB0byBy
ZXZlcnQgdGhlIGFyY2hfZmluYWxpemUgcGF0Y2ggdGhlbiBiZWFyIGluCj4gbWluZCB0aGF0IHRo
ZSBHRFMnICdmb3JjZScgb3B0aW9uIGlzIHJlbmRlcmVkIGlub3BlcmFibGUgYXMgdGhlIEZQVSBj
YW4ndCBiZQo+IGRpc2FibGVkIGR1ZSB0byB0aGUgd2F5IHRoaW5ncyBhcmUgc2VxdWVuY2VkLgoK
SSB1bmRlcnN0YW5kLCBidXQgdGhhdCBpcyBzdGlsbCBiZXR0ZXIgdGhhbiBub3QgYmVpbmcgYWJs
ZSB0byBib290CmluIHRoZSBmaXJzdCBwbGFjZS4KClRoYW5rcywKR3VlbnRlcgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBs
aXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
