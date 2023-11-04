Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C698EC4332F
	for <linux-um@archiver.kernel.org>; Sat,  4 Nov 2023 09:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Cc:Date:Message-Id:Subject:
	Mime-Version:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=genO3aSv9sFUm1/5saRN2dxbNhNAydcwaz31EC+62nU=; b=byh
	1HLcPkBAtLcS1lukWA5gk0cbFIbSIyfnXzouKMdQ5YnozVs2QkqfWprMp3dO86th8wfCS8XLGmX7N
	Uo0WbD34oZsz9tDK9q0nn3mFGopT9d7rODn+djfltw8GMjfagzL00cyI09HIWzI0iWmpQo5edUhtP
	muV8CgzymsB+nLUTCqgWFvYZr6HhBTPbJzuSzTSIZM+Tm50AhRmThQu2hdEcvEcmzReLKBXk00u5c
	7KV8jYDdsUXJE6IViFYe86tDlmkL0GtlupuV9c7EHBAotOLae1qPipGvVOEIZcqqFUmktFOYnZ5Ao
	Q8PoDvdRwBvku151PSBKPgBkyPs3wJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qzCud-00CySn-0h;
	Sat, 04 Nov 2023 09:25:51 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qzCua-00CyRr-0o
	for linux-um@lists.infradead.org;
	Sat, 04 Nov 2023 09:25:49 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40836ea8cbaso20569545e9.0
        for <linux-um@lists.infradead.org>; Sat, 04 Nov 2023 02:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699089944; x=1699694744; darn=lists.infradead.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8n8ZiPmB4jr2dMWJOl0l5VVT7a0wTFVPtrw1M6Upy3M=;
        b=CvXYTfNQgtA1CKm26a/GG+V7Xg71ehc2v60hhB5JQc6ycz413zEMxIt6EGMdHFT5Wr
         WRSbpOeUeO1pnb7Tke4oFts5JeMJTURPGJl+QKzmTfRkjfjBHeSUaxf75C0K+5Y6VQU5
         gPowJjHTU/tcrB7WJeXSVSZnmvz2ku7VmAD6/HAa+8AmIliFytMxhuocF4s4X4Exgq9u
         0psyc/aWdGAUuduNCbyf/2pDWgtQO4Q1+qp41jbDiAuo+jay9ovZZ5kZhqgdv69oD1HB
         J4iwhAIizPhWb2GnC4o5yEg03nut8SsM1GpLIutun3poQiuOqyW6nlkd30uzG03qf8vW
         fClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699089944; x=1699694744;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8n8ZiPmB4jr2dMWJOl0l5VVT7a0wTFVPtrw1M6Upy3M=;
        b=OKfonCTzUJjGDVhWW+CoGoTCoy50nFRYoEoEPGGsc9VCKZYpSI3ah5O+xM3vMzjDMn
         AhOoNI9zVg3t7zJyLHw4WivLEAVF6ZWM87SsaOswXcsG3xLJ5ZH/gQ6UZwGcr0vSiIoG
         BUGoAarLJb+LNDExjZI7XeZJaee0LAw0R9DOs3ApNW39LyPhWLf9uh9wSLsc4cUChexD
         BxD9/xTOiqQ7dDx8G6m6ffS1S2QaicuowwK2WgFj8RAKR/HBPVKJIuttkjWIThNWkxfJ
         dkbLgihURmwPHHxw2Zc6ZH5ksISgh2+AHxBm2P3LlivKbDslle2ZnPqWHOhwCbgTBWRf
         McKA==
X-Gm-Message-State: AOJu0YxPhEoQClciYgQoOL7AC8FLOjTmAatM6lhme/ntAdd5i4X8FTor
	Zt5qjM02WqZoaFa8OYATRUO5upN1zUbQmw==
X-Google-Smtp-Source: AGHT+IGJsu2qJKTMPj7eKYmqfk0hAA4wVDY3dIZfG79rYGKOvhpMc409fuZYWkfA7PuZmgNg52Ndrw==
X-Received: by 2002:a05:600c:4f92:b0:402:f55c:faee with SMTP id n18-20020a05600c4f9200b00402f55cfaeemr18964536wmq.26.1699089943307;
        Sat, 04 Nov 2023 02:25:43 -0700 (PDT)
