Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1XB8Fv-0001im-Oy
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Jul 2014 20:07:47 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XB8Fu-0000Z3-28
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Jul 2014 20:07:47 +0000
Message-ID: <53D40A88.7030902@nod.at>
Date: Sat, 26 Jul 2014 22:07:36 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <53613E96.2030006@gmx.de>
	<CAFLxGvyyMMSajwOtS1O6R-_XnJv7dc_61k3Hx9JJB7nmVLNWng@mail.gmail.com>
	<536221F4.6000405@gmx.de> <53623EFE.3040603@nod.at>
	<53D40919.8040803@gmx.de>
In-Reply-To: <53D40919.8040803@gmx.de>
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
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

QW0gMjYuMDcuMjAxNCAyMjowMSwgc2NocmllYiBUb3JhbGYgRsO2cnN0ZXI6Cj4gT24gMDUvMDEv
MjAxNCAwMjozMyBQTSwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOgo+PiBCVFc6IElmIHlvdSBo
aXQgIkJVRzogZmFpbHVyZSBhdCBtbS9maWxlbWFwLmM6MjAyL19fZGVsZXRlX2Zyb21fcGFnZV9j
YWNoZSgpISIsCj4+IHRoaXMgaXMgYSBrbm93biBpc3N1ZSBodHRwczovL2xrbWwub3JnL2xrbWwv
MjAxNC80LzE1LzU3Nwo+IAo+IFNpbmNlIEkgZG8gZXhjbHVkZSB0aGUgIm1hZHZpc2UiIHN5c2Nh
bGwgZnJvbSBmdXp6IHRlc3RpbmcgSSBkbyBubyBsb25nZXIgcnVuIGludG8gdGhpcyBpc3N1ZQo+
IChhdCBsZWFzdCB3aXRoIHJlY2VudCBnaXQgdHJlZSkuCj4gCj4gQnV0IHRoZXJlJ3Mgc3RpbGwg
dGhpcyB1bnNvbHZlZCBpc3N1ZSBpbiB0aGUga2VybmVsLCBvciA/CgpBRkFJSyB0aGUgcmVzb2x1
dGlvbiBpcyBuZWFyLgpQbGVhc2Ugc2VlIHRocmVhZCAiUFJPQkxFTTogcmVwZWF0ZWQgcmVtYXBf
ZmlsZV9wYWdlcyBvbiB0bXBmcyB0cmlnZ2VycyBidWcgb24gcHJvY2VzcyBleGl0Ii4KSWYgeW91
IHN0aWxsIGZhY2UgdGhlIGlzc3VlIGl0IG1heSBVTUwgc3BlY2lmaWMuCgpUaGFua3MsCi8vcmlj
aGFyZAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCldhbnQgZmFzdCBhbmQgZWFzeSBhY2Nlc3MgdG8g
YWxsIHRoZSBjb2RlIGluIHlvdXIgZW50ZXJwcmlzZT8gSW5kZXggYW5kCnNlYXJjaCB1cCB0byAy
MDAsMDAwIGxpbmVzIG9mIGNvZGUgd2l0aCBhIGZyZWUgY29weSBvZiBCbGFjayBEdWNrCkNvZGUg
U2lnaHQgLSB0aGUgc2FtZSBzb2Z0d2FyZSB0aGF0IHBvd2VycyB0aGUgd29ybGQncyBsYXJnZXN0
IGNvZGUKc2VhcmNoIG9uIE9obG9oLCB0aGUgQmxhY2sgRHVjayBPcGVuIEh1YiEgVHJ5IGl0IG5v
dy4KaHR0cDovL3Auc2YubmV0L3NmdS9iZHMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVsIG1haWxpbmcgbGlzdApVc2Vy
LW1vZGUtbGludXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291
cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1saW51eC1kZXZlbAo=

