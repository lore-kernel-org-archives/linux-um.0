Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB186CD5BD0
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 14:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dPy9ON0WOzGrUEbNVGiIvTNdUB3b08FtlN0VwATf/Yo=; b=VzXigYn1KFx1sF
	Vn40/cSrl/UqSBN7J5vqR/0kFGG3X255dxztPhJ9LRkWshDwkjUi6neAPhgWT5EJld1lqEfKYAc2Y
	a4txSvEA2AUeYZiKvlvtbGxKaFJJAwrB1lMNuYh2f74aMFX3kE4z9j9EshODkaucpY2NCN3b1+ZBn
	qyYtsuegY+uu7FezFt9Iq2qZ8FexEoCyEKrXrlJ3gRegiQViblcJRlQcIVMo0E6pMq8HCngcQLxvI
	ZX2qo0C5HExMBzb7XD2ye6xTb3GJ5KaR287IAqv43rdD5CL/MQiFw/2DEzFBAqP8coahguGN3zrnw
	1HpU18Gt+2fTSIMwjnfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qicAX-000iDz-2K;
	Tue, 19 Sep 2023 14:57:41 +0000
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qicAU-000iCZ-0n
	for linux-um@lists.infradead.org;
	Tue, 19 Sep 2023 14:57:40 +0000
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d8198ca891fso4817995276.1
        for <linux-um@lists.infradead.org>; Tue, 19 Sep 2023 07:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695135456; x=1695740256; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mIaJyUn8RI0FK5RTul2K30K/J4q1nZarbiEpq/gFEs=;
        b=aO3wP30FjS2seu30UgxDFdqDqw7KTjywV3zjH//AY0c1kspyyVIqjTS2saZIL9na/o
         XYHPlXJud0HxAVBIuO+VG5lEjj0YB+UVBONx0bOp2JZfbHVVyK5T+bKPA0rgtyiY2uBi
         fG3oU29Rns19pKz9qCxfA+k6/cN4HCTOroQz1kwLwb/UbS4CwGijP/aOauj9P/vyIbnO
         FKsZDELDQADAfG2orbYDgpT6tM5OQl5h0SI2uNtKkfakexmKu+lcGXXC36NhHhd7gUeC
         rh/HclGN4697iVfjY/IABs/YQju+1o/DpF0UVIBVz5V/XE3HNBNKmKV1ZeCULlAIYp5G
         cXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695135456; x=1695740256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mIaJyUn8RI0FK5RTul2K30K/J4q1nZarbiEpq/gFEs=;
        b=o/h1DTPmKYzycYGvLCV5dwg6KBbAfvJFkk/7ZKPMdaV56jh8CXLgC8QS76WUP0F967
         5zVbCPFhfiqzb9deMMw0kc3GDj8lKFFhVJrcujDdXwqrGm1zhizp3s2/HuVD41BD0AvD
         ifhlZiw77BNFZVh//TlV5p505GLrYWwxKYF5NBH2via/6dirPAKbRRKThDANXAr0K7Eq
         FS8diLCnUeVyq9MttZ5VXGlUuFtAtbCyQAQJlW+rlMWXXA6JiwqZ4ybD6UXaLY1xXz8u
         8weU4TdghgCc61CJSWAeIX1etoMkmuXueOY0vE+9igE1ctUTFFO/OQz5ixfGKbFpmmE5
         dIAQ==
X-Gm-Message-State: AOJu0Ywj0zq9ZZ901pLalOyLSwiplGfD2KK7NaTyaevKV7hGKvuAsX4Z
	r1158OACqo6h3V2B9WG1xmlKT1nvP35IeUIEm9Q=
X-Google-Smtp-Source: AGHT+IGcBGsVxn25jswNs80R/yoKy6qzKyJOnTD3BOHxaRGMJ0JXIB34kFzqj6wy6lqaw/mBs9oZ3uCr7ZvPWzMti6E=
X-Received: by 2002:a25:76c9:0:b0:d12:ab1:d88a with SMTP id
 r192-20020a2576c9000000b00d120ab1d88amr12466931ybc.40.1695135456312; Tue, 19
 Sep 2023 07:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <87zg1u1h5t.fsf@oracle.com> <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net> <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net> <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net> <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
 <877comw8m7.ffs@tglx> <7EB81196-3A32-4638-A076-0C0CFF722996@zytor.com>
In-Reply-To: <7EB81196-3A32-4638-A076-0C0CFF722996@zytor.com>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 19 Sep 2023 10:57:24 -0400
Message-ID: <CAEdQ38H8QZvnwTMJ+-y56je7--Z2Ru-4kmPo7zcW3X8mxfXv1Q@mail.gmail.com>
Subject: Re: Arches that don't support PREEMPT
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Peter Zijlstra <peterz@infradead.org>, 
	Matthew Wilcox <willy@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, 
	dave.hansen@linux.intel.com, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, mgorman@suse.de, rostedt@goodmis.org, 
	jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, 
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com, 
	andrew.cooper3@citrix.com, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-um@lists.infradead.org, Brian Cain <bcain@quicinc.com>, 
	linux-hexagon@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	linux-alpha@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_075738_284689_6406BB5C 