Received: from smtpclient.apple ([77.137.74.70])
        by smtp.gmail.com with ESMTPSA id du15-20020a05600c634f00b00405959bbf4fsm5009150wmb.19.2023.11.04.02.25.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Nov 2023 02:25:42 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Missing clobber on alternative use on Linux UM 32-bit
Message-Id: <24BD0906-C6FE-499C-9A4A-00C56E6EE84A@gmail.com>
Date: Sat, 4 Nov 2023 11:25:31 +0200
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
To: Richard Weinberger <richard@nod.at>,
 linux-um@lists.infradead.org
X-Mailer: Apple Mail (2.3731.700.6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231104_022548_290346_94F5C45A 
X-CRM114-Status: UNSURE (   8.35  )
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

SSB3YXMgcmVhZGluZyAoYWdhaW4pIHRoZSB4ODYgQyBtYWNybyBvZiDigJxhbHRlcm5hdGl2ZSgp
4oCdIGFuZCBJIHdhcyBhIGJpdApzdXJwcmlzZWQgaXQgZG9lcyBjbG9iYmVyIHRoZSBmbGFncyAo
4oCcY2PigJ0pIGFzIGEgcHJlY2F1dGlvbi4KCiAgI2RlZmluZSBhbHRlcm5hdGl2ZShvbGRpbnN0
ciwgbmV3aW5zdHIsIGZ0X2ZsYWdzKSBcCglhc21faW5saW5lIHZvbGF0aWxlIChBTFRFUk5BVElW
RShvbGRpbnN0ciwgbmV3aW5zdHIsIGZ0X2ZsYWdzKSA6IDogOiAibWVtb3J5IikKCkFjdHVhbGx5
IHRoZXJlIHNlZW1zIHRvIGJlIG9ubHkgb25lIGluc3RhbmNlIG9mIHByb2JsZW1hdGljIGNhc2Vz
IC0gaW4gdW0vMzItYml0OgoKICAjZGVmaW5lIG1iKCkgYWx0ZXJuYXRpdmUoImxvY2s7IGFkZGwg
JDAsMCglJWVzcCkiLCAibWZlbmNlIiwgWDg2X0ZFQVRVUkVfWE1NMikKICAjZGVmaW5lIHJtYigp
IGFsdGVybmF0aXZlKCJsb2NrOyBhZGRsICQwLDAoJSVlc3ApIiwgImxmZW5jZSIsIFg4Nl9GRUFU
VVJFX1hNTTIpCiAgI2RlZmluZSB3bWIoKSBhbHRlcm5hdGl2ZSgibG9jazsgYWRkbCAkMCwwKCUl
ZXNwKSIsICJzZmVuY2UiLCBYODZfRkVBVFVSRV9YTU0pCgpQcmVzdW1hYmx5LCBpZiBYTU0gb3Ig
WE1NMiBhcmUgbm90IHN1cHBvcnRlZCwgdGhlcmUgd291bGQgYmUgaW5zdGFuY2VzIHdoZXJlIGFk
ZGwKd291bGQgYmUgYWJsZSB0byBjaGFuZ2UgZWZsYWdzIGFyaXRobWV0aWMgZmxhZ3Mgd2l0aG91
dCB0aGUgY29tcGlsZXIgYmVpbmcgYXdhcmUKb2YgaXQuCgpBcyBpdCBvbmx5IGFmZmVjdHMgMzIt
Yml0IExpbnV4IFVNIC0gSSBkb27igJl0IGVhc2lseSBoYXZlIGFuIGVudmlyb25tZW50IHRvIHRl
c3QKdGhlIGZpeC4gQW4gYWx0ZXJuYXRpdmUgKHdvcmQtcHVuIHVuaW50ZW5kZWQpIGlzIHRvIGFk
ZCDigJxjY+KAnSBhcyBhIHByZWNhdXRpb24KdG8gdGhlIGFsdGVybmF0aXZlIG1hY3JvLgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1h
aWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
