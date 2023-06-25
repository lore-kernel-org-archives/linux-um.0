Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF29C001DC
	for <linux-um@archiver.kernel.org>; Sun, 25 Jun 2023 21:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5FGXTqlVmJ2lUymM08axUwnNrVIaTTIY1OSQSgM1B1E=; b=2xuol9e/R8GEm7
	JYgHyezy+QLKhQSGsxBDH/35wcHB+4q4aoyaYCGlj0HmM+eSLosiDR055/gbnNUUkdcGXdHoW9VVi
	gLh9MezUGkYWrSOJXMns+Trxgk310dkanc1+ZVDaYoKyYEE1GzBgpEBT/QJ+RdZDbilq9qVk9b4gk
	A/JHzXAVxdlji7ghlG1L7HQ0Y0j2TvT0evL6i7y1ROiJbsy30IM7GcnUMTBy77R/1QNJboi/4Q6h0
	g2Dpwp6yqk30B3ERBUQ9EVKHaY49r/9p2RSYCHtXu+riouVaG1bZOAlZ1IG8kCi4UaZFbP6KFSAou
	ya/5WoxpxBFr1yDpcIjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDXKY-008lAO-0d;
	Sun, 25 Jun 2023 21:31:34 +0000
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDXKV-008l98-1Y
	for linux-um@lists.infradead.org;
	Sun, 25 Jun 2023 21:31:32 +0000
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f86dbce369so3191681e87.0
        for <linux-um@lists.infradead.org>; Sun, 25 Jun 2023 14:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687728689; x=1690320689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+vBar4+CLR6TDQyNZjkELXTZBE9ucLGNyisqXCBp0c=;
        b=XnMKcu+DvVFFbNAPJoejCymxEHLsfGVjBJp8rhLjxmEH5gQg7SJJcO+T4kI0Y1n4Ly
         DU29CCkOZ/qBV0orbhS7JzmbJXaqo7Kep/2Spa7d6DqMEFuDUS20nY9chPmUXmfx6ijH
         bh4MfJ8MZYSx7pyFUNPBY0+iI64YBhhpgwD/ABzWgORbM9LN+uhFFyqfaiD1n34x9Ct3
         2u5frIDAbQ+p9EBcGuQhbG6YAZsfEv2Ltf472clzoj6EWWRIM30CfCXqEheLJd3209C9
         nE86N9MZS8o7KuH/5kcFzTTMO8SsyMKe732GFM2hHEok7qTCkimlzvoxg+LY/lDe0AxU
         GNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687728689; x=1690320689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+vBar4+CLR6TDQyNZjkELXTZBE9ucLGNyisqXCBp0c=;
        b=f1ZKwMpcUY/gmrxLihgIBU92zvR8yObSp0SGSzhyABK6++NCTVBdp/HhDFxIyUiLz+
         seIx0OS5Dg2lEb3WIMbqgbWEpMnuom/0zOXRjUYLGrbf5t/zf4909tNuQTWP5WGTiPb6
         XJjHM8EF+rNURJYLWm5mMit32tUpnyiAGpvrv9BEotH0PcXRu9mQ4KVn0g59HuAjKZ9W
         IcbKfSwrYZ9w/qc58DHAufTrnr7u2g2pzO6BytQmjSEeSEwmFNxeJWbEuK800YpGJh17
         9oCO3XlA5pwf1ipAie7B6bvutVHUVCZSpzvb7l7DrEGWHfQuWxi3e/H2Kz0BaACUn0vt
         C7jQ==
X-Gm-Message-State: AC+VfDzpa7tm8NU1AOxYC31WU2awCRRvyqGIkrw+JrUeu2QutjTS6QMi
	3M9gHrOjh3wwPi3yKLQuaFhfLA==
X-Google-Smtp-Source: ACHHUZ4ueF7pB37Kjx3og+hVW79MU4Pnt3oR5acFEBC4M80kOtrhpKljcmf7bk4yPZDdm8+PgN44JQ==
X-Received: by 2002:a05:6512:10ca:b0:4f9:6b64:9a36 with SMTP id k10-20020a05651210ca00b004f96b649a36mr6138182lfg.62.1687728689066;
        Sun, 25 Jun 2023 14:31:29 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.212.184])
        by smtp.gmail.com with ESMTPSA id y12-20020a05600c364c00b003f7f249e7dfsm8710877wmq.4.2023.06.25.14.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 14:31:28 -0700 (PDT)
Message-ID: <3849d2e3-43d7-4059-aead-fd78ded3b475@linaro.org>
Date: Sun, 25 Jun 2023 23:31:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [patch 11/17] init: Remove check_bugs() leftovers
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Chris Zankel <chris@zankel.net>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 Tom Lendacky <thomas.lendacky@amd.com>
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.553215951@linutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230613224545.553215951@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230625_143131_520264_5CF11B79 
X-CRM114-Status: UNSURE (   9.05  )
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

T24gMTQvNi8yMyAwMTozOSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOgo+IEV2ZXJ5dGhpbmcgaXMg
Y29udmVydGVkIG92ZXIgdG8gYXJjaF9jcHVfZmluYWxpemVfaW5pdCgpLiBSZW1vdmUgdGhlCj4g
Y2hlY2tfYnVncygpIGxlZnRvdmVycyBpbmNsdWRpbmcgdGhlIGVtcHR5IHN0dWJzIGluIGFzbS1n
ZW5lcmljLCBhbHBoYSwKPiBwYXJpc2MsIHBvd2VycGMgYW5kIHh0ZW5zYS4KPiAKPiBTaWduZWQt
b2ZmLWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4KPiBDYzogUmljaGFy
ZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+Cj4gQ2M6ICJKYW1lcyBF
LkouIEJvdHRvbWxleSIgPEphbWVzLkJvdHRvbWxleUBIYW5zZW5QYXJ0bmVyc2hpcC5jb20+Cj4g
Q2M6IE1pY2hhZWwgRWxsZXJtYW4gPG1wZUBlbGxlcm1hbi5pZC5hdT4KPiBDYzogQ2hyaXMgWmFu
a2VsIDxjaHJpc0B6YW5rZWwubmV0Pgo+IC0tLQo+ICAgYXJjaC9hbHBoYS9pbmNsdWRlL2FzbS9i
dWdzLmggICB8ICAgMjAgLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgIGFyY2gvcGFyaXNjL2luY2x1
ZGUvYXNtL2J1Z3MuaCAgfCAgIDIwIC0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gICBhcmNoL3Bvd2Vy
cGMvaW5jbHVkZS9hc20vYnVncy5oIHwgICAxNSAtLS0tLS0tLS0tLS0tLS0KPiAgIGFyY2gveHRl
bnNhL2luY2x1ZGUvYXNtL2J1Z3MuaCAgfCAgIDE4IC0tLS0tLS0tLS0tLS0tLS0tLQo+ICAgaW5j
bHVkZS9hc20tZ2VuZXJpYy9idWdzLmggICAgICB8ICAgMTEgLS0tLS0tLS0tLS0KPiAgIGluaXQv
bWFpbi5jICAgICAgICAgICAgICAgICAgICAgfCAgICA1IC0tLS0tCj4gICA2IGZpbGVzIGNoYW5n
ZWQsIDg5IGRlbGV0aW9ucygtKQoKWWF5IQoKUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LXVtCg==
