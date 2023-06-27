Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB4DEB64D9
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 19:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NUsvqYjZ1HszbrZSPL1e08G1ZO7yq4wOaxwkBgPEA2k=; b=EcvLuK3QNs0X95
	RqoMrX4xWeBwsDGofqPxffWlc2oOb7zYQhhctWLu/eYUKy97weWHl2bCqCaPYYbSDb604K4uTkbSn
	+QZrz+4lwOzAUzs7ktTEeMSdtXB4dgt9G6z+trzGtJFbwnq1xdEg8JOnFtrBjZJb88uzxd1b21HFp
	yWkNaH0F14NmPAOOKr5GfBGaRA+1x+d6cjTNgllCV7+mzY5wdqsnY3yA2wWaaekk/Zr+dmAvWbrWL
	T+bRg6kQ7rBf7RpoC02am/7rUvcf7cciwPELaZkTVKgF1nVsrm7cvbfMbgts2LHCu6F4iSvL8AidF
	u7Khma6BaN0R7FoCVgUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEE58-00DuVP-0V;
	Tue, 27 Jun 2023 19:10:30 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEE53-00DuTP-2O;
	Tue, 27 Jun 2023 19:10:27 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-553a1f13d9fso3994078a12.1;
        Tue, 27 Jun 2023 12:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687893024; x=1690485024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yS/xmFpqe6+k8T+yWQv7frf8UxF7B6Cm+1CNfhqUPlA=;
        b=BMqSkVfZP75OxNlOqvaghKGJv9m0y4sm8KFw5SHceiXFQz/e0SiiKJT9I5B52iAH17
         cMt4KC2GjU9iq0SnaoF95JUsMa0mk+JEcq2FkRIOzoow88IvYkDfH7aBL3K5PbCOKOue
         txhLzT7BLkzfYn4DxxqSwsZ2KmDA6ILNOIWpC3UOJTW+EHWbeQQdlcmGoaBUyJofM5AY
         lnVmBNLdubBt20V6jFfi37xAvQhhTT8MryCyACblmLywm5IjXVYJCWSIUi3pbGc+j98S
         r4FtzORgbma5+HwlZ2RT9hRW9y3a8jxCdKlGNGBWvRri5+DzenA7COAJXTL5/EtGEK0g
         cong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687893024; x=1690485024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yS/xmFpqe6+k8T+yWQv7frf8UxF7B6Cm+1CNfhqUPlA=;
        b=Es5BrPU0cfZ9rkWrmhEyl/1y7JgS+Rq47RJ3v48XOu0uY7FW6IPwJh5Okqc9WRXP8/
         GlvVI8etdNXeCUKH8GYLMONvHYjdRiDp/+8QKVtMUW4YDj+xHGKwE47xTTa1bhvroYi5
         bXxkncv3RF3PYcGRNcgQiyYstWNFwR9+A6EWlEl7vQpb7wPhFdKn+7EH6QYxOqKtYNhh
         61ISLnIrg7bi6pGHnI+4ZeZwq+EKxLAyz6Iv2NnoONHaD18kw6VGIvI4J4XKLR7rcBpp
         YBOws9XxGFfvhn7jXw3ZlIHo+9Expz6MefFDNkRChMQ2Xl0pZsYTj9/O//2eagfdemoq
         GK4Q==
X-Gm-Message-State: AC+VfDyLslJx/f9w/+o1+9yEf6sH/B8GY4wZtykqlEjJxLznTMX+LdCp
	Re5BzoiAN0lsKyVg9CHkojo=
X-Google-Smtp-Source: ACHHUZ4TyTsIrCRAZ6UdXT5Omt1I9QGIq3lGO+AmEbof8hKm4unG6pcuoo4CdZZ1APibznjic8nqlQ==
X-Received: by 2002:a17:90a:3cc6:b0:262:df8e:fcb6 with SMTP id k6-20020a17090a3cc600b00262df8efcb6mr9240150pjd.43.1687893024298;
        Tue, 27 Jun 2023 12:10:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n91-20020a17090a5ae400b002471deb13fcsm6684270pji.6.2023.06.27.12.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 12:10:23 -0700 (PDT)