X-CRM114-Status: GOOD (  32.94  )
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

T24gVHVlLCBTZXAgMTksIDIwMjMgYXQgMTA6NTHigK9BTSBILiBQZXRlciBBbnZpbiA8aHBhQHp5
dG9yLmNvbT4gd3JvdGU6Cj4KPiBPbiBTZXB0ZW1iZXIgMTksIDIwMjMgNzoxNzowNCBBTSBQRFQs
IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPiB3cm90ZToKPiA+T24gVHVlLCBT
ZXAgMTkgMjAyMyBhdCAxNTo0OCwgSm9obiBQYXVsIEFkcmlhbiBHbGF1Yml0eiB3cm90ZToKPiA+
PiBPbiBUdWUsIDIwMjMtMDktMTkgYXQgMTU6NDIgKzAyMDAsIFBldGVyIFppamxzdHJhIHdyb3Rl
Ogo+ID4+PiA+IFRoZSBhZ3JlZW1lbnQgdG8ga2lsbCBvZmYgaWE2NCB3YXNuJ3QgYW4gaW52aXRh
dGlvbiB0byBraWxsIG9mZiBvdGhlciBzdHVmZgo+ID4+PiA+IHRoYXQgcGVvcGxlIGFyZSBzdGls
bCB3b3JraW5nIG9uISBDYW4gd2UgcGxlYXNlIG5vdCBkbyB0aGlzPwo+ID4+Pgo+ID4+PiBJZiB5
b3UncmUgd29ya2luZyBvbiBvbmUgb2YgdGhlbSwgdGhlbiBzdXJlbHkgaXQncyBhIHNpbXBsZSBt
YXR0ZXIgb2YKPiA+Pj4gd29ya2luZyBvbiBhZGRpbmcgQ09ORklHX1BSRUVNUFQgc3VwcG9ydCA6
LSkKPiA+Pgo+ID4+IEFzIEdlZXJ0IHBvaW5lZCBvdXQsIEknbSBub3Qgc2VlaW5nIGFueXRoaW5n
IHBhcnRpY3VsYXIgcHJvYmxlbWF0aWMgd2l0aCB0aGUKPiA+PiBhcmNoaXRlY3R1cmVzIGxhY2tp
bmcgQ09ORklHX1BSRUVNUFQgYXQgdGhlIG1vbWVudC4gVGhpcyBzZWVtcyB0byBiZSBtb3JlCj4g
Pj4gc29tZXRoaW5nIGFib3V0IG9yZ2FuaXppbmcgS0NvbmZpZyBmaWxlcy4KPiA+Pgo+ID4+IEkg
ZmluZCBpdCBhIGJpdCB1bmZhaXIgdGhhdCBtYWludGFpbmVycyBvZiBhcmNoaXRlY3R1cmVzIHRo
YXQgaGF2ZSBodWdlIGNvbXBhbmllcwo+ID4+IGJlaGluZCB0aGVtIHVzZSB0aGVpciBtYW5wb3dl
ciB0byB1cmdlIGxlc3MgcG9wdWxhciBhcmNoaXRlY3R1cmVzIGZvciByZW1vdmFsIGp1c3QKPiA+
PiBiZWNhdXNlIHRoZXkgZG9uJ3QgaGF2ZSAxNTAgcGVvcGxlIHdvcmtpbmcgb24gdGhlIHBvcnQg
c28gdGhleSBjYW4ga2VlcCB1cCB3aXRoCj4gPj4gZGVzaWduIGNoYW5nZXMgcXVpY2tseS4KPiA+
Cj4gPkkgZG9uJ3QgdXJnZSBmb3IgcmVtb3ZhbC4gSSBqdXN0IG5vdGljZWQgdGhhdCB0aGVzZSBm
b3VyIGFyY2hpdGVjdHVyZXMKPiA+bGFjayBQUkVFTVBUIHN1cHBvcnQuIFRoZSBvbmx5IHRoaW5n
IHdoaWNoIGlzIG1pc3NpbmcgaXMgdGhlIGFjdHVhbAo+ID5wcmVlbXB0aW9uIHBvaW50IGluIHRo
ZSByZXR1cm4gdG8ga2VybmVsIGNvZGUgcGF0aC4KPiA+Cj4gPkJ1dCBvdGhlcndpc2UgaXQgc2hv
dWxkIGp1c3Qgd29yaywgd2hpY2ggSSBvYnZpb3VzbHkgY2FuJ3QgY29uZmlybSA6KQo+ID4KPiA+
RXZlbiB3aXRob3V0IHRoYXQgcHJlZW1wdGlvbiBwb2ludCBpdCBzaG91bGQgYnVpbGQgYW5kIGJv
b3QuIFRoZXJlIG1pZ2h0Cj4gPmJlIHNvbWUgbWlub3IgbGF0ZW5jeSBpc3N1ZXMgd2hlbiB0aGF0
IHByZWVtcHRpb24gcG9pbnQgaXMgbm90IHRoZXJlLAo+ID5idXQgYWRkaW5nIGl0IGlzIG5vdCBy
b2NrZXQgc2NpZW5jZSBlaXRoZXIuIEl0J3MgcHJvYmFibHkgYWJvdXQgMTAgbGluZXMKPiA+b2Yg
QVNNIGNvZGUsIGlmIGF0IGFsbC4KPiA+Cj4gPlRob3VnaCBub3QgYWRkaW5nIHRoYXQgbWlnaHQg
Y2F1c2UgYSBibG9ja2luZyBpc3N1ZSBmb3IgdGhlIHJld29yayBvZgo+ID50aGUgd2hvbGUgcHJl
ZW1wdGlvbiBsb2dpYyBpbiBvcmRlciB0byByZW1vdmUgdGhlIHNwcmlua2xlZCBhcm91bmQKPiA+
Y29uZF9yZXNjaGVkKCkgbXVjayBvciBmb3JjZSB1cyB0byBtYWludGFpbiBzb21lIG5hc3R5IHdv
cmthcm91bmQganVzdAo+ID5mb3IgdGhlIGJlbmVmaXQgb2YgYSBmZXcgc3RyYW5nbGVycy4KPiA+
Cj4gPlNvIEkgY2FuIG1ha2UgdGhlIHNhbWUgYXJndW1lbnQgdGhlIG90aGVyIHdheSBhcm91bmQs
IHRoYXQgaXQncwo+ID51bmp1c3RpZmllZCB0aGF0IHNvbWUgYXJjaGl0ZWN0dXJlcyB3aGljaCBh
cmUganVzdCBzdXBwb3J0ZWQgZm9yCj4gPm5vc3RhbGdpYSB0aHJvdyByb2FkYmxvY2tzIGludG8g
a2VybmVsIGRldmVsb3BlbW50Lgo+ID4KPiA+SWYgbXkgQUxQSEEgZm9vIHdvdWxkbid0IGJlIHZl
cnkgY2xvc2UgdG8gemVybywgSSdkIHdyaXRlIHRoYXQgQVNNIGhhY2sKPiA+bXlzZWxmLCBidXQg
dGhhdCdzIGdvaW5nIHRvIGNvc3QgbW9yZSBvZiBteSBhbmQgeW91ciB0aW1lIHRoYW4gaXQncwo+
ID53b3J0aCB0aGUgdHJvdWJsZSwKPiA+Cj4gPkhtbS4gSSBjb3VsZCBkZWxlZ2F0ZSB0aGF0IHRv
IExpbnVzLCBoZSBtaWdodCBzdGlsbCByZW1lbWJlciA6KQo+ID4KPiA+VGhhbmtzLAo+ID4KPiA+
ICAgICAgICB0Z2x4Cj4KPiBEb2VzICphbnlvbmUqIGFjdHVhbGx5IHJ1biBBbHBoYSBhdCB0aGlz
IHBvaW50PwoKSSBkbywgYXMgcGFydCBvZiBtYWludGFpbmluZyB0aGUgR2VudG9vIGRpc3RyaWJ1
dGlvbiBmb3IgQWxwaGEuCgpJJ20gbGlzdGVkIGluIE1BSU5UQUlORVJTLCBidXQgcmVhbGx5IG9u
bHkgc28gSSBjYW4gY29sbGVjdCBwYXRjaGVzCnNlbmQgdGhlbSB0byBMaW51cyBhZnRlciB0ZXN0
aW5nLiBJIGRvbid0IGhhdmUgY29waW91cyBhbW91bnRzIG9mIGZyZWUKdGltZSB0byBiZSBwcm9h
Y3RpdmUgaW4ga2VybmVsIGRldmVsb3BtZW50IGFuZCBpdCdzIGFsc28gbm90IHJlYWxseSBteQph
cmVhIG9mIGV4cGVydGlzZSBzbyBJJ20gbm93aGVyZSBuZWFyIGVmZmVjdGl2ZSBhdCBpdC4KCkkg
d291bGQgYmUgaGFwcHkgdG8gdGVzdCBhbnkgcGF0Y2hlcyBzZW50IG15IHdheSAoYnV0IEkgYWNr
bm93bGVkZ2UKdGhhdCB3cml0aW5nIHRoZXNlIHBhdGNoZXMgd291bGRuJ3QgYmUgaGlnaCBvbiBh
bnlvbmUncyBwcmlvcml0eSBsaXN0LApldGMpCgooQSB2aWRlbyBteSBmcmllbmQgSWFuIGFuZCBJ
IG1hZGUgYWJvdXQgYSBwYXJ0aWN1bGFybHkgbGFyZ2UKQWxwaGFTZXJ2ZXIgSSBoYXZlIGluIG15
IGJhc2VtZW50LCBpbiBjYXNlIGFueW9uZSBpcyBpbnRlcmVzdGVkOgpodHRwczovL3d3dy55b3V0
dWJlLmNvbS93YXRjaD92PXo2NThhOEpzNXFnKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC11bQo=
