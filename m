Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C931CE79A9
	for <linux-um@archiver.kernel.org>; Tue, 19 Sep 2023 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ZPYrufFG2Z2DTkgwxcK0h5BuNi1xzeunWIWoHF581BI=; b=t+Gh6JvG/YxZf1y1Moc6kHu8JY
	QGqibvjJT0G9EGX33MMyLAKzuqepgGs2TJnas6rxuznqHEbvdUrMSuoyDbkHRiEnL91k/lFfs9fiv
	niG3uRNTUh9mCDT45WPTpUngExUeeHCqEisyrWnvFZF1dWlJx/dA72o84eJyFqtBf0UMk7U4Jd9+m
	qPyER7XVk7gLLjsivs5FaJ6AydKg1amXQP/D13rxpElHI5EltRiB2SiDR0e+uGGs2K3mKz6xz7KZO
	bUb8LsFF2XhzDqtWmK8kTCHjO+Yx4cORxuGADDDhlnDnJjRCIeGw36WGof1NoldAfbMRTb7pEm7GZ
	tz4CXGYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qidVC-000qv4-0F;
	Tue, 19 Sep 2023 16:23:06 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qidV9-000qt7-26
	for linux-um@lists.infradead.org;
	Tue, 19 Sep 2023 16:23:05 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5074A635DB51;
	Tue, 19 Sep 2023 18:22:48 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id m6Ardn4BMmQu; Tue, 19 Sep 2023 18:22:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6D072622F591;
	Tue, 19 Sep 2023 18:22:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rJmHKg4qnWLe; Tue, 19 Sep 2023 18:22:47 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 16951635DB51;
	Tue, 19 Sep 2023 18:22:47 +0200 (CEST)
Date: Tue, 19 Sep 2023 18:22:46 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: anton ivanov <anton.ivanov@cambridgegreys.com>
Cc: tglx <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Matthew Wilcox <willy@infradead.org>, 
	torvalds <torvalds@linux-foundation.org>, 
	Ankur Arora <ankur.a.arora@oracle.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, x86 <x86@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
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
	linux-um <linux-um@lists.infradead.org>, 
	Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, 
	linux-alpha <linux-alpha@vger.kernel.org>
Message-ID: <551475267.58816.1695140566849.JavaMail.zimbra@nod.at>
In-Reply-To: <9a5c0856-d542-9912-7494-53d7fe4538a3@cambridgegreys.com>
References: <87zg1u1h5t.fsf@oracle.com> <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org> <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de> <20230919134218.GA39281@noisy.programming.kicks-ass.net> <bd664a61-4506-bab0-19c3-0011f57005b5@cambridgegreys.com> <87y1h2ur98.ffs@tglx> <9a5c0856-d542-9912-7494-53d7fe4538a3@cambridgegreys.com>
Subject: Re: Arches that don't support PREEMPT
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Arches that don't support PREEMPT
Thread-Index: bIFTlUwZ+xXV2WWntYYwoPsb2f3c+g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_092303_863066_B8E9582F 
X-CRM114-Status: UNSURE (   7.34  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogImFudG9uIGl2YW5vdiIgPGFu
dG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+Cj4gSXQncyBiZWVuIGEgd2hpbGUuIEkgcmVt
ZW1iZXIgdGhhdCBJIGRyb3BwZWQgaXQgYXQgdGhlIHRpbWUsIGJ1dCBkbyBub3QgcmVtZW1iZXIK
PiB0aGUgZnVsbCBkZXRhaWxzLgo+IAo+IFRoZXJlIHdhcyBzb21lIHN0dWZmIHJlbGF0ZWQgdG8g
RlAgc3RhdGUgYW5kIGEgZmV3IG90aGVyIGlzc3VlcyBJIHJhbiBpbnRvIHdoaWxlCj4gcmV3cml0
aW5nIHRoZSBpbnRlcnJ1cHQgY29udHJvbGxlci4gU29tZSBvZiBpdCBtYXkgYmUgcmVzb2x2ZWQg
Ynkgbm93IGFzIHdlIGFyZQo+IHVzaW5nIGhvc3QgY3B1IGZsYWdzLCBldGMuCgpJIHJlbWVtYmVy
IGFsc28gaGF2aW5nIGEgaGFja3kgYnV0IHdvcmtpbmcgdmVyc2lvbiBhbG1vc3QgMTAgeWVhcnMg
YWdvLgpJdCB3YXMgaG9ycmlibGUgc2xvdyBiZWNhdXNlIG9mIHRoZSBleHRyYSBzY2hlZHVsZXIg
cm91bmRzLgpCdXQgeWVzLCBpZiBQUkVFTVBUIHdpbGwgYmUgYSBtdXN0LWhhdmUgZmVhdHVyZSB3
ZSdsbCBoYXZlIHRvIHRyeSBhZ2Fpbi4KClRoYW5rcywKLy9yaWNoYXJkCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QK
bGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
