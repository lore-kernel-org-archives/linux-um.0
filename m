Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPATl-00075U-HD
 for linux-um@lists.infradead.org; Sun, 04 Oct 2020 20:19:37 +0000
Date: Sun, 4 Oct 2020 22:19:26 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1305115038.161075.1601842766588.JavaMail.zimbra@nod.at>
In-Reply-To: <def18938e845a5db49764aee03bceff614a4e040.camel@sipsolutions.net>
References: <20201004050436.1406738-1-krisman@collabora.com>
 <def18938e845a5db49764aee03bceff614a4e040.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Remove dead usage of TIF_IA32
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, oleg@redhat.com, kernel@collabora.com, Gabriel Krisman Bertazi <krisman@collabora.com>, anton ivanov <anton.ivanov@cambridgegreys.com>

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIkpvaGFubmVzIEJlcmciIDxq
b2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pgo+IEFuOiAiR2FicmllbCBLcmlzbWFuIEJlcnRhemki
IDxrcmlzbWFuQGNvbGxhYm9yYS5jb20+LCAiSmVmZiBEaWtlIiA8amRpa2VAYWRkdG9pdC5jb20+
LCAicmljaGFyZCIgPHJpY2hhcmRAbm9kLmF0PiwKPiAiYW50b24gaXZhbm92IiA8YW50b24uaXZh
bm92QGNhbWJyaWRnZWdyZXlzLmNvbT4KPiBDQzoga2VybmVsQGNvbGxhYm9yYS5jb20sICJsaW51
eC11bSIgPGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+LCBvbGVnQHJlZGhhdC5jb20KPiBH
ZXNlbmRldDogU29ubnRhZywgNC4gT2t0b2JlciAyMDIwIDIyOjEwOjE3Cj4gQmV0cmVmZjogUmU6
IFtQQVRDSF0gdW06IFJlbW92ZSBkZWFkIHVzYWdlIG9mIFRJRl9JQTMyCgo+IE9uIFN1biwgMjAy
MC0xMC0wNCBhdCAwMTowNCAtMDQwMCwgR2FicmllbCBLcmlzbWFuIEJlcnRhemkgd3JvdGU6Cj4+
IAo+PiBBbHNvLCBJIHRoaW5rIHRoZSB2YXJpYWJsZSBjbGVhbiB1cCBpdCBwZXJmb3JtcyBpcyBu
b3QgbmVlZGVkIGFzIDY0LWJpdAo+PiBVTUwgZG9lc24ndCBydW4gMzItYml0IGJpbmFyaWVzIGFz
IGZhciBhcyBJIGNhbiB0ZWxsCj4gCj4gWWVwLCB0aGF0J3MgdHJ1ZS4gSSB3YXMgbG9va2luZyBp
bnRvIGl0IG9uY2UgX3ZlcnlfIGJyaWVmbHksIGJ1dCBubyA6KQoKWWVwLiBVTUwgaGFzIG5vIElB
MzIgZW11bGF0aW9uIGFuZCBuZXZlciBoYWQuCkxvb2tzIGxpa2UgYSBjb3B5JnBhc3RlIGxlZnRv
dmVyLgoKVGhhbmtzLAovL3JpY2hhcmQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtdW0K

