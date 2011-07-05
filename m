Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Qe1vo-00022l-Nt
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Jul 2011 09:28:36 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qe1vn-0006i9-Bs
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Jul 2011 09:28:36 +0000
From: Richard Weinberger <richard@nod.at>
Date: Tue, 5 Jul 2011 11:28:24 +0200
References: <1309821341.4527.5.camel@vitaliy-Vostro-1400>
In-Reply-To: <1309821341.4527.5.camel@vitaliy-Vostro-1400>
MIME-Version: 1.0
Message-Id: <201107051128.25262.richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 1/4] uml: cow_user.c warning corrections
To: vitalivanov@gmail.com
Cc: Jeff Dike <jdike@addtoit.com>, Linus Torvalds <torvalds@linux-foundation.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, user-mode-linux-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>

QW0gRGllbnN0YWcgMDUgSnVsaSAyMDExLCAwMToxNTo0MSBzY2hyaWViIFZpdGFsaXkgSXZhbm92
Ogo+IEZyb20gNjIwMWQzZTg2MmZjYTg2NzBiMjA2MzM4ZGM5MDMwM2VhMGFjYzc3ZCBNb24gU2Vw
IDE3IDAwOjAwOjAwIDIwMDEKPiBGcm9tOiBWaXRhbGl5IEl2YW5vdiA8dml0YWxpdmFub3ZAZ21h
aWwuY29tPgo+IERhdGU6IFR1ZSwgNSBKdWwgMjAxMSAwMTo1Nzo1MSArMDMwMAo+IFN1YmplY3Q6
IFtQQVRDSCAxLzRdIHVtbDogY293X3VzZXIuYyB3YXJuaW5nIGNvcnJlY3Rpb25zCj4gTUlNRS1W
ZXJzaW9uOiAxLjAKPiBDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKPiBD
b250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0Cj4gCj4gYXJjaC91bS9kcml2ZXJzL2Nvd191
c2VyLmM6IEluIGZ1bmN0aW9uIOKAmGFic29sdXRpemXigJk6Cj4gYXJjaC91bS9kcml2ZXJzL2Nv
d191c2VyLmM6MTg5Ojc6IHdhcm5pbmc6IGlnbm9yaW5nIHJldHVybiB2YWx1ZSBvZgo+IOKAmGNo
ZGly4oCZLCBkZWNsYXJlZCB3aXRoIGF0dHJpYnV0ZSB3YXJuX3VudXNlZF9yZXN1bHQKCldoYXQg
Y29tcGlsZXIgZmxhZ3MgYXJlIHlvdSB1c2luZz8KVXNpbmcgdGhlIGRlZmF1bHQgc2V0dGluZ3Mg
dGhpcyB3YXJuaW5nIGRvZXMgbm90IHNob3cgdXAuCk1vc3Qgb2YgdGhlICJpZ25vcmluZyByZXR1
cm4gdmFsdWUiIGFyZSB0b3RhbGx5IHVzZWxlc3MuCgo+IFNpZ25lZC1vZmYtYnk6IFZpdGFsaXkg
SXZhbm92IDx2aXRhbGl2YW5vdkBnbWFpbC5jb20+Cj4gLS0tCj4gIGFyY2gvdW0vZHJpdmVycy9j
b3dfdXNlci5jIHwgICAgNiArKysrKy0KPiAgMSBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvdW0vZHJpdmVycy9jb3df
dXNlci5jIGIvYXJjaC91bS9kcml2ZXJzL2Nvd191c2VyLmMKPiBpbmRleCA5M2YyMjdhLi45Y2Ji
NDI2IDEwMDY0NAo+IC0tLSBhL2FyY2gvdW0vZHJpdmVycy9jb3dfdXNlci5jCj4gKysrIGIvYXJj
aC91bS9kcml2ZXJzL2Nvd191c2VyLmMKPiBAQCAtMTg2LDcgKzE4NiwxMSBAQCBzdGF0aWMgaW50
IGFic29sdXRpemUoY2hhciAqdG8sIGludCBzaXplLCBjaGFyICpmcm9tKQo+ICAJCXN0cmNhdCh0
bywgIi8iKTsKPiAgCQlzdHJjYXQodG8sIGZyb20pOwo+ICAJfQo+IC0JY2hkaXIoc2F2ZV9jd2Qp
Owo+ICsJaWYgKGNoZGlyKHNhdmVfY3dkKSkgewo+ICsJCWNvd19wcmludGYoImFic29sdXRpemUg
OiBDYW4ndCBjZCB0byAnJXMnIC0gIgo+ICsJCQkgICAiZXJybm8gPSAlZFxuIiwgc2F2ZV9jd2Qs
IGVycm5vKTsKPiArCQlyZXR1cm4gLTE7Cj4gKwl9CgpJIGRvbid0IHRoaW5rIHRoYXQgdGhpcyBj
aGVjayBpcyBuZWVkZWQgbm9yIGNoZGlyKCkgdG8gc2F2ZV9jd2QgY2FuIGZhaWwuCkJlY2F1c2Ug
d2Ugb2J0YWluIGl0IGJ5IGNhbGxpbmcgZ2V0Y3dkKCkgYW5kIG5ldmVyIGNoYW5nZSBpdC4uLgoK
VGhhbmtzLAovL3JpY2hhcmQKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpBbGwgb2YgdGhlIGRhdGEg
Z2VuZXJhdGVkIGluIHlvdXIgSVQgaW5mcmFzdHJ1Y3R1cmUgaXMgc2VyaW91c2x5IHZhbHVhYmxl
LgpXaHk/IEl0IGNvbnRhaW5zIGEgZGVmaW5pdGl2ZSByZWNvcmQgb2YgYXBwbGljYXRpb24gcGVy
Zm9ybWFuY2UsIHNlY3VyaXR5IAp0aHJlYXRzLCBmcmF1ZHVsZW50IGFjdGl2aXR5LCBhbmQgbW9y
ZS4gU3BsdW5rIHRha2VzIHRoaXMgZGF0YSBhbmQgbWFrZXMgCnNlbnNlIG9mIGl0LiBJVCBzZW5z
ZS4gQW5kIGNvbW1vbiBzZW5zZS4KaHR0cDovL3Auc2YubmV0L3NmdS9zcGx1bmstZDJkLWMyCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClVzZXItbW9kZS1s
aW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4LWRldmVsQGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby91
c2VyLW1vZGUtbGludXgtZGV2ZWwK

