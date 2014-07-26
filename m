Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1XB9P4-0008QT-8C
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Jul 2014 21:21:18 +0000
Received: from mout.gmx.net ([212.227.15.19])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XB9P3-0002dW-2I
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Jul 2014 21:21:18 +0000
Message-ID: <53D41BC5.1090500@gmx.de>
Date: Sat, 26 Jul 2014 23:21:09 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <53613E96.2030006@gmx.de>
	<CAFLxGvyyMMSajwOtS1O6R-_XnJv7dc_61k3Hx9JJB7nmVLNWng@mail.gmail.com>
	<536221F4.6000405@gmx.de> <53623EFE.3040603@nod.at>
	<53D40919.8040803@gmx.de> <53D40A88.7030902@nod.at>
In-Reply-To: <53D40A88.7030902@nod.at>
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
Subject: Re: [uml-devel] trinity commit 23dc478aba breaks syscall "mremap"
 at a 32 bit user mode linux
To: Richard Weinberger <richard@nod.at>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

T24gMDcvMjYvMjAxNCAxMDowNyBQTSwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOgo+IEFtIDI2
LjA3LjIwMTQgMjI6MDEsIHNjaHJpZWIgVG9yYWxmIEbDtnJzdGVyOgo+PiBPbiAwNS8wMS8yMDE0
IDAyOjMzIFBNLCBSaWNoYXJkIFdlaW5iZXJnZXIgd3JvdGU6Cj4+PiBCVFc6IElmIHlvdSBoaXQg
IkJVRzogZmFpbHVyZSBhdCBtbS9maWxlbWFwLmM6MjAyL19fZGVsZXRlX2Zyb21fcGFnZV9jYWNo
ZSgpISIsCj4+PiB0aGlzIGlzIGEga25vd24gaXNzdWUgaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIw
MTQvNC8xNS81NzcKPj4KPj4gU2luY2UgSSBkbyBleGNsdWRlIHRoZSAibWFkdmlzZSIgc3lzY2Fs
bCBmcm9tIGZ1enogdGVzdGluZyBJIGRvIG5vIGxvbmdlciBydW4gaW50byB0aGlzIGlzc3VlCj4+
IChhdCBsZWFzdCB3aXRoIHJlY2VudCBnaXQgdHJlZSkuCj4+Cj4+IEJ1dCB0aGVyZSdzIHN0aWxs
IHRoaXMgdW5zb2x2ZWQgaXNzdWUgaW4gdGhlIGtlcm5lbCwgb3IgPwo+IAo+IEFGQUlLIHRoZSBy
ZXNvbHV0aW9uIGlzIG5lYXIuCj4gUGxlYXNlIHNlZSB0aHJlYWQgIlBST0JMRU06IHJlcGVhdGVk
IHJlbWFwX2ZpbGVfcGFnZXMgb24gdG1wZnMgdHJpZ2dlcnMgYnVnIG9uIHByb2Nlc3MgZXhpdCIu
Cj4gSWYgeW91IHN0aWxsIGZhY2UgdGhlIGlzc3VlIGl0IG1heSBVTUwgc3BlY2lmaWMuCj4gCj4g
VGhhbmtzLAo+IC8vcmljaGFyZAo+IAp5ZXAsIGMxMTg2NzhiYzcgc2VlbXMgdG8gc29sdmUgaXQg
LSBnb29kIG5ld3MsIG5vdyBJIGNhbiBjb250aW51ZSB3aXRoIGEgbW9yZSB1bmxpbWl0ZWQgZnV6
eiB0ZXN0aW5nIC4uLgp0aHgKCi0tIApUb3JhbGYKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KV2Fu
dCBmYXN0IGFuZCBlYXN5IGFjY2VzcyB0byBhbGwgdGhlIGNvZGUgaW4geW91ciBlbnRlcnByaXNl
PyBJbmRleCBhbmQKc2VhcmNoIHVwIHRvIDIwMCwwMDAgbGluZXMgb2YgY29kZSB3aXRoIGEgZnJl
ZSBjb3B5IG9mIEJsYWNrIER1Y2sKQ29kZSBTaWdodCAtIHRoZSBzYW1lIHNvZnR3YXJlIHRoYXQg
cG93ZXJzIHRoZSB3b3JsZCdzIGxhcmdlc3QgY29kZQpzZWFyY2ggb24gT2hsb2gsIHRoZSBCbGFj
ayBEdWNrIE9wZW4gSHViISBUcnkgaXQgbm93LgpodHRwOi8vcC5zZi5uZXQvc2Z1L2JkcwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGlu
dXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNl
ci1tb2RlLWxpbnV4LWRldmVsCg==

