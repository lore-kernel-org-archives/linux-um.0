Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296FACE79AB
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 16:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9uStjGl1OL3knVSdVCnhhOWwchv8kO8wi4hrtpDg+ik=; b=DoVNgQA53wi0RG
	ApSrXf+vamuS4XNtC+1evuMBU388BMRsZ2y/WzL1w6fuzLq31yR22xR/im7JD4VCvcyZuZjlAea74
	iGgYv+fUAp9Tbm5KJrYLuHliV+prFcH4YYEsLskr/jvDD4fc9CY0+/DK5qhL6yPrcyCoILaWkP7Fx
	Abz+jWXngvkLcoIAfcLcshhZLWgNuW3hKwxEjjKWahdANnZjSoFrkgTiPzqPlC4HA7119Ci+Koxu2
	SEWWd4SrpTGo4mbq4IZ1iiEyepGUzZwSRh8BuheG5s3242MIql9kDANcTMvVueZ627sY7TlNRQfrg
	Bg28qp//Y5clNziPf5mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qidne-000sfZ-0e;
	Tue, 19 Sep 2023 16:42:10 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qidna-000sf7-2N
	for linux-um@lists.infradead.org;
	Tue, 19 Sep 2023 16:42:08 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qidmu-002SbU-Ay; Tue, 19 Sep 2023 16:41:24 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qidmr-00FzAL-KO; Tue, 19 Sep 2023 17:41:23 +0100
Message-ID: <de98424d-41f9-90f9-742d-623e2b55c564@cambridgegreys.com>
Date: Tue, 19 Sep 2023 17:41:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Arches that don't support PREEMPT
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>
Cc: tglx <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Matthew Wilcox <willy@infradead.org>,
 torvalds <torvalds@linux-foundation.org>,
 Ankur Arora <ankur.a.arora@oracle.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 x86 <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, bp <bp@alien8.de>,
 dave hansen <dave.hansen@linux.intel.com>, hpa <hpa@zytor.com>,
 mingo <mingo@redhat.com>, juri lelli <juri.lelli@redhat.com>,
 vincent guittot <vincent.guittot@linaro.org>, mgorman@suse.de,
 Steven Rostedt <rostedt@goodmis.org>, jon grimm <jon.grimm@amd.com>,
 bharata@amd.com, raghavendra kt <raghavendra.kt@amd.com>,
 boris ostrovsky <boris.ostrovsky@oracle.com>,
 konrad wilk <konrad.wilk@oracle.com>, jgross <jgross@suse.com>,
 andrew cooper3 <andrew.cooper3@citrix.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 linux-um <linux-um@lists.infradead.org>, Brian Cain <bcain@quicinc.com>,
 linux-hexagon@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, linux-alpha <linux-alpha@vger.kernel.org>
References: <87zg1u1h5t.fsf@oracle.com> <87led2wdj0.ffs@tglx>
 <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <bd664a61-4506-bab0-19c3-0011f57005b5@cambridgegreys.com>
 <87y1h2ur98.ffs@tglx>
 <9a5c0856-d542-9912-7494-53d7fe4538a3@cambridgegreys.com>
 <551475267.58816.1695140566849.JavaMail.zimbra@nod.at>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <551475267.58816.1695140566849.JavaMail.zimbra@nod.at>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_094206_776916_C587B8EC 
X-CRM114-Status: GOOD (  15.50  )
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

CgpPbiAxOS8wOS8yMDIzIDE3OjIyLCBSaWNoYXJkIFdlaW5iZXJnZXIgd3JvdGU6Cj4gLS0tLS0g
VXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+PiBWb246ICJhbnRvbiBpdmFub3YiIDxhbnRvbi5p
dmFub3ZAY2FtYnJpZGdlZ3JleXMuY29tPgo+PiBJdCdzIGJlZW4gYSB3aGlsZS4gSSByZW1lbWJl
ciB0aGF0IEkgZHJvcHBlZCBpdCBhdCB0aGUgdGltZSwgYnV0IGRvIG5vdCByZW1lbWJlcgo+PiB0
aGUgZnVsbCBkZXRhaWxzLgo+Pgo+PiBUaGVyZSB3YXMgc29tZSBzdHVmZiByZWxhdGVkIHRvIEZQ
IHN0YXRlIGFuZCBhIGZldyBvdGhlciBpc3N1ZXMgSSByYW4gaW50byB3aGlsZQo+PiByZXdyaXRp
bmcgdGhlIGludGVycnVwdCBjb250cm9sbGVyLiBTb21lIG9mIGl0IG1heSBiZSByZXNvbHZlZCBi
eSBub3cgYXMgd2UgYXJlCj4+IHVzaW5nIGhvc3QgY3B1IGZsYWdzLCBldGMuCj4gCj4gSSByZW1l
bWJlciBhbHNvIGhhdmluZyBhIGhhY2t5IGJ1dCB3b3JraW5nIHZlcnNpb24gYWxtb3N0IDEwIHll
YXJzIGFnby4KPiBJdCB3YXMgaG9ycmlibGUgc2xvdyBiZWNhdXNlIG9mIHRoZSBleHRyYSBzY2hl
ZHVsZXIgcm91bmRzLgo+IEJ1dCB5ZXMsIGlmIFBSRUVNUFQgd2lsbCBiZSBhIG11c3QtaGF2ZSBm
ZWF0dXJlIHdlJ2xsIGhhdmUgdG8gdHJ5IGFnYWluLgoKV2Ugd2lsbCBuZWVkIHByb3BlciBmcHUg
cHJpbWl0aXZlcyBmb3Igc3RhcnRlcnMgdGhhdCdzIGZvciBzdXJlLiBmcHVfc3Rhci9lbmQgaW4g
VU1MIGFyZSBwcmVzZW50bHkgTk9PUC4KClNvbWUgb2YgdGhlIGRlZmF1bHQgc3BpbmxvY2tzIGFu
ZCBvdGhlciBzdHVmZiB3aGljaCB3ZSBwaWNrIHVwIGZyb20gZ2VuZXJpYyBtYXkgbmVlZCB0byBj
aGFuZ2UgYXMgd2VsbC4KClRoaXMgaXMgb2ZmIHRoZSB0b3Agb2YgbXkgaGVhZCBhbmQgc29tZXRo
aW5nIHdoaWNoIHdlIGNhbiBmaXggc3RyYWlnaHQgYXdheS4gSSB3aWxsIHNlbmQgc29tZSBwYXRj
aGVzIHRvIHRoZSBtYWlsaW5nIGxpc3QgdG9tb3Jyb3cgb3Igb24gVGh1LgoKQS4KCj4gCj4gVGhh
bmtzLAo+IC8vcmljaGFyZAo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCj4gbGludXgtdW0gbWFpbGluZyBsaXN0Cj4gbGludXgtdW1AbGlzdHMuaW5m
cmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtdW0KCi0tIApBbnRvbiBSLiBJdmFub3YKQ2FtYnJpZGdlZ3JleXMgTGltaXRlZC4gUmVn
aXN0ZXJlZCBpbiBFbmdsYW5kLiBDb21wYW55IE51bWJlciAxMDI3MzY2MQpodHRwczovL3d3dy5j
YW1icmlkZ2VncmV5cy5jb20vCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVt
Cg==
