Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12238C77B7A
	for <linux-um@archiver.kernel.org>; Fri, 26 May 2023 05:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Cc:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/oudbl1xQr0wUfCawdX4w1Z5vcBWFLv3H/e0QubSNLs=; b=5FbEJsZxwIEcS4
	lLja96Bxg+ut7YiQLoL/xATM++7Ip/SKJXYFko/e25qE2skFuy9ilB3CYLe81aEUCNY8TPSH5MxLh
	ue8tdwXYeTMGCwna6Mp5O5YwXC5UCZEPSSTq8UJfdVprk9lG5jBzjeXXNKlRAQQKwLRyimvurZHi0
	wAbtrlJ6w/Yzqc2v6UEpDKCAIBSi8yKDUVFWcSXjoI0pbAynS2WzJw4UGvn/wyzf9LuEesxNynrZw
	DMK7FZ5t6Y2m0Y3j3dgcmzAD9KdWnWvuJ9nuPRtQjiw/t5CfCescbqG/bMfx1iwpu7flZB8bxRwjA
	rQZTgA5mloRX0Rk1tv6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Ppn-0015q0-0Q;
	Fri, 26 May 2023 05:17:51 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Ppj-0015p7-3D;
	Fri, 26 May 2023 05:17:49 +0000
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-52cb78647ecso225529a12.1;
        Thu, 25 May 2023 22:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685078266; x=1687670266;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWf9VwGyh647NTiZdevjn4fWRBDqPDisfVmvbRXRIfk=;
        b=ULmbK/tlKpbG/0OYco5YqPz07KIeDGI392FrGQRRd5X/sGjlpCo4a87yBNW3cxtNbA
         W2eYVMaA2t0pOuXYqusBOn/RwRPfdTIvejBaNMhhow4WD5DWff30clr+pstQlXKttF/K
         y0XmmaqFR1A4GwpJGrzCyMMEfj/9kU1JV9qnr0dpR5r1F3wkHhws67vA2GZ6UfapwjSE
         cErl93ME80cFsBEwELelONHD/9FJXi6kqG7eMqMfQsHbSRWhOGG0S9nARk0sNKBS8RIe
         kAMfkfj91SW23srcdehbzbdpr8egtZf+vNR56trcxRm/x4dP1fjuuPgWYf/o64BehtCO
         +0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685078266; x=1687670266;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWf9VwGyh647NTiZdevjn4fWRBDqPDisfVmvbRXRIfk=;
        b=ROaaRvrgFiLFX8ATulybesnS2WPjdvIQZTqCl65cuDU4JqwP4qKDJkbVLR9y4vIaMe
         rNAof93GEuQzfCECxq7g+rtGpwXytmeRh5GgtGHGG/cPpD1GvkwAbNGUkvh+m4lDsdgh
         R/g8m31CEgPghPDsm+PHZrXuf+BK+dxD3FFNcYpUx3T5rYuj/UOY9AFkuWBNORWCjneW
         S4235su7YqeG8OUt+G8pGYfRQ31Y8GDdmOLg/9dG+3qMofdAUsxkfnHvBo17fGpnTZRx
         MttuoeFVXSC6Wwn6/WVlEXbBkoZ9wrjech6XTXRugpYIfYVtaJIGl22z+gmb0BeG43SJ
         Kobw==
X-Gm-Message-State: AC+VfDxV6sn/NKJs7gQIzDGZ2G6q2roJThnnNdLKlHZvjU0gW5xgWowl
	hDF3R/VoAkmIsc6dnWrk+fQlOnqSPM0=
X-Google-Smtp-Source: ACHHUZ6qj8+GYjFiOMejIOa+jxY/i8dC6DUy4jM2Qp7p/YGG0jjxM9Arj0MHjzHoPktoq+Tu9JxGCA==
X-Received: by 2002:a17:902:7788:b0:1a8:ce:afd1 with SMTP id o8-20020a170902778800b001a800ceafd1mr1218262pll.20.1685078265673;
        Thu, 25 May 2023 22:17:45 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902820200b001afd821c057sm2278222pln.58.2023.05.25.22.17.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2023 22:17:45 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH v2 2/3] compiler: inline does not imply notrace
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20230525222844.6a0d84f8@rorschach.local.home>
Date: Thu, 25 May 2023 22:17:33 -0700
Cc: Arnd Bergmann <arnd@arndb.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 LKML <linux-kernel@vger.kernel.org>,
 linux-ia64@vger.kernel.org,
 linux-um@lists.infradead.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 Andy Lutomirski <luto@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>,
 X86 ML <x86@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Message-Id: <D4B1FB24-C351-411B-8A40-4DAFE95FA921@gmail.com>
References: <20230525210040.3637-1-namit@vmware.com>
 <20230525210040.3637-3-namit@vmware.com>
 <20230525222844.6a0d84f8@rorschach.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
X-Mailer: Apple Mail (2.3731.500.231)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_221748_040075_552D077A 
X-CRM114-Status: GOOD (  16.28  )
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

