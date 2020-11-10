Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcbGx-0000uu-PW
 for linux-um@lists.infradead.org; Tue, 10 Nov 2020 21:33:52 +0000
Subject: Re: [PATCH] um: allow using glibc string functions instead of generics
References: <20201110163034.22963-1-anton.ivanov@cambridgegreys.com>
 <1098264641.290574.1605039225057.JavaMail.zimbra@nod.at>
 <ee2da9e0-2858-ef9c-b8b9-bdf569ec9bb4@cambridgegreys.com>
 <1253718433.290759.1605043793706.JavaMail.zimbra@nod.at>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <de2e76d2-6adc-d9e9-7764-5d8ce22536bd@cambridgegreys.com>
Date: Tue, 10 Nov 2020 21:33:48 +0000
MIME-Version: 1.0
In-Reply-To: <1253718433.290759.1605043793706.JavaMail.zimbra@nod.at>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Richard Weinberger <richard@nod.at>
Cc: linux-um <linux-um@lists.infradead.org>

T24gMTAvMTEvMjAyMCAyMToyOSwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOgo+IC0tLS0tIFVy
c3Byw7xuZ2xpY2hlIE1haWwgLS0tLS0KPj4gVm9uOiAiYW50b24gaXZhbm92IiA8YW50b24uaXZh
bm92QGNhbWJyaWRnZWdyZXlzLmNvbT4KPj4+IE9uIHdoYXQgd29ya2xvYWQgZGlkIHlvdSBzZWUg
c3VjaCBhIGh1Z2UgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQ/Cj4+IEZpbGUgSU8gfiAxJSBvciB0
aGVyZWFib3V0cywgaXBlcmYgLSAyLTQlLgo+Pgo+Pj4gVGhlIGluLWtlcm5lbCB2YXJpYW50cyBv
ZiBtZW1jcHkgYW5kIHN1Y2ggYXJlIGFscmVhZHkgd2VsbCBvcHRpbWl6ZWQuCj4+IFVNTCBoYXMg
bm8gc3RyaW5nLmggaW4gYXNtIHdoaWNoIG1lYW5zIGl0IGZhbGxzIGJhY2sgdG8KPj4gYXNtLWdl
bmVyaWMvc3RyaW5nLmggd2hpY2ggaW4gdHVybiBwdWxscyBpbiB0aGUgb25lcyBmcm9tIGxpYi9z
dHJpbmcuYwo+Pgo+PiBUaGVzZSBhcmUgbm90IG9wdGltaXplZC4KPiBIbW1tLCBJIHRoaW5rIGl0
IHNob3VsZCB1c2UgdGhlIGhpZ2hseSBvcHRpbWl6ZWQgdmFyaWFudHMgZnJvbSBhcmNoL3g4Ni4K
ClRoYXQgaXMgdGhlIG90aGVyIG9wdGlvbiAtIHRvIGJyaW5nIGluIHN0cmluZzMyLmggYW5kIHN0
cmluZzY0LmggZnJvbSB4ODYuCgo+Cj4gVGhhbmtzLAo+IC8vcmljaGFyZAo+CgotLSAKQW50b24g
Ui4gSXZhbm92CkNhbWJyaWRnZWdyZXlzIExpbWl0ZWQuIFJlZ2lzdGVyZWQgaW4gRW5nbGFuZC4g
Q29tcGFueSBOdW1iZXIgMTAyNzM2NjEKaHR0cHM6Ly93d3cuY2FtYnJpZGdlZ3JleXMuY29tLwoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVt
IG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

