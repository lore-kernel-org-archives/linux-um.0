Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FABFE81E04
	for <linux-um@archiver.kernel.org>; Fri,  6 Oct 2023 14:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gsL0MXf1Rxz5ynhHN6De17t7G2FKwCUBZSrTIFkSlDc=; b=wNns1MxuNWyUTc
	9MpO0fgseyPaRI/KcTSTBlEQ7yzE2Ymj7Oj5n+p7KgiRhmVWAg40SYTAjv9yFb/w4s7BAmSFiz7CT
	jd/dIsU6RS+0WE4CL70qHB1ljqmzL4GUcMsd/FSgAsSzzMV5My9zrXukz97KURBsxLDE+VBHz1ENJ
	nNRnFORBFJvT5nnqHZpyBXgTwrnzDVZvWgG32JaOC/7VbPgZ7w4RST7AoPlWTdIIXCLwbDfEvvj/n
	Z8TRc4TxLErlvRB3Vj2mxG6jINXYsHeLju36bMEEcxcpqb+U5bSvQSRQ7U8l+3MIxKSsFMLsin5Qf
	EOiRaHWrwUd8qUMmPNdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qomB8-0061MO-1Z;
	Fri, 06 Oct 2023 14:51:46 +0000
Received: from mail-pf1-f176.google.com ([209.85.210.176])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qomB5-0061LY-1S
	for linux-um@lists.infradead.org;
	Fri, 06 Oct 2023 14:51:44 +0000
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-692779f583fso1797256b3a.0
        for <linux-um@lists.infradead.org>; Fri, 06 Oct 2023 07:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696603901; x=1697208701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iH1WSSdRdMGN/blmpsRHcGzazR8XoV0oXL3Y8AOIRuQ=;
        b=kpdCD4eYJg4bBi7g+MA5wHo/GRxoevZUm0ZWeTDQEp4v0p4qj8QHH23PeuD8l+X2If
         ZE/DZTLPSuLTr4vUskdyl6NnucWKqQlGGbFuXqVglnB4IfJvy1DNlNAX/b9hB4TDbG+h
         TaSk6sDvUkummiJquTqTDiyjeDIwYmjidNbKtjnYM/Lxd7MeRD9pLDUi5G9R8TKp3s4A
         +MUsaZDVDeYkt4SNkrStgwGHKZfHdImbwIVr7voEFsfS3GIRo9DE7vSsyeOrMseNvCDM
         0uLjq1G6xKjOyRBhMlCcAptvLplE1o9FEkRTOLG8oF9EiQGpv3/NMwsKK1Htn/UXswZF
         6TSQ==
X-Gm-Message-State: AOJu0YwHE8ATraFlqzmv6kG2MKz0FrLDTaBP14wRX488CkmOK5AGNhew
	hoRcjtx4eWRtEPF/XOjNgjKxSCnBDRGbtw==
X-Google-Smtp-Source: AGHT+IEQBVITPdS59suVNnOgbgB5EbLQAgR1W8O39CyMtRzblG9oCSh50RiC4YXOYi514oZ97jHWEw==
X-Received: by 2002:a05:6a00:2da5:b0:68e:2d2d:56c1 with SMTP id fb37-20020a056a002da500b0068e2d2d56c1mr9010513pfb.9.1696603900839;
        Fri, 06 Oct 2023 07:51:40 -0700 (PDT)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com. [209.85.210.171])
        by smtp.gmail.com with ESMTPSA id s10-20020aa78d4a000000b0068be348e35fsm1554019pfe.166.2023.10.06.07.51.40
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 07:51:40 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-69af8a42066so1181594b3a.1
        for <linux-um@lists.infradead.org>; Fri, 06 Oct 2023 07:51:40 -0700 (PDT)
X-Received: by 2002:a0d:e841:0:b0:589:f491:de9c with SMTP id
 r62-20020a0de841000000b00589f491de9cmr8896800ywe.28.1696603879221; Fri, 06
 Oct 2023 07:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <87edj64rj1.fsf@oracle.com> <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com> <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net> <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net> <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
In-Reply-To: <ZQmbhoQIINs8rLHp@casper.infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 6 Oct 2023 16:51:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV4qx3iQzqksfnvckk_PK9Zas0U=p-xv3pVwJ6hWLpejA@mail.gmail.com>
Message-ID: <CAMuHMdV4qx3iQzqksfnvckk_PK9Zas0U=p-xv3pVwJ6hWLpejA@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20231006_075143_489793_1654C816 
X-CRM114-Status: GOOD (  19.92  )
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
LWhjaEBsc3QuZGUvCj4KPiBMZXQncyBjYyB0aG9zZSBtYWludGFpbmVycyBzbyB0aGV5IGNhbiBy
ZW1vdmUgdGhpcyBhbmQgZml4IHdoYXRldmVyCj4gYnJlYWtzLgoKTG9va3MgbGlrZSB5b3VyIHNj
YXJlIHRhY3RpY3MgYXJlIHdvcmtpbmcgOy0pCltQQVRDSC9SRkNdIG02OGs6IEFkZCBmdWxsIHBy
ZWVtcHQgc3VwcG9ydApodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvNzg1OGExODRjZGE2NmUw
OTkxZmQyOTVjNzExZGZlZDdlNGQxMjQ4Yy4xNjk2NjAzMjg3LmdpdC5nZWVydEBsaW51eC1tNjhr
Lm9yZwoKR3J7b2V0amUsZWV0aW5nfXMsCgogICAgICAgICAgICAgICAgICAgICAgICBHZWVydAoK
LS0gCkdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlh
MzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcKCkluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0
aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQKd2hlbiBJJ20g
dGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhp
bmcgbGlrZSB0aGF0LgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRv
cnZhbGRzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
