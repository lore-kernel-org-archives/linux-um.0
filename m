Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320C1C77B78
	for <linux-um@archiver.kernel.org>; Sun, 16 Apr 2023 09:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tMANQHMTSn7O3MO/4gxT6xPGq0/4S71cRnhMecjZIuU=; b=yruUbKc4YKA3ES
	AONoN6Kp2Hm2yZjoyzn5fFx3Y65fekBV/3ede3wChRmxJ8ZUE86gBVSp4rVOsPYulGWz0jZMQ3u5V
	uyBfYSk4H251OVqiTs1XQ5Gb0FU0JHjTdUePGeR770EtDY8oLp+7dlmuzYQTYQeUgcLURaXc/k15n
	hjEllD0nR4ZjzT8BKQESHd0vSLHFRzdCA1z/CMqaTZDLuIDa70kt9vAAL+/TRtKtbo6TbyapPeXIb
	0m7NW7o5rvWOKJHrDTHKIf21FsMZH6qz23SXsgHxcz+5achOJbK82KngtzPbhP+RphkhAG5Vx1yta
	O/coXiMdDjm24ld0Z1kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pnyvN-00DSoA-13;
	Sun, 16 Apr 2023 09:43:57 +0000
Received: from mail-yw1-f172.google.com ([209.85.128.172])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pnyvI-00DSnE-2f
	for linux-um@lists.infradead.org;
	Sun, 16 Apr 2023 09:43:54 +0000
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-54fa9da5e5bso191362817b3.1
        for <linux-um@lists.infradead.org>; Sun, 16 Apr 2023 02:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681638230; x=1684230230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGZ8vTVUDzMj6tlghPjPrAsFRulY7ZaPrM9DcatIBAM=;
        b=cWmhH0YqP7aGcwB2LDY8dqQSxFMmuWIzmVxSEyvyjMt4jUu4nelch6fLsX3WwiqUMj
         XwDgO49J0NCHmsTN7/jCf1ChRJkcL2GrUZ0CCSd02b7Kn0VZDJzWxVNVvqPqk13//B/7
         /EdgqdgogZufeDHJm1YvhV97I2LpmM1SdQAmSDqB2x0AWZ5nd0FzP0nH8JPUnKZqfSIB
         wfFq2lZHtyb3RR6nOa43YyHRtFo2A+cvsvuMTI0AAimEpWi7uOnqZ6gVxBnhjs5eWY5h
         ZvLXGHLacwxJK1NTRfmeopAAigsjpMz7kN9nO+YomAF4DJ73xi6CmwuQ0HWUbYrtRhdo
         i7og==
X-Gm-Message-State: AAQBX9cDJShRynhrxVMAY5zbQruGanrJBU33W/N0OKa2gTV7uWDgc1JI
	Lt9cRyEgQJE2IL2KFMTbWerkz2c/B47apA==
X-Google-Smtp-Source: AKy350Z/bi7hrKgJqA/XXfrax7KcLVGwnHolAVIm+0rf7dpyCb4kvdbRWizyKmsMBqPETXW7CYNcwQ==
X-Received: by 2002:a0d:c985:0:b0:54f:caeb:15d0 with SMTP id l127-20020a0dc985000000b0054fcaeb15d0mr10309693ywd.4.1681638230326;
        Sun, 16 Apr 2023 02:43:50 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id j9-20020a81fe09000000b0054fbb2dac44sm2387751ywn.115.2023.04.16.02.43.49
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 02:43:49 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-54ee0b73e08so394173477b3.0
        for <linux-um@lists.infradead.org>; Sun, 16 Apr 2023 02:43:49 -0700 (PDT)
X-Received: by 2002:a81:b65b:0:b0:54f:dc41:8edf with SMTP id
 h27-20020a81b65b000000b0054fdc418edfmr6862753ywk.2.1681638229566; Sun, 16 Apr
 2023 02:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230410011325.26850-1-rdunlap@infradead.org> <099028386d683dcc585693d85b6b2739952fcdeb.camel@sipsolutions.net>
 <ZDuTotxqsrysNaYu@infradead.org>
In-Reply-To: <ZDuTotxqsrysNaYu@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 16 Apr 2023 11:43:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXRezGfUE4OOc3OjSmP6sS7oQXEd5QnC-G+d+Hv9uVz9Q@mail.gmail.com>
Message-ID: <CAMuHMdXRezGfUE4OOc3OjSmP6sS7oQXEd5QnC-G+d+Hv9uVz9Q@mail.gmail.com>
Subject: Re: [PATCH v3] UML: pata_cs5536: fix build for X86_32 UML with TRACEPOINTS
To: Christoph Hellwig <hch@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Damien Le Moal <damien.lemoal@opensource.wdc.com>, linux-ide@vger.kernel.org, 
	linux-um@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230416_024352_880517_7DE4F5D0 
