Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5863CD5BC2
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 13:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mw6cx/2WINOr4me/gnwPKXRSE/apEBUdxcmrAKrG8Hs=; b=R88KpvCXxhznqr
	5GllBvIRpTHgIAO+avPsm+821FpFD4WbCYadaTMZGfJwPkN3YYnpqiNEzxkRH8UhsaMk72iMa4Cta
	m2aC5WWH56tuRa2PO9LJZrXkaFqlOQgS1+pK+3u4M8XjoZzQzTWf0JRlQUkENGwbi4JBo5WxI8IEF
	+Z3GlAYQddEW8LlIrUV8x2mtBgm7Uv25oINlZ4t+t25oecbK3x0QaZGA+unFEXXxhVmDa3XVdvAfv
	FPFSqzrX6X/913+8xqad1epWyOK/b3tupFH8xpjhHpZVyr7+WAPbPjV852Dct5inKNG4Ym361eati
	8jZkByM7//b0d3Fms0xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiasH-000Xgo-2z;
	Tue, 19 Sep 2023 13:34:45 +0000
Received: from mail-yw1-f171.google.com ([209.85.128.171])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiasF-000XfM-1a
	for linux-um@lists.infradead.org;
	Tue, 19 Sep 2023 13:34:44 +0000
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59bdad64411so57879947b3.3
        for <linux-um@lists.infradead.org>; Tue, 19 Sep 2023 06:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695130481; x=1695735281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgBzNeouwMIIeGDTMgFICEbkSUZU58KfvTsi1HmIQSU=;
        b=uO+fZVei9u3eXgbmoRq+V9hAp3DJ2e0g3r7XylKi9RxOVRX00HaIHHOJ+c3hOthKg6
         vC9hTxiQQ5Mznu2CUa3IRG1oSuYqDc1tXy991SafYiuG/5sdG34XH5MeDEK1PvdcT3+Q
         L+eVTCedz484B6wPyD3nOGr6T5CdLVIiwihIJBkj3Hi/O8uDibsVeAQGgIjnmx36XMAI
         I4KnMju0nAYE/RQZu0tPGszfpG08R4mvNvWfMyBurF1ZDfofmRauJS9atrp0zsj9EWpi
         YS1siZv/8ueviWcF+ojd3sHLEy2iAmVRdbnjGyJUz/UYXsmp6xy04GQ1NRgxMwgDKxPa
         F9yg==
X-Gm-Message-State: AOJu0Yw2D87tHzoSiRBzf8iBnDZPUrpWXV/kFiDcn/saIdykZNxsLHJg
	A/vTzTu/ApIA1Cbqz0Ra3wJUTXeFJgF+kA==
X-Google-Smtp-Source: AGHT+IFTKuo87++shXZN/PAtdaqG8vRJNYaiSTm83Li4aHbEoAgt1kSKz9n8LPnzlc8A7+4CiXLpRQ==
X-Received: by 2002:a0d:c543:0:b0:592:1bab:52bd with SMTP id h64-20020a0dc543000000b005921bab52bdmr11820274ywd.39.1695130480801;
        Tue, 19 Sep 2023 06:34:40 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id x142-20020a81a094000000b0057d24f8278bsm3129891ywg.104.2023.09.19.06.34.40
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 06:34:40 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59ec6d7bb89so14215227b3.2
        for <linux-um@lists.infradead.org>; Tue, 19 Sep 2023 06:34:40 -0700 (PDT)
X-Received: by 2002:a0d:cc55:0:b0:59b:cb53:ad5a with SMTP id
 o82-20020a0dcc55000000b0059bcb53ad5amr12005299ywd.35.1695130459846; Tue, 19
 Sep 2023 06:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <87edj64rj1.fsf@oracle.com> <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com> <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net> <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net> <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
In-Reply-To: <ZQmbhoQIINs8rLHp@casper.infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Sep 2023 15:34:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXd=jtggL3H4XuBuuNY3QtLDK7Ny=AaSWEjhmRyLwjAGQ@mail.gmail.com>
Message-ID: <CAMuHMdXd=jtggL3H4XuBuuNY3QtLDK7Ny=AaSWEjhmRyLwjAGQ@mail.gmail.com>
Subject: Re: Arches that don't support PREEMPT
To: Matthew Wilcox <willy@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ankur Arora <ankur.a.arora@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, 
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de, 
	rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com, 
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, 
	jgross@suse.com, andrew.cooper3@citrix.com, linux-m68k@lists.linux-m68k.org, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
	Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_063443_530354_01C611D1 
X-CRM114-Status: GOOD (  20.68  )
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

SGkgV2lsbHksCgpPbiBUdWUsIFNlcCAxOSwgMjAyMyBhdCAzOjAx4oCvUE0gTWF0dGhldyBXaWxj
b3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+IHdyb3RlOgo+IE9uIFR1ZSwgU2VwIDE5LCAyMDIzIGF0
IDAyOjMwOjU5UE0gKzAyMDAsIFRob21hcyBHbGVpeG5lciB3cm90ZToKPiA+IFRob3VnaCBpdCBq
dXN0IG9jY3VyZWQgdG8gbWUgdGhhdCB0aGVyZSBhcmUgZHJhZ29ucyBsdXJraW5nOgo+ID4KPiA+
IGFyY2gvYWxwaGEvS2NvbmZpZzogICAgIHNlbGVjdCBBUkNIX05PX1BSRUVNUFQKPiA+IGFyY2gv
aGV4YWdvbi9LY29uZmlnOiAgIHNlbGVjdCBBUkNIX05PX1BSRUVNUFQKPiA+IGFyY2gvbTY4ay9L
Y29uZmlnOiAgICAgIHNlbGVjdCBBUkNIX05PX1BSRUVNUFQgaWYgIUNPTERGSVJFCj4gPiBhcmNo
L3VtL0tjb25maWc6ICAgICAgICBzZWxlY3QgQVJDSF9OT19QUkVFTVBUCj4KPiBTb3VuZHMgbGlr
ZSB0aHJlZS1hbmQtYS1oYWxmIGFyY2hpdGVjdHVyZXMgd2hpY2ggY291bGQgYmUgcXVldWVkIHVw
IGZvcgo+IHJlbW92YWwgcmlnaHQgYmVoaW5kIGlhNjQgLi4uCj4KPiBJIHN1c3BlY3Qgbm9uZSBv
ZiB0aGVzZSBhcmNoaXRlY3R1cmUgbWFpbnRhaW5lcnMgaGF2ZSBhbnkgaWRlYSB0aGVyZSdzIGEK
PiBwcm9ibGVtLiAgTG9vayBhdCBjb21taXQgODdhNGMzNzU5OTVlIGFuZCB0aGUgZGlzY3Vzc2lv
biBpbgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAxODA3MjQxNzU2NDYuMzYyMS0x
LWhjaEBsc3QuZGUvCgpUaGVzZSBsaW5rcyBkb24ndCByZWFsbHkgcG9pbnQgb3V0IHRoZXJlIGlz
IGEgZ3JhdmUgcHJvYmxlbT8KCj4gTGV0J3MgY2MgdGhvc2UgbWFpbnRhaW5lcnMgc28gdGhleSBj
YW4gcmVtb3ZlIHRoaXMgYW5kIGZpeCB3aGF0ZXZlcgo+IGJyZWFrcy4KCkdye29ldGplLGVldGlu
Z31zLAoKICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQKCi0tIApHZWVydCBVeXR0ZXJob2V2
ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02
OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwg
SSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlz
dHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0
CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
