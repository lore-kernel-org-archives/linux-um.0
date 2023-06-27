Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C7CC04A6A
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 21:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C1CFjYlTwJVewzRfn+2Fs813IvB2Znn3idZGfSGk5oM=; b=sHNt4JdvoI2YRC
	Tr0CQRg5QAxjZDXwIQW5jcRQHOAlDo5isusqOcX8f3Ri7GlTRhVEO86i+6UNFErqkSVGkTtpXdd1K
	NFrvDrnHi/IaL140NcvqBVZrvYBg+zR+1IFo1sr1O3P46fgaHgf3Y6hd/NAVVZwBADBWE+7QQ7kUp
	991BIqEx/7Q0TmUxoYKRMlMvi3r1WWxoxI6Dg3L+27JGwqBLnSxztyPpZrEpBTN79/ttXmn3qeMui
	Aagw2jrURnsT9G2ikv4RCx0wN4foHRzumAx9qjZ3mawZcumKYUpBxWQ/wbXH46bxUB+slLy8ywHBe
	ETG2G2XHYbWYkPt3db7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEFoh-00E9XO-1a;
	Tue, 27 Jun 2023 21:01:39 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEFod-00E9VP-2I;
	Tue, 27 Jun 2023 21:01:37 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b80f2e6c17so18055175ad.0;
        Tue, 27 Jun 2023 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687899692; x=1690491692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=P+M7tEnjJDtu150UIK78eMZjmbGUtM7e5Fjt8nWZ0yk=;
        b=EEAFfmkXxvxLQKSckNGd2ZSV3KFogeID+Fu07F5vObGax9BbbGTHMjNPkWpqJAJVcH
         pQvHfFi3MuvS2en7hgib7UJpPWUapwBCg8rlberKLmSq3DFWM7/xIZN7INLmmqEHLsUh
         qitezyDQfhSscafezpHggVgt0WLI8tgIl0uMXCJdPAHvlcj4VIjJKb6j7/ZGCnIDizgv
         wo2zP75PWYpQesW5XMNkIMNlUWOk9aqZVrMomyrANyuVHFRGKdh0f6XzxRPe0kewrYvm
         0KzGKCqgMKcTqBBhxX7lyhj56QxI4SK/fKCSdPeLy85gsmtVFv88cBuoZEpsI4YCe97K
         o/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687899692; x=1690491692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+M7tEnjJDtu150UIK78eMZjmbGUtM7e5Fjt8nWZ0yk=;
        b=MiVpPoFC2fwg9vJpbA2nyQ2EQXYht1sHmGCmnWiFtPMYGcPr/BUA/Z9RDsCCYiRFBe
         E9fZI05HDrvwmJzB0URNBzlDm+bS/fGeI0yqkX6qXWQtr1wYGnhjGkToCh3lKgNix6zu
         HMhjyJOsO7wC1SK7noGMj10377GM0F35et6ZObRvwpLeKlqkrYpgGwq4/32LveRmnT1X
         2Zrmt8UlUOXITom5FI3OF2wWB4cBonVt9sl+dxIoz6XYurj5BvKYw236w0wc/qoUiD2n
         kpTMpuOO6hVmAMX3sJsJlIix0QV4tk1Ob3zjmMlgZNBEQ3DraW6XVzjJY7gKMaHQakIA
         xNkQ==
X-Gm-Message-State: AC+VfDwt/xoSMpAhpqodWGbHa4tkqn51I9TzzA5uModcNkigsRLZTlpk
	X4p5Wstmom2i27qrVpwI9QA=
X-Google-Smtp-Source: ACHHUZ5Ms+IS+/rtXxolIJxIsutHi1fnnUiL8cEAZTZ1vZL/Fg4JF6S5Mmuw32zf0DumOU0QNMHuig==
X-Received: by 2002:a17:902:f542:b0:1b5:91:4693 with SMTP id h2-20020a170902f54200b001b500914693mr14752161plf.1.1687899692466;
        Tue, 27 Jun 2023 14:01:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jl3-20020a170903134300b001ac6b926621sm6363521plb.292.2023.06.27.14.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 14:01:31 -0700 (PDT)
Message-ID: <2b7e8b1d-1697-6a25-434d-352f95e6fff2@roeck-us.net>
Date: Tue, 27 Jun 2023 14:01:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Content-Language: en-US
To: Dinh Nguyen <dinguyen@kernel.org>, Vishal Moola <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
 <20230622205745.79707-27-vishal.moola@gmail.com>
 <13bab37c-0f0a-431a-8b67-4379bf4dc541@roeck-us.net>
 <CAOzc2px6VutRkMUTn+M5LFLf1YbRVZFgJ=q7StaApwYRxUWqQA@mail.gmail.com>
 <cc954b15-63ab-9d9f-2d37-1aea78b7f65f@roeck-us.net>
 <b6a5753b-8874-6465-f690-094ee753e038@roeck-us.net>
 <CAOzc2pxdqeaRjYLfOqvMW-AEobTzD9xOP+MyP9nxgEbi1T2r7Q@mail.gmail.com>
 <c3751051-7fc7-7129-b9a7-ead71c576ace@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <c3751051-7fc7-7129-b9a7-ead71c576ace@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_140135_746322_C083FCD9 
X-CRM114-Status: GOOD (  19.70  )
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

