Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBCBEB64DC
	for <linux-um@archiver.kernel.org>; Sun, 25 Jun 2023 21:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SLa/tYd43SBSSoXAcWsLmU2j2d3TG8ibNPTxuKnMfPE=; b=vyGHXrSHDJrUDC
	IwMaqg4aHidk8pu0DKJq1xsFeQ7AewhS3zfyVqHPhkY5LmH+n1VvNfWtob56KT91lDJGSqAtZW+ho
	zxV/5a7bx5UH4ZScGej+wfeL8XauVfq4SYkGsM4cziVaK1yPJuZnSynnedgz3Nv//qv7diG7Rxnj+
	3E15SU5bRrlotjJGMuP1uriE//fHwEU4ar96BTT8nPMrYBQ1pDAVar2rCbnM74Ln1A19HU46DR+QM
	j0mJnSw/LbR5y/1navl0H6k1fBlzrXH8F/arBdA8ANmgstRPqzGi9S7iW8N0bkOwTJe4D7CrtREsv
	MzUIprLIilDlDevLaydA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDXJN-008l0E-31;
	Sun, 25 Jun 2023 21:30:21 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDXJL-008kzR-1Y
	for linux-um@lists.infradead.org;
	Sun, 25 Jun 2023 21:30:20 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-313e34ab99fso1760251f8f.1
        for <linux-um@lists.infradead.org>; Sun, 25 Jun 2023 14:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687728618; x=1690320618;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EcnTTGBAqpAm5D3Elr1glpOYMiW+4bgHgvzEAQrmcQY=;
        b=fAXrLNrfnyoOPjnEvjXEI+OjJmCyRiEgVoG1odNdEMY6GoGvJ7PL9XVhhyOcZ1eBac
         tTGoi+N0UGZ4xwTx3j9A+UvlpHt+fp/AxSyMgGt6uXe5kA1AhgiFo+0EzAf3yU0EC/by
         jy0I7FmHOyV/fs5+WcmJC1mm5E1jrpHroEVV0qM7OMkVEKa8C+3PRicpu326Wu2gkTRn
         IrIWaerX03psSILBHhjYq36x7Wkt7s8eb/XFuQUtWxJEsLzrMSJLittJBom1wOVwTaen
         f9QrVhy1PriMh9OEW01TLhdSEWU118Ku0aoWey63Ad2JFKRIa8uC5uyjdOB3el1sqtpl
         b36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687728618; x=1690320618;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcnTTGBAqpAm5D3Elr1glpOYMiW+4bgHgvzEAQrmcQY=;
        b=dm0IxSzDaiZib75PmIrTYgLbSzoNwbfmvMCIsHTvfqHldpfsLQv+zrCAfEXSOdFhSX
         X7Yt3AVKTWHyKD5ZoApxWLhWp6lsNYnpZ72rvZ5PTW/E6Bqd65TTO2/kHjuMFuofvNNS
         sxvwjkDD/S6NVAzyax+1egoT0PFGS3MVXA2BA2wqtAQ3zcFFDzJd5sorhwm9YUK0PRMV
         KqT5Htv3u25dOiBwGZuuVI2iNqlulbXdVGTCzLZg3oiyRiTnXl+eLR5S/OkVDUIN0Uwj
         hv1YMJEOQXbEfNFVRVp/+fAQmDrh/jqBHmxfpZvnXk/8IwMxJvc/fm7dKbtqnaL7BLsU
         8q7Q==
X-Gm-Message-State: AC+VfDxAIUAz2sO9GDaKim8WV3Q9qjYPOWhFZDfZlRaepNZ0DmHPXgol
	ICtcEdIYO04kwLONRLD7op01Ow==
X-Google-Smtp-Source: ACHHUZ6KQEEqDFyuJxGetBpNk+eqM4UhYKbGbc60Xr1JjWZq7aigGHgry/VOh6CEh38+Iofl/XWbJw==
X-Received: by 2002:a5d:630a:0:b0:313:ece6:834a with SMTP id i10-20020a5d630a000000b00313ece6834amr2532958wru.30.1687728618151;
        Sun, 25 Jun 2023 14:30:18 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.212.184])
        by smtp.gmail.com with ESMTPSA id d3-20020adfe843000000b00311334c7fabsm5452892wrn.16.2023.06.25.14.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 14:30:17 -0700 (PDT)
Message-ID: <8365a865-c9d0-43bc-2de6-91c43aaaa3fb@linaro.org>
Date: Sun, 25 Jun 2023 23:30:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [patch 09/17] sparc/cpu: Switch to arch_cpu_finalize_init()
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 Richard Henderson <richard.henderson@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Chris Zankel <chris@zankel.net>,
 Tom Lendacky <thomas.lendacky@amd.com>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.431995857@linutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230613224545.431995857@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230625_143019_522247_0AB4137E 
X-CRM114-Status: GOOD (  10.00  )
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
LmRlPgo+IENjOiAiRGF2aWQgUy4gTWlsbGVyIiA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4KPiBDYzog
c3BhcmNsaW51eEB2Z2VyLmtlcm5lbC5vcmcKPiAtLS0KPiAgIGFyY2gvc3BhcmMvS2NvbmZpZyAg
ICAgICAgICAgIHwgICAgMSArCj4gICBhcmNoL3NwYXJjL2luY2x1ZGUvYXNtL2J1Z3MuaCB8ICAg
MTggLS0tLS0tLS0tLS0tLS0tLS0tCj4gICBhcmNoL3NwYXJjL2tlcm5lbC9zZXR1cF8zMi5jICB8
ICAgIDcgKysrKysrKwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDE4IGRl
bGV0aW9ucygtKQoKUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRA
bGluYXJvLm9yZz4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