Cgo+IE9uIE1heSAyNSwgMjAyMywgYXQgNzoyOCBQTSwgU3RldmVuIFJvc3RlZHQgPHJvc3RlZHRA
Z29vZG1pcy5vcmc+IHdyb3RlOgo+IAo+IE9uIFRodSwgMjUgTWF5IDIwMjMgMTQ6MDA6MzkgLTA3
MDAKPiBOYWRhdiBBbWl0IDxuYWRhdi5hbWl0QGdtYWlsLmNvbT4gd3JvdGU6Cj4gCj4+IEZyb206
IE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+Cj4+IAo+PiBGdW5jdGlvbnMgdGhhdCBhcmUg
bWFya2VkIGFzICJpbmxpbmUiIGFyZSBjdXJyZW50bHkgYWxzbyBub3QgdHJhY2FibGUuCj4+IFRo
aXMgbGltaXRzIHRyYWNpbmcgZnVuY3Rpb25hbGl0eSBmb3IgbWFueSBmdW5jdGlvbnMgZm9yIG5v
IHJlYXNvbi4KPj4gQXBwYXJlbnRseSwgdGhpcyBoYXMgYmVlbiBkb25lIGZvciB0d28gcmVhc29u
cy4KPj4gCj4+IEZpcnN0LCBhcyBkZXNjcmliZWQgaW4gY29tbWl0IDU5NjNlMzE3YjFlOWQyYSAo
ImZ0cmFjZS94ODY6IERvIG5vdAo+PiBjaGFuZ2Ugc3RhY2tzIGluIERFQlVHIHdoZW4gY2FsbGlu
ZyBsb2NrZGVwIiksIGl0IHdhcyBpbnRlbmRlZCB0bwo+PiBwcmV2ZW50IHNvbWUgZnVuY3Rpb25z
IHRoYXQgY2Fubm90IGJlIHRyYWNlZCBmcm9tIGJlaW5nIHRyYWNlZCBhcyB0aGVzZQo+PiBmdW5j
dGlvbnMgd2VyZSBtYXJrZWQgYXMgaW5saW5lIChhbW9uZyBvdGhlcnMpLgo+PiAKPj4gWWV0LCB0
aGlzIGNoYW5nZSBoYXMgYmVlbiBkb25lIGEgZGVjYWRlIGFnbywgYW5kIGFjY29yZGluZyB0byBT
dGV2ZW4KPj4gUm9zdGVkdCwgZnRyYWNlIHNob3VsZCBoYXZlIGltcHJvdmVkIGFuZCBob3BlZnVs
bHkgcmVzb2x2ZWQgbmVzdGVkCj4+IHRyYWNpbmcgaXNzdWVzIGJ5IG5vdy4gQXJndWFibHksIGlm
IGZ1bmN0aW9ucyB0aGF0IHNob3VsZCBiZSB0cmFjZWQgLQo+PiBmb3IgaW5zdGFuY2Ugc2luY2Ug
dGhleSBhcmUgdXNlZCBkdXJpbmcgdHJhY2luZyAtIHN0aWxsIGV4aXN0LCB0aGV5Cj4+IHNob3Vs
ZCBiZSBtYXJrZWQgYXMgbm90cmFjZSBleHBsaWNpdGx5Lgo+PiAKPj4gVGhlIHNlY29uZCByZWFz
b24sIHdoaWNoIFN0ZXZlbiByYWlzZWQsIGlzIHRoYXQgYXR0YWNoaW5nICJub3RyYWNlIiB0bwo+
PiAiaW5saW5lIiBwcmV2ZW50ZWQgdHJhY2luZyBkaWZmZXJlbmNlcyBiZXR3ZWVuIGRpZmZlcmVu
dCBjb25maWdzLCB3aGljaAo+PiBjYXVzZWQgdmFyaW91cyBwcm9ibGVtLiBUaGlzIGNvbnNpZGVy
YXRpb24gaXMgbm90IHZlcnkgc3Ryb25nLCBhbmQgdHlpbmcKPj4gImlubGluZSIgYW5kICJub3Ry
YWNlIiBkb2VzIG5vdCBzZWVtIHZlcnkgYmVuZWZpY2lhbC4gVGhlICJpbmxpbmUiCj4+IGtleXdv
cmQgaXMganVzdCBhIGhpbnQsIGFuZCBtYW55IGZ1bmN0aW9ucyBhcmUgY3VycmVudGx5IG5vdCB0
cmFjYWJsZQo+PiBkdWUgdG8gdGhpcyByZWFzb24uCj4+IAo+PiBEaXNjb25uZWN0ICJpbmxpbmUi
IGZyb20gIm5vdHJhY2UiLgo+IAo+IEZZSSwgSSBoYXZlIGEgcGF0Y2ggcXVldWVkIChzdGlsbCBu
ZWVkcyB0byBnbyB0aHJvdWdoIHRlc3RpbmcpIHRoYXQKPiBhbHJlYWR5IGRvZXMgdGhpcyA7LSkK
PiAKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA1MDIxNjQxMDIuMWE1MWNkYjRA
Z2FuZGFsZi5sb2NhbC5ob21lLwoKVWdoLiBJZiB5b3UgY2PigJlkIG1lLCBJIHdvdWxkbuKAmXQg
Ym90aGVyIHlvdSBkdXJpbmcgeW91ciB2YWNhdGlvbi4gOikKCkkgdGhpbmsgeW91IG1heSBsaWtl
IHRoZSBmaXJzdCBwYXRjaCBpbiBteSBzZXJpZXMgdG8gcHJlY2VkZSB0aGlzIHBhdGNoCnRob3Vn
aCBhcyBzb21lIG9mIHRoZSBmdW5jdGlvbiBJIG1hcmtlZCBhcyDigJxub3RyYWNlIiBhcmUgY3Vy
cmVudGx5IOKAnGlubGluZeKAnS4KCkxldCBtZSBrbm93IGhvdyB5b3Ugd2FudCB0byBwcm9jZWVk
LCBzbyBJIHdvdWxkIGtub3cgaG93IHRvIGJyZWFrIHRoaXMKc2VyaWVzLgoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlz
dApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
