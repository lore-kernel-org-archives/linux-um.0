Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLXc7-00EWjE-CP
 for linux-um@lists.infradead.org; Sun, 14 Mar 2021 20:45:34 +0000
Message-ID: <5e1f64997ffca8267bde7955fe2eb214dfb9e891.camel@sipsolutions.net>
Subject: Re: [RFC v8 13/20] um: lkl: integrate with irq infrastructure of UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sun, 14 Mar 2021 21:45:23 +0100
In-Reply-To: <46935454bf02224fb325f0e74d60d0ed674a59f9.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
 <46935454bf02224fb325f0e74d60d0ed674a59f9.1611103406.git.thehajime@gmail.com>
MIME-Version: 1.0
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: tavi.purdila@gmail.com, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, retrage01@gmail.com

T24gV2VkLCAyMDIxLTAxLTIwIGF0IDExOjI3ICswOTAwLCBIYWppbWUgVGF6YWtpIHdyb3RlOgo+
IMKgc3RhdGljIGlycXJldHVybl90IHVtX3RpbWVyKGludCBpcnEsIHZvaWQgKmRldikKPiDCoHsK
PiArI2lmbmRlZiBDT05GSUdfVU1NT0RFX0xJQgo+IMKgCWlmIChnZXRfY3VycmVudCgpLT5tbSAh
PSBOVUxMKQoKV2h5IGlzIHRoZSBpZmRlZiBuZWVkZWQgLSBnZXRfY3VycmVudCgpLT5tbSBzaG91
bGQgYWx3YXlzIGJlIE5VTEwgZm9yCkxLTD8gU3VyZWx5IGdldF9jdXJyZW50KCkgbXVzdCBzdGls
bCB3b3JrPwoKPiDCoAlzaWdlbXB0eXNldCgmc2lnX21hc2spOwo+IMKgCXNpZ2FkZHNldCgmc2ln
X21hc2ssIHNpZyk7Cj4gLQlpZiAoc2lncHJvY21hc2soU0lHX1VOQkxPQ0ssICZzaWdfbWFzaywg
TlVMTCkgPCAwKQo+IC0JCXBhbmljKCJzaWdwcm9jbWFzayBmYWlsZWQgLSBlcnJubyA9ICVkXG4i
LCBlcnJubyk7Cj4gKwlpZiAocHRocmVhZF9zaWdtYXNrKFNJR19VTkJMT0NLLCAmc2lnX21hc2ss
IE5VTEwpIDwgMCkKPiArCQlwYW5pYygicHRocmVhZF9zaWdtYXNrIGZhaWxlZCAtIGVycm5vID0g
JWRcbiIsIGVycm5vKTsKClVNTCBkb2Vzbid0IG5vcm1hbGx5IGxpbmsgd2l0aCBsaWJwdGhyZWFk
LCBhbmQgTEtMIGRvZXNuJ3QgYWN0dWFsbHkKYXBwZWFyIHRvIHJlcXVpcmUgaXQgZWl0aGVyIChz
aW5jZSBpdCBoYXMgaXRzIGxrbF90aHJlYWQgYW5kIGFsbCksIHNvCnRoaXMgc2VlbXMgd3Jvbmc/
Cgpqb2hhbm5lcwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

