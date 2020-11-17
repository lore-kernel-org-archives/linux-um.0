Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keyoP-0001U0-9M
 for linux-um@lists.infradead.org; Tue, 17 Nov 2020 11:06:33 +0000
Message-ID: <a5ad1be201a7488bdc317bc72776f1465347504f.camel@sipsolutions.net>
Subject: Re: [PATCH] um: borrow bitops from the x86 tree
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 17 Nov 2020 12:05:51 +0100
In-Reply-To: <20201116144426.8415-1-anton.ivanov@cambridgegreys.com>
References: <20201116144426.8415-1-anton.ivanov@cambridgegreys.com>
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
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: richard@nod.at

SGkgQW50b24sCgpTbyBJIHRob3VnaHQgSSdkIHRlc3QgeW91ciBwZXJmb3JtYW5jZSBwYXRjaGVz
IGhlcmUsIGFuZCBhcHBsaWVkCihob3BlZnVsbHkgdGhlIGxhdGVzdCB2ZXJzaW9ucyBvZikgb24g
dG9wIG9mIDUuOToKCiAgICAgIHVtOiBhbGxvdyB0aGUgdXNlIG9mIGdsaWJjIGZ1bmN0aW9ucyBp
bnN0ZWFkIG9mIGJ1aWx0aW5zCiAgICAgIHVtOiBGZXRjaCByZWdpc3RlcnMgb25seSBmb3Igc2ln
bmFscyB3aGljaCBuZWVkIHRoZW0KICAgICAgdW06IGVuYWJsZSB0aGUgdXNlIG9mIG9wdGltaXpl
ZCB4b3Igcm91dGluZXMgaW4gVU1MCiAgICAgIHVtOiBhZGQgYSBVTUwgc3BlY2lmaWMgZnV0ZXgg
aW1wbGVtZW50YXRpb24KICAgICAgdW06IFJlbW92ZSB1c2Ugb2YgYXNwcmluZiBpbiB1bWlkLmMK
ICAgICAgdW06ICJib3Jyb3ciIGF0b21pY3MgZnJvbSB4ODYgYXJjaGl0ZWN0dXJlCiAgICAgIHVt
OiAiYm9ycm93IiBjbXB4Y2hnIGZyb20geDg2IHRyZWUgaW4gVU1MCiAgICAgIHVtOiBib3Jyb3cg
Yml0b3BzIGZyb20gdGhlIHg4NiB0cmVlCgoKV2l0aCB0aGUgcGF0Y2hlcyAoY29tcGlsZWQgd2l0
aCBnbGliYyBmdW5jdGlvbnMpLCBvbmUgb2YgbXkgdHJpdmlhbAp2aXJ0dWFsIGxhYiB0ZXN0cyBn
ZXRzOgoKICBUaW1lIChtZWFuIMKxIM+DKTogICAgIDE1LjkxOCBzIMKxICAwLjgzMyBzICAgIFtV
c2VyOiAxMC45NzcgcywgU3lzdGVtOiA1LjYwMCBzXQogIFJhbmdlIChtaW4g4oCmIG1heCk6ICAg
MTUuMzcxIHMg4oCmIDE3Ljk4NiBzICAgIDEwIHJ1bnMKCkl0J3Mgbm90IGEgbGFyZ2UgaW1wcm92
ZW1lbnQsIGl0IHNlZW1zIG5vdGljYWJsZTsgd2l0aG91dCB0aGUgcGF0Y2hlcyBJCmdldDoKCiAg
VGltZSAobWVhbiDCsSDPgyk6ICAgICAxNi41MjUgcyDCsSAgMC44ODQgcyAgICBbVXNlcjogMTEu
MzU1IHMsIFN5c3RlbTogNS42NDggc10KICBSYW5nZSAobWluIOKApiBtYXgpOiAgIDE1LjY4MiBz
IOKApiAxOC4wODggcyAgICAxMCBydW5zCgpqb2hhbm5lcwoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11
bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtdW0K

