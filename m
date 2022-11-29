Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA7BC433FE
	for <linux-um@archiver.kernel.org>; Tue, 29 Nov 2022 15:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zJbAU64ZaUzFEL6Ybcvlt8R6FcdUdEP9bRPZVPK2X1s=; b=23CrU2NI/6ryRf
	NWz6uhbkb0pZySZ57WnMu2CJpjopH2ETB/dkRXnBQg4GrFOnCLnEKYU8yQGCZkuuomFG+lTqEnAs9
	2GW0P5hOWrzt2j1qlXGsgYpJRf+DvFRwexTUdDEvFjcTQjgEdd+ndOev8HTHwc9wcEkX++yx0DMa1
	awUg+QNYYCyxjFiV04nlK8D2qaVLqreNYw79jevIUs1d67cu7/N1h1w8PBISSbZv1aZv3kS05uBlr
	JFleZCDSWLNWwFxCHxV15xpkwTXSgSH9AMrquNCRZ/ygn5rFwTNkjUp/7uWZ8tDGtrJP55VlZP+SD
	JB46MVMTTdcSH8bwfPuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p02CW-009Zy5-7Q; Tue, 29 Nov 2022 15:07:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p02CC-009ZoY-MG; Tue, 29 Nov 2022 15:06:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0A25461783;
	Tue, 29 Nov 2022 15:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7237EC433D6;
	Tue, 29 Nov 2022 15:06:49 +0000 (UTC)
Date: Tue, 29 Nov 2022 10:06:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, kernel list
 <linux-kernel@vger.kernel.org>, "linux-ia64@vger.kernel.org"
 <linux-ia64@vger.kernel.org>, "linux-um@lists.infradead.org"
 <linux-um@lists.infradead.org>, Linux-Arch <linux-arch@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] compiler: inline does not imply notrace
Message-ID: <20221129100647.4957579e@gandalf.local.home>
In-Reply-To: <2CFF9131-48E9-44D3-93CA-976C47106092@vmware.com>
References: <20221122195329.252654-1-namit@vmware.com>
	<20221122195329.252654-4-namit@vmware.com>
	<de999ab8-78ff-44f7-aacc-68561897c6e2@app.fastmail.com>
	<B764D38F-470D-4022-A818-73814F442473@vmware.com>
	<4BDE3655-CCC3-412B-9DDB-226485113706@vmware.com>
	<20221128231532.40210855@gandalf.local.home>
	<2CFF9131-48E9-44D3-93CA-976C47106092@vmware.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_070652_855554_DF327B9A 
X-CRM114-Status: GOOD (  26.48  )
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

