Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kca1b-0005Mn-Q7
 for linux-um@lists.infradead.org; Tue, 10 Nov 2020 20:13:56 +0000
Date: Tue, 10 Nov 2020 21:13:45 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1098264641.290574.1605039225057.JavaMail.zimbra@nod.at>
In-Reply-To: <20201110163034.22963-1-anton.ivanov@cambridgegreys.com>
References: <20201110163034.22963-1-anton.ivanov@cambridgegreys.com>
Subject: Re: [PATCH] um: allow using glibc string functions instead of generics
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
To: anton ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um <linux-um@lists.infradead.org>

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogImFudG9uIGl2YW5vdiIgPGFu
dG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+Cj4gQW46ICJsaW51eC11bSIgPGxpbnV4LXVt
QGxpc3RzLmluZnJhZGVhZC5vcmc+Cj4gQ0M6ICJyaWNoYXJkIiA8cmljaGFyZEBub2QuYXQ+LCAi
YW50b24gaXZhbm92IiA8YW50b24uaXZhbm92QGNhbWJyaWRnZWdyZXlzLmNvbT4KPiBHZXNlbmRl
dDogRGllbnN0YWcsIDEwLiBOb3ZlbWJlciAyMDIwIDE3OjMwOjM0Cj4gQmV0cmVmZjogW1BBVENI
XSB1bTogYWxsb3cgdXNpbmcgZ2xpYmMgc3RyaW5nIGZ1bmN0aW9ucyBpbnN0ZWFkIG9mIGdlbmVy
aWNzCgo+IEZyb206IEFudG9uIEl2YW5vdiA8YW50b24uaXZhbm92QGNhbWJyaWRnZWdyZXlzLmNv
bT4KPiAKPiBVTUwga2VybmVsIHJ1bnMgYXMgYSBub3JtYWwgdXNlcnNwYWNlIHByb2Nlc3MgYW5k
IGNhbiB1c2UgdGhlCj4gb3B0aW1pemVkIGdsaWJjIHN0cmluZ3MgZnVuY3Rpb25zIGxpa2Ugc3Ry
Y3B5LCBtZW1jcHksIGV0Yy4KPiAKPiBUaGUgc3VwcG9ydCBpcyBvcHRpb25hbCBhbmQgaXMgdHVy
bmVkIG9uL29mIHVzaW5nIGEgY29uZmlnCj4gb3B0aW9uLgo+IAo+IFVzaW5nIGdsaWJjIGZ1bmN0
aW9ucyByZXN1bHRzIGluIGEgc2xpZ2h0bHkgc21hbGxlciBleGVjdXRhYmxlCj4gd2hlbiBsaW5r
ZWQgZHluYW1pY2FsbHkgYXMgd2VsbCBhcyBhbnl0aGluZyBiZXR3ZWVuIDElIGFuZCA1JQo+IHBl
cmZvcm1hbmNlIGltcHJvdmVtZW50cy4KCk9uIHdoYXQgd29ya2xvYWQgZGlkIHlvdSBzZWUgc3Vj
aCBhIGh1Z2UgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQ/ClRoZSBpbi1rZXJuZWwgdmFyaWFudHMg
b2YgbWVtY3B5IGFuZCBzdWNoIGFyZSBhbHJlYWR5IHdlbGwgb3B0aW1pemVkLgpTbyBJJ20gYSBs
aXR0bGUgc3VycHJpc2VkLgoKVGhhbmtzLAovL3JpY2hhcmQKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11
bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtdW0K

