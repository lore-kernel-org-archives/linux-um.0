Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB36C7EE2F
	for <linux-um@archiver.kernel.org>; Fri, 26 May 2023 05:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ad70k671v8y+KJ61vzuL825ZOa/hxu27+VJuKv/g4vw=; b=cjgZFOlWvD7N2T
	fabwOldzRQcgvaSTWdUMBnP0w7Afw498M2gKdCaILvQ6Aa4ZizEjQ+kK9iyjOW3IljpFJrMMkH9iT
	5BKcukgZ2R3wc4hMUPJh0hbyyU9COdhDB5EZXvXYQxM+1BOVNdcW5AYlPs5aOxpGP0rWR7yGS7PaD
	1NfPORETHTKb2KfWlkz6bVzTrpjm8cEFv336HsHwouCc/PQ1UBnkCjhPfCDRtoZsZxLiRkxwpvYrr
	7eVhDaNkiWFj675Si4L11Xi8xOz10OItzvMll+tlott0UWYhKSPAeMMaHCESFrytzQU6Dc4Fnhh4F
	vm/U5yQ37COVPAkjTJwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2QBi-0018WA-06;
	Fri, 26 May 2023 05:40:30 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2QBe-0018Uq-2M;
	Fri, 26 May 2023 05:40:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 42FB564C7A;
	Fri, 26 May 2023 05:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66082C433EF;
	Fri, 26 May 2023 05:40:22 +0000 (UTC)
Date: Fri, 26 May 2023 01:40:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
 linux-ia64@vger.kernel.org, linux-um@lists.infradead.org, Linux-Arch
 <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Andy
 Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>, X86 ML
 <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/3] compiler: inline does not imply notrace
Message-ID: <20230526014018.5ebafc55@rorschach.local.home>
In-Reply-To: <D4B1FB24-C351-411B-8A40-4DAFE95FA921@gmail.com>
References: <20230525210040.3637-1-namit@vmware.com>
	<20230525210040.3637-3-namit@vmware.com>
	<20230525222844.6a0d84f8@rorschach.local.home>
	<D4B1FB24-C351-411B-8A40-4DAFE95FA921@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_224026_828781_32D8C625 
X-CRM114-Status: UNSURE (   7.89  )
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

T24gVGh1LCAyNSBNYXkgMjAyMyAyMjoxNzozMyAtMDcwMApOYWRhdiBBbWl0IDxuYWRhdi5hbWl0
QGdtYWlsLmNvbT4gd3JvdGU6Cgo+IFVnaC4gSWYgeW91IGNj4oCZZCBtZSwgSSB3b3VsZG7igJl0
IGJvdGhlciB5b3UgZHVyaW5nIHlvdXIgdmFjYXRpb24uIDopCgpPaCwgYW5kIGlmIHlvdSBhcmUg
aW50ZXJlc3RlZCBpbiB0cmFjaW5nIHBhdGNoZXMsIGp1c3Qgc3Vic2NyaWJlIHRvCmxpbnV4LXRy
YWNlLWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcuCgotLSBTdGV2ZQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4
LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC11bQo=
