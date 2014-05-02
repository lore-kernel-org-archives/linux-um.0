Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Wg7mc-000070-ME
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2014 07:21:22 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wg7mZ-0003zx-2p
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2014 07:21:22 +0000
Message-ID: <53634765.6060000@nod.at>
Date: Fri, 02 May 2014 09:21:09 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <53613E96.2030006@gmx.de>
	<CAFLxGvyyMMSajwOtS1O6R-_XnJv7dc_61k3Hx9JJB7nmVLNWng@mail.gmail.com>
	<536221F4.6000405@gmx.de> <53623EFE.3040603@nod.at>
	<5362651A.1020504@gmx.de> <5362B53E.5060601@nod.at>
	<5362BDD1.9070105@gmx.de>
In-Reply-To: <5362BDD1.9070105@gmx.de>
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
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>, trinity@vger.kernel.org

QW0gMDEuMDUuMjAxNCAyMzozNCwgc2NocmllYiBUb3JhbGYgRsO2cnN0ZXI6Cj4gT24gMDUvMDEv
MjAxNCAxMDo1NyBQTSwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOgo+PiBUb3JhbGYsCj4+Cj4+
IFllYWgsIHRoaXMgaXMgYmVjYXVzZSB0cmluaXR5IGRlc3Ryb3lzIHRoZSBVTUwgc3R1YiBjb2Rl
Lgo+PiBQbGVhc2UgdGVzdCB0aGUgYXR0YWNoZWQgcGF0Y2gsIGl0IHNob3VsZCBmaXggdGhlIHJv
b3QgY2F1c2Ugb2YgdGhlIHByb2JsZW0uCj4+Cj4+IFRoYW5rcywKPj4gLy9yaWNoYXJkCj4+Cj4g
Cj4gSWYgSSBkbyBqdXN0IGFwcGx5IGZpeDIucGF0Y2ggb250byBsYXRlc3QgZ2l0IHRyZWUgIHYz
LjE1LXJjMy0xMTMtZ2JhNjcyOGYgdGhlbiBJIGRvIGdldCBhZnRlciBhIHdoaWxlIDoKPiAKPiAg
KiBTdGFydGluZyBzc2hkIC4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgWyBvayBdCj4gICogU3RhcnRpbmcgbG9jYWwKPiBuZXQuY29yZS53YXJuaW5ncyA9IDAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgWyBvayBdCj4gS2VybmVsIHBhbmlj
IC0gbm90IHN5bmNpbmc6IGRvX3N5c2NhbGxfc3R1YiA6IFBUUkFDRV9TRVRSRUdTIGZhaWxlZCwg
ZXJybm8gPSAzCj4gCj4gQ1BVOiAwIFBJRDogMTcyOCBDb21tOiB0cmluaXR5LWMwIE5vdCB0YWlu
dGVkIDMuMTUuMC1yYzMtMDAxMTMtZ2JhNjcyOGYtZGlydHkgIzUKPiBTdGFjazoKPiBCVUc6IHNv
ZnQgbG9ja3VwIC0gQ1BVIzAgc3R1Y2sgZm9yIDIycyEgW3RyaW5pdHktYzA6MTcyOF0KPiAKPiBF
SVA6IGM1MDA6Wzw0N2M2Y2YwMD5dIENQVTogMCBOb3QgdGFpbnRlZCBFRkxBR1M6IDQ3NmFmNzAw
Cj4gICAgIE5vdCB0YWludGVkCj4gRUFYOiA0N2NmYzUwMCBFQlg6IDBhMDI0ZDAwIEVDWDogMDg2
Yzc1ZmMgRURYOiAwODBmZmY4OAo+IEVTSTogMDgzOWY0YmMgRURJOiA0N2NmYzUwMCBFQlA6IDA4
MzlmNGJjIERTOiBjNTAwIEVTOiBjZDYyCj4gRVhUNC1mcyAodWJkYSk6IGVycm9yIGNvdW50OiAx
Cj4gRVhUNC1mcyAodWJkYSk6IGluaXRpYWwgZXJyb3IgYXQgMTM5ODk2MjEzNDogZXh0NF9tYl9n
ZW5lcmF0ZV9idWRkeTo3NTYKPiBFWFQ0LWZzICh1YmRhKTogbGFzdCBlcnJvciBhdCAxMzk4OTYy
MTM0OiBleHQ0X21iX2dlbmVyYXRlX2J1ZGR5Ojc1NgoKSG1tLCB0aGVyZSBpcyBhbm90aGVyIGJ1
ZyBoaWRkZW4uCi9tZSBsb29rcy4KCj4gCj4gd2hpY2ggaXMgYSBiaWcgaW1wcm92ZW1lbnQgYmVj
YXVzZSBiZWZvcmUgaXQgY3Jhc2hlcyBpbW1lZGlhdGVseSBhZnRlciBmZXcgc2Vjb25kcy4KPiAK
PiBBZnRlciBhcHBseWluZyBib3RoIGZpeGVzIHRoZSB0ZXN0IGNhc2UgcnVucyB3L28gYSBjcmFz
aCB0aWxsIG5vdy4KCkl0IHNob3VsZCB3b3JrIHdpdGhvdXQgcmVtb3ZpbmcgdGhlIHBhbmljcygp
LgpPdGhlcndpc2UgYW4gYXR0YWNrZXIgY291bGQgZG8gbmFzdHkgdGhpbmdzLgoKVGhhbmtzLAov
L3JpY2hhcmQKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoiQWNjZWxlcmF0ZSBEZXYgQ3ljbGVzIHdp
dGggQXV0b21hdGVkIENyb3NzLUJyb3dzZXIgVGVzdGluZyAtIEZvciBGUkVFCkluc3RhbnRseSBy
dW4geW91ciBTZWxlbml1bSB0ZXN0cyBhY3Jvc3MgMzAwKyBicm93c2VyL09TIGNvbWJvcy4gIEdl
dCAKdW5wYXJhbGxlbGVkIHNjYWxhYmlsaXR5IGZyb20gdGhlIGJlc3QgU2VsZW5pdW0gdGVzdGlu
ZyBwbGF0Zm9ybSBhdmFpbGFibGUuClNpbXBsZSB0byB1c2UuIE5vdGhpbmcgdG8gaW5zdGFsbC4g
R2V0IHN0YXJ0ZWQgbm93IGZvciBmcmVlLiIKaHR0cDovL3Auc2YubmV0L3NmdS9TYXVjZUxhYnMK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVXNlci1tb2Rl
LWxpbnV4LWRldmVsIG1haWxpbmcgbGlzdApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlzdHMuc291
cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZv
L3VzZXItbW9kZS1saW51eC1kZXZlbAo=

