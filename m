Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480FFCE79AB
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 17:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FcJmnNopCJ9EO0w8neKODdl36Fb80T77QVi43oc9QV4=; b=hXlKYzWrNCvWKM
	b5ngKPD2YgTmwDs7nrbM5a86BDlTXJj2rNDpbdaAZLbNc2V0rjjU4guEp9+P/VsYgEefLD9KCJGXY
	9bWtog2Wz6FOzXwcINaPWDe1ApgYz2nvcY9Ln3n7V8Qku5v52AezYPfk6w4YClHa4iwSh/vxARBHN
	SH91hvizDjUTKGPlMzFy8RUDioj5cUe4wjo0KzZEfpnzi67A7lVZKiEfWFYAkojIow2Fnpj0QOEAS
	7KHxfMCP2DPehlhCQTStBqlKMuB9UNH9A6Gwx4aoZLkXDoTgwvLnQCRdurrxvO02IltuhSOfQfiSk
	Mu3XQkeEAVStmzc4bMfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiebs-000wgw-22;
	Tue, 19 Sep 2023 17:34:04 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiebp-000wfp-1A
	for linux-um@lists.infradead.org;
	Tue, 19 Sep 2023 17:34:02 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1695144838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5XoD2rR1P7xfyZ4vS5WECNooPW5RHsWgoNmWq+2hMo=;
	b=UJuEQFI+fVdHak0lB8fNvstykL9kpTeNJD+gjygB9iKFIoN1n7qL5fa8q1zibRy2IPQ6Qe
	NyukDnTgIGP7wS4FzYHD5OGCHF62//LTFHZZ8yP9IQToCNuSqQ1GH+7YaaGPaBI/CX6Z8V
	8Vzbr2wmmB33ZJMWTR30JR513dx/C+zEch08e6QwhmiWdN2hx57bNIhu4sFxTiAQXh1Xn1
	G7Uqydw7R+LQiZU2Twrng6XRlmrm/mXOIsAXYOgo5eW8rhYLGVEvA9DBjj6ZiIG4ffl66+
	NOsgtS0rfYpuBXj0rw8P+dSYdXzP2sFea+0Hqq+BkBT6knNGfVPF/+sEjn1HEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1695144838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5XoD2rR1P7xfyZ4vS5WECNooPW5RHsWgoNmWq+2hMo=;
	b=FC96a8Jt867By47LPHSnv602OXYh1+2tD7k+Vqqy6gx0P6BeLouKDBbYI0Ubu/ALeBPwSe
	ofg019sZqzn6gQAQ==
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Richard Weinberger
 <richard@nod.at>
Cc: Peter Zijlstra <peterz@infradead.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Matthew Wilcox <willy@infradead.org>,
 torvalds <torvalds@linux-foundation.org>, Ankur Arora
 <ankur.a.arora@oracle.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, x86 <x86@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, bp
 <bp@alien8.de>, dave hansen <dave.hansen@linux.intel.com>, hpa
 <hpa@zytor.com>, mingo <mingo@redhat.com>, juri lelli
 <juri.lelli@redhat.com>, vincent guittot <vincent.guittot@linaro.org>,
 mgorman@suse.de, Steven Rostedt <rostedt@goodmis.org>, jon grimm
 <jon.grimm@amd.com>, bharata@amd.com, raghavendra kt
 <raghavendra.kt@amd.com>, boris ostrovsky <boris.ostrovsky@oracle.com>,
 konrad wilk <konrad.wilk@oracle.com>, jgross <jgross@suse.com>, andrew
 cooper3 <andrew.cooper3@citrix.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um
 <linux-um@lists.infradead.org>, Brian Cain <bcain@quicinc.com>,
 linux-hexagon@vger.kernel.org, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, linux-alpha
 <linux-alpha@vger.kernel.org>
Subject: Re: Arches that don't support PREEMPT
In-Reply-To: <de98424d-41f9-90f9-742d-623e2b55c564@cambridgegreys.com>
References: <87zg1u1h5t.fsf@oracle.com> <87led2wdj0.ffs@tglx>
 <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <bd664a61-4506-bab0-19c3-0011f57005b5@cambridgegreys.com>
 <87y1h2ur98.ffs@tglx>
 <9a5c0856-d542-9912-7494-53d7fe4538a3@cambridgegreys.com>
 <551475267.58816.1695140566849.JavaMail.zimbra@nod.at>
 <de98424d-41f9-90f9-742d-623e2b55c564@cambridgegreys.com>
Date: Tue, 19 Sep 2023 19:33:57 +0200
Message-ID: <87v8c6ukxm.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_103401_540432_EF285AF3 
X-CRM114-Status: GOOD (  18.36  )
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