Message-ID: <cc954b15-63ab-9d9f-2d37-1aea78b7f65f@roeck-us.net>
Date: Tue, 27 Jun 2023 12:10:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Content-Language: en-US
To: Vishal Moola <vishal.moola@gmail.com>
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
 Hugh Dickins <hughd@google.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Mike Rapoport <rppt@kernel.org>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
 <20230622205745.79707-27-vishal.moola@gmail.com>
 <13bab37c-0f0a-431a-8b67-4379bf4dc541@roeck-us.net>
 <CAOzc2px6VutRkMUTn+M5LFLf1YbRVZFgJ=q7StaApwYRxUWqQA@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAOzc2px6VutRkMUTn+M5LFLf1YbRVZFgJ=q7StaApwYRxUWqQA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_121025_776102_5ACC9594 
X-CRM114-Status: GOOD (  14.42  )
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

T24gNi8yNy8yMyAxMDo0MiwgVmlzaGFsIE1vb2xhIHdyb3RlOgo+IE9uIE1vbiwgSnVuIDI2LCAy
MDIzIGF0IDEwOjQ34oCvUE0gR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0PiB3cm90
ZToKPj4KPj4gT24gVGh1LCBKdW4gMjIsIDIwMjMgYXQgMDE6NTc6MzhQTSAtMDcwMCwgVmlzaGFs
IE1vb2xhIChPcmFjbGUpIHdyb3RlOgo+Pj4gUGFydCBvZiB0aGUgY29udmVyc2lvbnMgdG8gcmVw
bGFjZSBwZ3RhYmxlIGNvbnN0cnVjdG9yL2Rlc3RydWN0b3JzIHdpdGgKPj4+IHB0ZGVzYyBlcXVp
dmFsZW50cy4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBWaXNoYWwgTW9vbGEgKE9yYWNsZSkgPHZp
c2hhbC5tb29sYUBnbWFpbC5jb20+Cj4+PiBBY2tlZC1ieTogTWlrZSBSYXBvcG9ydCAoSUJNKSA8
cnBwdEBrZXJuZWwub3JnPgo+Pgo+PiBUaGlzIHBhdGNoIGNhdXNlcyBhbGwgbmlvczIgYnVpbGRz
IHRvIGZhaWwuCj4gCj4gSXQgbG9va3MgbGlrZSB5b3UgdHJpZWQgdG8gYXBwbHkgdGhpcyBwYXRj
aCBvbiBpdHMgb3duLiBUaGlzIHBhdGNoIGRlcGVuZHMKPiBvbiBwYXRjaGVzIDAxLTEyIG9mIHRo
aXMgcGF0Y2hzZXQgdG8gY29tcGlsZSBwcm9wZXJseS4gSSd2ZSBjcm9zcy1jb21waWxlZAo+IHRo
aXMgYXJjaGl0ZWN0dXJlIGFuZCBpdCB3b3JrZWQsIGJ1dCBsZXQgbWUga25vdyBpZiBzb21ldGhp
bmcgZmFpbHMKPiB3aGVuIGl0cyBhcHBsaWVkIG9uIHRvcCBvZiB0aG9zZSBwYXRjaGVzIChvciB0
aGUgcmVzdCBvZiB0aGUgcGF0Y2hzZXQpLgoKCk5vLCBJIGRpZCBub3QgdHJ5IHRvIGFwcGx5IHRo
aXMgcGF0Y2ggb24gaXRzIG93bi4gSSB0cmllZCB0byBidWlsZCB5ZXN0ZXJkYXkncwpwZW5kaW5n
LWZpeGVzIGJyYW5jaCBvZiBsaW51eC1uZXh0LgoKR3VlbnRlcgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51
eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtdW0K
