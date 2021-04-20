Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYkED-00BrKe-Cb
 for linux-um@lists.infradead.org; Tue, 20 Apr 2021 06:51:26 +0000
Message-ID: <4f6922f1739dc675d50130a3c07bf28a2bc6f380.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: Fix stack pointer alignment
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 20 Apr 2021 08:51:17 +0200
In-Reply-To: <CABqSeAQdwhJCTyO9w6f2cmyobh2bnA5wG6ZgCS9gD0b7ZSi=yw@mail.gmail.com>
 (sfid-20210420_074740_851869_49DF5D49)
References: <20210419153213.1337562-1-zhuyifei1999@gmail.com>
 <546324c4e77ebe65f27b0f06fea3ace28dd75fe6.camel@sipsolutions.net>
 <CABqSeASZLeK8dq-75dcM51zmkHUteuJc07bS8ixKVhEAAeuPDw@mail.gmail.com>
 <CABqSeAQdwhJCTyO9w6f2cmyobh2bnA5wG6ZgCS9gD0b7ZSi=yw@mail.gmail.com>
 (sfid-20210420_074740_851869_49DF5D49)
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
To: YiFei Zhu <zhuyifei1999@gmail.com>, Colin Ian King <colin.king@canonical.com>
Cc: linux-um@lists.infradead.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Benjamin Berg <benjamin@sipsolutions.net>

PiAKPiBJdCBzZWVtcyBjb25maWcgcmVsYXRlZC4gSSB0ZXN0ZWQgd2l0aCBteSBvcmlnaW5hbCBj
b25maWcgYW5kIGl0Cj4gc2VnZmF1bHQgbG9vcHMsIGJ1dCB0aGVuIEkgdGVzdGVkIHdpdGggYSBm
cmVzaCBkZWZjb25maWcsIHRoZW4gZW5hYmxlZAo+IFJUQ19DTEFTUyBhbmQgVU1MX1JUQyBhbmQg
aXQgYm9vdHMgc3VjY2Vzc2Z1bGx5LCB3aXRoIHRoZSBhc3NlbWJseSBhczoKPiAKPiDCoMKgbW92
YXBzICglcmR4KSwleG1tMAo+IMKgwqBtb3ZhcHMgJXhtbTAsKCVyMTIpCj4gCj4gVGhlIG1vdmUg
ZnJvbSB4bW0wIHRvIHN0YWNrIGlzIG9taXR0ZWQuCj4gCj4gQWZ0ZXIgYSBiaXQgb2YgdHJpYWwg
YW5kIGVycm9yIEkgZm91bmQgY2hhbmdpbmcgZnJvbQo+IENDX09QVElNSVpFX0ZPUl9TSVpFIHRv
IENDX09QVElNSVpFX0ZPUl9QRVJGT1JNQU5DRSBhbG9uZSBtYWtlcyB0aGUKPiBkaWZmZXJlbmNl
LiBXaGF0J3MgYWxzbyBpbnRlcmVzdGluZyBpcyB0aGF0IGluc3RlYWQgb2YKPiBzZWdmYXVsdC1s
b29waW5nIChhcyBpbiwgc2VnZmF1bHQgcmVjb3ZlcnkgZGlkIG5vdCBkbyBhbnl0aGluZyB0byBm
aXgKPiB0aGUgZmF1bHQsIHNvIGFmdGVyIHNpZ3JldHVybiBpdCBzZWdmYXVsdHMgYWdhaW4pLCBp
dCBwYW5pY3Mgd2l0aAo+ICJTZWdmYXVsdCB3aXRoIG5vIG1tIiB3aGljaCBzZWVtcyBtb3JlIGxp
a2UgdGhlIGV4cGVjdGVkIGJlaGF2aW9yLgoKQWhhLCBpbnRlcmVzdGluZy4KCj4gCj4gSSdsbCBz
ZW5kIGEgdjMgdG8gY2xhcmlmeSBDQ19PUFRJTUlaRV9GT1JfUEVSRk9STUFOQ0UuCgpDb29sLCB0
aGFua3MgZm9yIGFsbCB0aGUgZGlnZ2luZyBhbmQgZml4ZXMhCgpqb2hhbm5lcwoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcg
bGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