T24gVHVlLCBTZXAgMTkgMjAyMyBhdCAxNzo0MSwgQW50b24gSXZhbm92IHdyb3RlOgo+IE9uIDE5
LzA5LzIwMjMgMTc6MjIsIFJpY2hhcmQgV2VpbmJlcmdlciB3cm90ZToKPj4gLS0tLS0gVXJzcHLD
vG5nbGljaGUgTWFpbCAtLS0tLQo+Pj4gVm9uOiAiYW50b24gaXZhbm92IiA8YW50b24uaXZhbm92
QGNhbWJyaWRnZWdyZXlzLmNvbT4KPj4+IEl0J3MgYmVlbiBhIHdoaWxlLiBJIHJlbWVtYmVyIHRo
YXQgSSBkcm9wcGVkIGl0IGF0IHRoZSB0aW1lLCBidXQgZG8gbm90IHJlbWVtYmVyCj4+PiB0aGUg
ZnVsbCBkZXRhaWxzLgo+Pj4KPj4+IFRoZXJlIHdhcyBzb21lIHN0dWZmIHJlbGF0ZWQgdG8gRlAg
c3RhdGUgYW5kIGEgZmV3IG90aGVyIGlzc3VlcyBJIHJhbiBpbnRvIHdoaWxlCj4+PiByZXdyaXRp
bmcgdGhlIGludGVycnVwdCBjb250cm9sbGVyLiBTb21lIG9mIGl0IG1heSBiZSByZXNvbHZlZCBi
eSBub3cgYXMgd2UgYXJlCj4+PiB1c2luZyBob3N0IGNwdSBmbGFncywgZXRjLgo+PiAKPj4gSSBy
ZW1lbWJlciBhbHNvIGhhdmluZyBhIGhhY2t5IGJ1dCB3b3JraW5nIHZlcnNpb24gYWxtb3N0IDEw
IHllYXJzIGFnby4KPj4gSXQgd2FzIGhvcnJpYmxlIHNsb3cgYmVjYXVzZSBvZiB0aGUgZXh0cmEg
c2NoZWR1bGVyIHJvdW5kcy4KCldoaWNoIGNhbiBiZSBjb21wbGV0ZWx5IGF2b2lkZWQgYXMgdGhl
IHByb3Bvc2VkIGNoYW5nZSB3aWxsIGhhdmUgdGhlCnByZWVtcHRpb24gcG9pbnRzLCBidXQgdGhl
eSBhcmUgb25seSB1dGlsaXplZCB3aGVuIHByZWVtcHQgRlVMTCBpcwplbmFibGVkIChhdCBib290
IG9yIHJ1bnRpbWUpLiBTbyB0aGUgYmVoYXZpb3VyIGNhbiBzdGlsbCBiZSBsaWtlIHByZWVtcHQK
Tk9ORSwgYnV0IHdpdGggYSB0d2lzdCB0byBnZXQgcmlkIG9mIHRoZSBjb25kX3Jlc2NoZWQoKS9t
aWdodF9yZXNjaGVkKCkKYW5kIG90aGVyIGhldXJpc3RpYyBhcHByb2FjaGVzIHRvIHByZXZlbnQg
c3RhcnZhdGlvbiBieSBsb25nIHJ1bm5pbmcKZnVuY3Rpb25zLiBUaGF0IHR3aXN0IG5lZWRzIHRo
ZSBwcmVlbXB0aW9uIHBvaW50cy4KClNlZSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzg3
Y3l5ZnhkNGsuZmZzQHRnbHgKCj4+IEJ1dCB5ZXMsIGlmIFBSRUVNUFQgd2lsbCBiZSBhIG11c3Qt
aGF2ZSBmZWF0dXJlIHdlJ2xsIGhhdmUgdG8gdHJ5IGFnYWluLgo+Cj4gV2Ugd2lsbCBuZWVkIHBy
b3BlciBmcHUgcHJpbWl0aXZlcyBmb3Igc3RhcnRlcnMgdGhhdCdzIGZvcgo+IHN1cmUuIGZwdV9z
dGFyL2VuZCBpbiBVTUwgYXJlIHByZXNlbnRseSBOT09QLgo+Cj4gU29tZSBvZiB0aGUgZGVmYXVs
dCBzcGlubG9ja3MgYW5kIG90aGVyIHN0dWZmIHdoaWNoIHdlIHBpY2sgdXAgZnJvbQo+IGdlbmVy
aWMgbWF5IG5lZWQgdG8gY2hhbmdlIGFzIHdlbGwuCj4KPiBUaGlzIGlzIG9mZiB0aGUgdG9wIG9m
IG15IGhlYWQgYW5kIHNvbWV0aGluZyB3aGljaCB3ZSBjYW4gZml4IHN0cmFpZ2h0Cj4gYXdheS4g
SSB3aWxsIHNlbmQgc29tZSBwYXRjaGVzIHRvIHRoZSBtYWlsaW5nIGxpc3QgdG9tb3Jyb3cgb3Ig
b24gVGh1LgoKSSB0aGluayBpdCBkb2VzIG5vdCBoYXZlIHRvIGJlIHBlcmZlY3QuIFVNIGlzIGZh
ciBmcm9tIHBlcmZlY3QgaW4KbWltaWNpbmcgYSByZWFsIGtlcm5lbC4gVGhlIG1haW4gcG9pbnQg
aXMgdGhhdCBpdCBwcm92aWRlcyB0aGUgcHJlZW1wdApjb3VudGVyIGluIHRoZSBmaXJzdCBwbGFj
ZSBhbmQgc29tZSBtaW5pbWFsIGFtb3VudCBvZiBwcmVlbXB0aW9uIHBvaW50cwphc2lkZSBvZiB0
aG9zZSB3aGljaCBjb21lIHdpdGggdGhlIHByZWVtcHRfZW5hYmxlKCkgbWFjaGluZXJ5IGZvciBm
cmVlLgoKVGhhbmtzLAoKICAgICAgICB0Z2x4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LXVtCg==