T24gNi8yNy8yMyAxMzowNSwgRGluaCBOZ3V5ZW4gd3JvdGU6Cj4gCj4gCj4gT24gNi8yNy8yMyAx
NDo1NiwgVmlzaGFsIE1vb2xhIHdyb3RlOgo+PiBPbiBUdWUsIEp1biAyNywgMjAyMyBhdCAxMjox
NOKAr1BNIEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVzLm5ldD4gd3JvdGU6Cj4+Pgo+Pj4g
T24gNi8yNy8yMyAxMjoxMCwgR3VlbnRlciBSb2VjayB3cm90ZToKPj4+PiBPbiA2LzI3LzIzIDEw
OjQyLCBWaXNoYWwgTW9vbGEgd3JvdGU6Cj4+Pj4+IE9uIE1vbiwgSnVuIDI2LCAyMDIzIGF0IDEw
OjQ34oCvUE0gR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0PiB3cm90ZToKPj4+Pj4+
Cj4+Pj4+PiBPbiBUaHUsIEp1biAyMiwgMjAyMyBhdCAwMTo1NzozOFBNIC0wNzAwLCBWaXNoYWwg
TW9vbGEgKE9yYWNsZSkgd3JvdGU6Cj4+Pj4+Pj4gUGFydCBvZiB0aGUgY29udmVyc2lvbnMgdG8g
cmVwbGFjZSBwZ3RhYmxlIGNvbnN0cnVjdG9yL2Rlc3RydWN0b3JzIHdpdGgKPj4+Pj4+PiBwdGRl
c2MgZXF1aXZhbGVudHMuCj4+Pj4+Pj4KPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBWaXNoYWwgTW9v
bGEgKE9yYWNsZSkgPHZpc2hhbC5tb29sYUBnbWFpbC5jb20+Cj4+Pj4+Pj4gQWNrZWQtYnk6IE1p
a2UgUmFwb3BvcnQgKElCTSkgPHJwcHRAa2VybmVsLm9yZz4KPj4+Pj4+Cj4+Pj4+PiBUaGlzIHBh
dGNoIGNhdXNlcyBhbGwgbmlvczIgYnVpbGRzIHRvIGZhaWwuCj4+Pj4+Cj4+Pj4+IEl0IGxvb2tz
IGxpa2UgeW91IHRyaWVkIHRvIGFwcGx5IHRoaXMgcGF0Y2ggb24gaXRzIG93bi4gVGhpcyBwYXRj
aCBkZXBlbmRzCj4+Pj4+IG9uIHBhdGNoZXMgMDEtMTIgb2YgdGhpcyBwYXRjaHNldCB0byBjb21w
aWxlIHByb3Blcmx5LiBJJ3ZlIGNyb3NzLWNvbXBpbGVkCj4+Pj4+IHRoaXMgYXJjaGl0ZWN0dXJl
IGFuZCBpdCB3b3JrZWQsIGJ1dCBsZXQgbWUga25vdyBpZiBzb21ldGhpbmcgZmFpbHMKPj4+Pj4g
d2hlbiBpdHMgYXBwbGllZCBvbiB0b3Agb2YgdGhvc2UgcGF0Y2hlcyAob3IgdGhlIHJlc3Qgb2Yg
dGhlIHBhdGNoc2V0KS4KPj4+Pgo+Pj4+Cj4+Pj4gTm8sIEkgZGlkIG5vdCB0cnkgdG8gYXBwbHkg
dGhpcyBwYXRjaCBvbiBpdHMgb3duLiBJIHRyaWVkIHRvIGJ1aWxkIHllc3RlcmRheSdzCj4+Pj4g
cGVuZGluZy1maXhlcyBicmFuY2ggb2YgbGludXgtbmV4dC4KPj4+Pgo+Pj4KPj4+IEEgcXVpY2sg
Y2hlY2sgc2hvd3MgdGhhdCB0aGUgYnVpbGQgZmFpbHMgd2l0aCBuZXh0LTIwMjMwNjI3LiBTZWUg
bG9nIGJlbG93Lgo+Pgo+PiBBaCBpdCBsb29rcyBsaWtlIHRoaXMgb25lIHNsaXBwZWQgaW50byAt
bmV4dCBvbiBpdHMgb3duIHNvbWVob3c/IFN0ZXBoZW4sIHBsZWFzZQo+PiBkcm9wIHRoaXMgcGF0
Y2ggZnJvbSAtbmV4dDsgaXQgc2hvdWxkbid0IGJlIGluIHdpdGhvdXQgdGhlIHJlc3Qgb2YgdGhl
Cj4+IHBhdGNoc2V0IHdoaWNoCj4+IEkgaW50ZW5kIHRvIGhhdmUgQW5kcmV3IHRha2UgdGhyb3Vn
aCB0aGUgbW0gdHJlZS4KPj4KPiAKPiBJIGFwb2xvZ2l6ZSwgYnV0IEkgcXVldWUgdGhpcyBwYXRj
aCB1cCBmb3IgTGludXMgYW5kIGl0J3MgYmVlbiBwdWxsZWQgZm9yIHRoaXMgbWVyZ2Ugd2luZG93
LiBJIGRpZG4ndCByZWFsaXplIHlvdSB3ZXJlIGdvaW5nIHRvIHRha2UgdGhpcyBwYXRjaHNldCB0
aHJvdWdoIGFub3RoZXIgdHJlZS4KPiAKPiBTb3JyeSBhYm91dCB0aGF0Lgo+IAoKWWVzLCBpbmRl
ZWQsIEkganVzdCBjb25maXJtZWQgdGhhdCBhbGwgbmlvczIgYnVpbGRzIGluIHRoZSBtYWlubGlu
ZSBrZXJuZWwKYXJlIG5vdyBicm9rZW4uCgpHdWVudGVyCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVt
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC11bQo=