T24gVHVlLCAyOSBOb3YgMjAyMiAwNDoyNTozOCArMDAwMApOYWRhdiBBbWl0IDxuYW1pdEB2bXdh
cmUuY29tPiB3cm90ZToKCgo+IEkgd2lsbCBuZWVkIHRvIGZ1cnRoZXIgZGVidWcgaXQsIGJ1dCB0
aGlzIGlzc3VlIGRvZXMgbm90IG9jY3VyIGV2ZXJ5IHRpbWUuCj4gCj4gVGhlIGtlcm5lbCBkaWRu
4oCZdCBjcmFzaCBleGFjdGx5IC0gaXTigJlzIG1vcmUgb2YgYSBkZWFkbG9jay4gSSBoYXZlIGxv
Y2tkZXAKPiBlbmFibGVkLCBzbyBpdCBpcyBub3QgYSBkZWFkbG9jayB0aGF0IGxvY2tkZXAga25v
d3MuIENvdWxkIGl0IGJlIHRoYXQKPiBzb21laG93IHRoaW5ncyBqdXN0IHNsb3dlZCBkb3duIGR1
ZSB0byBJUElzIGFuZCBtb3N0bHktZGlzYWJsZWQgSVJRcz8gSSBoYXZlCj4gbm8gaWRlYS4gSSB3
b3VsZCBuZWVkIHRvIHJlY3JlYXRlIHRoZSBzY2VuYXJpby4gCgpZb3UgaGF2ZSBsb2NrZGVwIGVu
YWJsZWQgYW5kIHlvdSBhcmUgcnVubmluZyBmdW5jdGlvbiB0cmFjaW5nIHdpdGggc3RhY2sKdHJh
Y2Ugb24/IFNvIHlvdSBhcmUgZG9pbmcgYSBzdGFjayB0cmFjZSBvbiAqZXZlcnkqIGZ1bmN0aW9u
IHRoYXQgaXMgdHJhY2VkPwoKSSBkb24ndCB0aGluayB5b3UgaGl0IGEgZGVhZGxvY2ssIEkgdGhp
bmsgeW91IGhpdCBhIGxpdmUgbG9jay4gWW91IGNvdWxkCnBvc3NpYmx5IHNsb3cgdGhlIHN5c3Rl
bSBkb3duIHNvIG11Y2ggdGhhdCB3aGVuIGFuIGludGVycnVwdCBmaW5pc2hlcyBpdCdzCnRpbWUg
Zm9yIGl0IHRvIGJlIHRyaWdnZXJlZCBhZ2FpbiwgYW5kIHlvdSBuZXZlciBtYWtlIGZvcndhcmQg
cHJvZ3Jlc3MuCgo+IAo+IEZvciB0aGUgcmVjb3JkLCBJIHRyaWVkIHRvIHNhdmVkIHNvbWUgZGV0
YWlscyBpbiB0aGUgcHJldmlvdXMgZW1haWwuIEl0IHdhcwo+IGtpbmQgb2YgaGFyZCB0byB1bmRl
cnN0YW5kIHdoYXTigJlzIGdvaW5nIG9uIG9uIHRoZSBvdGhlciBjb3Jlcywgc2luY2UgdGhlCj4g
dHJhY2Ugb2Ygb3RoZXIgY29yZXMgd2FzIGludGVybGVhdmVkLiBJIGV4dHJhY3QgdGhlIHBhcnRz
IGZyb20gdGhhdCBJIHRoaW5rCj4gdGhlIHJlZmVyIHRvIHRoZSBhbm90aGVyIENQVSAoeWVzLCB0
aGUgb3V0cHV0IGlzIHJlYWxseSBzbG93LCBhcyBzZWVuIGluIHRoZQo+IHRpbWVzdGFtcHMpOgo+
IAo+IFs1MzE0MTMuOTIzNjI4XSBDb2RlOiAwMCAwMCAzMSBjMCBlYiBmMSAwZiAxZiA4MCAwMCAw
MCAwMCAwMCBlOCAxYiAyZSAxNiAzZSA1NSA0OCA4OSBlNSBjNiAwNyAwMCAwZiAxZiAwMCBmNyBj
NiAwMCAwMiAwMCAwMCA3NCAwNiBmYiAwZiAxZiA0NCAwMCAwMCA8YmY+IDAxIDAwIDAwIDAwIGU4
IDk5IGRhIGYxIGZlIDY1IDhiIDA1IGYyIDk5IGQ3IDdkIDg1IGMwIDc0IDAyIDVkCj4gCj4gQWxs
IGNvZGUKPiA9PT09PT09PQo+IDA6IDAwIDAwIGFkZCAlYWwsKCVyYXgpCj4gMjogMzEgYzAgeG9y
ICVlYXgsJWVheAo+IDQ6IGViIGYxIGptcCAweGZmZmZmZmZmZmZmZmZmZjcKPiA2OiAwZiAxZiA4
MCAwMCAwMCAwMCAwMCBub3BsIDB4MCglcmF4KQo+IGQ6IGU4IDFiIDJlIDE2IDNlIGNhbGwgMHgz
ZTE2MmUyZAo+IDEyOiA1NSBwdXNoICVyYnAKPiAxMzogNDggODkgZTUgbW92ICVyc3AsJXJicAo+
IDE2OiBjNiAwNyAwMCBtb3ZiICQweDAsKCVyZGkpCj4gMTk6IDBmIDFmIDAwIG5vcGwgKCVyYXgp
Cj4gMWM6IGY3IGM2IDAwIDAyIDAwIDAwIHRlc3QgJDB4MjAwLCVlc2kKPiAyMjogNzQgMDYgamUg
MHgyYQo+IDI0OiBmYiBzdGkgCj4gMjU6IDBmIDFmIDQ0IDAwIDAwIG5vcGwgMHgwKCVyYXgsJXJh
eCwxKQo+IDJhOiogYmYgMDEgMDAgMDAgMDAgbW92ICQweDEsJWVkaSA8LS0gdHJhcHBpbmcgaW5z
dHJ1Y3Rpb24KPiAyZjogZTggOTkgZGEgZjEgZmUgY2FsbCAweGZmZmZmZmZmZmVmMWRhY2QKPiAz
NDogNjUgOGIgMDUgZjIgOTkgZDcgN2QgbW92ICVnczoweDdkZDc5OWYyKCVyaXApLCVlYXggIyAw
eDdkZDc5YTJkCj4gM2I6IDg1IGMwIHRlc3QgJWVheCwlZWF4Cj4gM2Q6IDc0IDAyIGplIDB4NDEK
PiAzZjogNWQgcG9wICVyYnAKPiAKPiBDb2RlIHN0YXJ0aW5nIHdpdGggdGhlIGZhdWx0aW5nIGlu
c3RydWN0aW9uCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+
IDA6IGJmIDAxIDAwIDAwIDAwIG1vdiAkMHgxLCVlZGkKPiA1OiBlOCA5OSBkYSBmMSBmZSBjYWxs
IDB4ZmZmZmZmZmZmZWYxZGFhMwo+IGE6IDY1IDhiIDA1IGYyIDk5IGQ3IDdkIG1vdiAlZ3M6MHg3
ZGQ3OTlmMiglcmlwKSwlZWF4ICMgMHg3ZGQ3OWEwMwo+IDExOiA4NSBjMCB0ZXN0ICVlYXgsJWVh
eAo+IDEzOiA3NCAwMiBqZSAweDE3Cj4gMTU6IDVkIHBvcCAlcmJwCj4gCj4gWzUzMTQxNC4wNjY3
NjVdIFJTUDogMDAxODpmZmZmYzkwMDBjOWE3N2Q4IEVGTEFHUzogMDAwMDAyMDYKPiBbNTMxNDE0
LjA3Nzk0M10gUklQOiAwMDEwOnNtcF9jYWxsX2Z1bmN0aW9uX21hbnlfY29uZCAoa2VybmVsL3Nt
cC5jOjQ0MyBrZXJuZWwvc21wLmM6OTg4KSAKPiBbNTMxNDE2Ljk4NzM1MV0gb25fZWFjaF9jcHVf
Y29uZF9tYXNrIChrZXJuZWwvc21wLmM6MTE1NSkgCj4gWzUzMTQxNi4yMDU4NjJdID8gdGV4dF9w
b2tlX21lbXNldCAoYXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZlLmM6MTI5NikgCj4gWzUzMTQx
Ni42ODEyOTRdID8gdGV4dF9wb2tlX21lbXNldCAoYXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZl
LmM6MTI5NikgCj4gWzUzMTQxNy40Njg0NDNdIHRleHRfcG9rZV9icF9iYXRjaCAoYXJjaC94ODYv
a2VybmVsL2FsdGVybmF0aXZlLmM6MTU1MykgCj4gWzUzMTQxOC45Mzk5MjNdIGFyY2hfZnRyYWNl
X3VwZGF0ZV90cmFtcG9saW5lIChhcmNoL3g4Ni9rZXJuZWwvZnRyYWNlLmM6NTAwKQo+IFs1MzE0
MTkuODgyMDU1XSA/IGZ0cmFjZV9ub19waWRfd3JpdGUgKGtlcm5lbC90cmFjZS9mdHJhY2UuYzo3
ODY0KSAKPiBbNTMxNDIwLjUxMDM3Nl0gZnRyYWNlX3VwZGF0ZV9waWRfZnVuYyAoa2VybmVsL3Ry
YWNlL2Z0cmFjZS5jOjM3NCAoZGlzY3JpbWluYXRvciAxKSkKPiBbNTMxNDIwLjc4NDcwM10gZnRy
YWNlX3BpZF9vcGVuIChrZXJuZWwvdHJhY2UvZnRyYWNlLmM6MjkxOCBrZXJuZWwvdHJhY2UvZnRy
YWNlLmM6MjkzMiBrZXJuZWwvdHJhY2UvZnRyYWNlLmM6NzcyNSBrZXJuZWwvdHJhY2UvZnRyYWNl
LmM6NzgzNSBrZXJuZWwvdHJhY2UvZnRyYWNlLmM6Nzg2NSkgCj4gWzUzMTQyMS44NTEyOTRdIHZm
c19vcGVuIChmcy9vcGVuLmM6MTAxNykKPiAKPiAKPiAKCkRvIHlvdSBoYXZlIGFuIGlzc3VlIHdp
dGggbm9ybWFsIGZ1bmN0aW9uIHRyYWNpbmcsIGFuZCBub3QgdHJhY2luZyBldmVyeQpmdW5jdGlv
bi4KCkkgc2hvdWxkIGFsc28gYWRkIHRoaXMsIGJlY2F1c2UgaXQgZGV0ZWN0cyByZWN1cnNpb24g
ZmFzdGVyIHRoYW4gdGhlCmF0b21pY19pbmNfcmV0dXJuKCkgZG9lcy4KCi0tIFN0ZXZlCgpkaWZm
IC0tZ2l0IGEva2VybmVsL3RyYWNlL3RyYWNlX2Z1bmN0aW9ucy5jIGIva2VybmVsL3RyYWNlL3Ry
YWNlX2Z1bmN0aW9ucy5jCmluZGV4IDlmMWJmYmUxMDVlOC4uOTNlYzc1NmRjMjRiIDEwMDY0NAot
LS0gYS9rZXJuZWwvdHJhY2UvdHJhY2VfZnVuY3Rpb25zLmMKKysrIGIva2VybmVsL3RyYWNlL3Ry
YWNlX2Z1bmN0aW9ucy5jCkBAIC0yMjEsMTIgKzIyMSwxOCBAQCBmdW5jdGlvbl9zdGFja190cmFj
ZV9jYWxsKHVuc2lnbmVkIGxvbmcgaXAsIHVuc2lnbmVkIGxvbmcgcGFyZW50X2lwLAogCXN0cnVj
dCB0cmFjZV9hcnJheV9jcHUgKmRhdGE7CiAJdW5zaWduZWQgbG9uZyBmbGFnczsKIAlsb25nIGRp
c2FibGVkOworCWludCBiaXQ7CiAJaW50IGNwdTsKIAl1bnNpZ25lZCBpbnQgdHJhY2VfY3R4Owog
CiAJaWYgKHVubGlrZWx5KCF0ci0+ZnVuY3Rpb25fZW5hYmxlZCkpCiAJCXJldHVybjsKIAorCS8q
IEZhc3RlciB0aGFuIGF0b21pY19pbmNfcmV0dXJuKCkgKi8KKwliaXQgPSBmdHJhY2VfdGVzdF9y
ZWN1cnNpb25fdHJ5bG9jayhpcCwgcGFyZW50X2lwKTsKKwlpZiAoYml0IDwgMCkKKwkJcmV0dXJu
OworCiAJLyoKIAkgKiBOZWVkIHRvIHVzZSByYXcsIHNpbmNlIHRoaXMgbXVzdCBiZSBjYWxsZWQg
YmVmb3JlIHRoZQogCSAqIHJlY3Vyc2l2ZSBwcm90ZWN0aW9uIGlzIHBlcmZvcm1lZC4KQEAgLTI0
NCw2ICsyNTAsNyBAQCBmdW5jdGlvbl9zdGFja190cmFjZV9jYWxsKHVuc2lnbmVkIGxvbmcgaXAs
IHVuc2lnbmVkIGxvbmcgcGFyZW50X2lwLAogCiAJYXRvbWljX2RlYygmZGF0YS0+ZGlzYWJsZWQp
OwogCWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsKKwlmdHJhY2VfdGVzdF9yZWN1cnNpb25fdW5s
b2NrKGJpdCk7CiB9CiAKIHN0YXRpYyBpbmxpbmUgYm9vbCBpc19yZXBlYXRfY2hlY2soc3RydWN0
IHRyYWNlX2FycmF5ICp0ciwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