X-CRM114-Status: GOOD (  24.03  )
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

SGkgQ2hyaXN0b3BoLAoKT24gU3VuLCBBcHIgMTYsIDIwMjMgYXQgODoyMOKAr0FNIENocmlzdG9w
aCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4gd3JvdGU6Cj4gT24gRnJpLCBBcHIgMTQsIDIw
MjMgYXQgMDM6NTU6MDdQTSArMDIwMCwgSm9oYW5uZXMgQmVyZyB3cm90ZToKPiA+IE9uIFN1biwg
MjAyMy0wNC0wOSBhdCAxODoxMyAtMDcwMCwgUmFuZHkgRHVubGFwIHdyb3RlOgo+ID4gPiBDdXJy
ZW50IGJ1aWxkIG9mIHBhdGFfY3M1NTM2IGZvciBpMzg2IFVNTCBmYWlscyB3aXRoOgo+ID4gPgo+
ID4gPiBFUlJPUjogbW9kcG9zdDogIl9fdHJhY2Vwb2ludF93cml0ZV9tc3IiIFtkcml2ZXJzL2F0
YS9wYXRhX2NzNTUzNi5rb10gdW5kZWZpbmVkIQo+ID4gPiBFUlJPUjogbW9kcG9zdDogImRvX3Ry
YWNlX3dyaXRlX21zciIgW2RyaXZlcnMvYXRhL3BhdGFfY3M1NTM2LmtvXSB1bmRlZmluZWQhCj4g
PiA+IEVSUk9SOiBtb2Rwb3N0OiAiX190cmFjZXBvaW50X3JlYWRfbXNyIiBbZHJpdmVycy9hdGEv
cGF0YV9jczU1MzYua29dIHVuZGVmaW5lZCEKPiA+ID4gRVJST1I6IG1vZHBvc3Q6ICJkb190cmFj
ZV9yZWFkX21zciIgW2RyaXZlcnMvYXRhL3BhdGFfY3M1NTM2LmtvXSB1bmRlZmluZWQhCj4gPiA+
Cj4gPiA+IEFkZCB0aGUgYXJjaC94ODYvbGliL21zci5vIGJpbmFyeSB0byByZXNvbHZlIHRoZXNl
IHVuZGVmaW5lZCBzeW1ib2xzLgo+ID4gPgo+ID4KPiA+IEhtLiBEb2VzIHRoaXMgbWFrZSBzZW5z
ZT8gSSBjYW4ndCBzZWUgaXQnZCB3b3JrIG9uIFVNTCB0byBjb25maWd1cmUgYW4KPiA+IElERSBk
ZXZpY2UgdGhyb3VnaCBNU1JzPyBTdXJlbHkgdGhhdCBjYW4ndCB3b3JrPyBJT1csIHRoYXQgZW50
aXJlIGRyaXZlcgo+ID4gY2FuJ3QgcmVhbGx5IHdvcmsgYW55d2F5IGNhbiBpdD8KPiA+Cj4gPiBP
VE9ILCBtYXliZSB0aGVvcmV0aWNhbGx5IGl0IGNvdWxkIHdvcmsgaW4gUENJLCBqdXN0IG5vdCB3
aXRoIE1TUnMsIGFuZAo+ID4gdGhlbiB0aGlzIHBhdGNoIG1ha2VzIHNvbWUgc2Vuc2U/Cj4KPiBJ
IHRoaW5rIGl0IGlzIGlzIGludGVncmF0ZWQgaW50byBhY3R1YWwgR2VvZGUgU09Dcy4gIFRoYXQg
YmVpbmcKPiBzYWlkIHNvbWV0aGluZyBsaWtlIHRoZSBwYXRjaCBiZWxvdyBzZWVtcyBhcyBzaW1w
bGUgYXMgaXQgZ2V0cyBhbmQKPiBhdCBsZWFzdCBnaXZlcyBidWlsZCBjb3ZlcmFnZSBvbiB1bWwK
CkNTNTUzNiBpcyB0aGUgR2VvZGUgQ29tcGFuaW9uIERldmljZSwgaS5lLiB0aGUgU291dGggQnJp
ZGdlLCB3aGljaApjYW4gYmUgdXNlZCB3aXRoIG90aGVyIGRldmljZXMsIEFGQUlLLgoKR3J7b2V0
amUsZWV0aW5nfXMsCgogICAgICAgICAgICAgICAgICAgICAgICBHZWVydAoKLS0gCkdlZXJ0IFV5
dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRA
bGludXgtbTY4ay5vcmcKCkluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwg
cGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQKd2hlbiBJJ20gdGFsa2luZyB0byBq
b3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0
LgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWls
aW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
