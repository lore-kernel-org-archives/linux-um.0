Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <f.fainelli@gmail.com>) id 1UNjFt-0000S5-Gn
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Apr 2013 12:27:01 +0000
Received: from mail-ea0-f170.google.com ([209.85.215.170])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UNjFq-00047a-Tn
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Apr 2013 12:27:01 +0000
Received: by mail-ea0-f170.google.com with SMTP id a15so974003eae.15
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 04 Apr 2013 05:26:52 -0700 (PDT)
Message-ID: <515D7179.1070002@openwrt.org>
Date: Thu, 04 Apr 2013 14:26:33 +0200
From: Florian Fainelli <florian@openwrt.org>
MIME-Version: 1.0
References: <5783794.b5gPVMPLlO@bender>
	<2521.1363798017@warthog.procyon.org.uk>
	<5149F353.1080505@openwrt.org>
In-Reply-To: <5149F353.1080505@openwrt.org>
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
Subject: Re: [uml-devel] [PATCH] UM: fix make headers_install after UAPI
	header installation
To: David Howells <dhowells@redhat.com>
Cc: richard@nod.at, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

TGUgMDMvMjAvMTMgMTg6MzUsIEZsb3JpYW4gRmFpbmVsbGkgYSDDqWNyaXQgOgo+IExlIDAzLzIw
LzEzIDE3OjQ2LCBEYXZpZCBIb3dlbGxzIGEgw6ljcml0IDoKPj4gRmxvcmlhbiBGYWluZWxsaSA8
ZmxvcmlhbkBvcGVud3J0Lm9yZz4gd3JvdGU6Cj4+Cj4+PiBDb21taXQgMTBiNjM5NTYgKFVBUEk6
IFBsdW1iIHRoZSBVQVBJIEtidWlsZHMgaW50byB0aGUgdXNlcgo+Pj4gaGVhZGVyIGluc3RhbGxh
dGlvbiBhbmQgY2hlY2tpbmcpIGJyZWFrcyBVTUwgbWFrZSBoZWFkZXJzX2luc3RhbGwgd2l0aAo+
Pj4gdGhlIGZvbGxvd2luZzoKPj4KPj4gVW1tbS4uLiAgV2h5IHdvdWxkIHlvdSBkbyB0aGF0PyAg
U3VyZWx5IFVNTCBkb2Vzbid0IGhhdmUgaXRzIG93bgo+PiB1c2Vyc3BhY2UsCj4+IGJ1dCByYXRo
ZXIgYm9ycm93cyBmcm9tIHRoZSBob3N0IGFyY2g/Cj4KPiBXZWxsLCBmaXJzdCBiZWNhdXNlIGl0
IHVzZWQgdG8gd29yayBhbmQgc2Vjb25kIGJlY2F1c2UgSSBidWlsZAo+IHRvb2xjaGFpbnMgd2hp
Y2ggaGF2ZSBsaXR0bGUgdG8gbm90aGluZyBpbiBjb21tb24gd2l0aCB0aGUgaG9zdCBpdCBpcwo+
IHJ1bm5pbmcgb24gKGRpZmZlcmVudCBsaWJjIGV0Yy4uLikuIEkgY2FuIGNlcnRhaW5seSBhZGQg
YW4gZXhjZXB0aW9uIHRvCj4gdGhlIGJ1aWxkIHN5c3RlbSB0ZWxsaW5nIGl0IG5vdCB0byB0cnkg
dG8gbWFrZSBoZWFkZXJzX2luc3RhbGwgZm9yIFVNTC4KCkRhdmlkLCBhbSBJIGNvbXBsZXRlbHkg
aXJyZWxldmFudCBoZXJlIG9yIGRvIHlvdSB0aGluayB0aGlzIHNob3VsZCAKaW5kZWVkIG5lZWQg
Zml4aW5nPwoKVGhhbmtzIQotLQpGbG9yaWFuCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KTWluaW1p
emUgbmV0d29yayBkb3dudGltZSBhbmQgbWF4aW1pemUgdGVhbSBlZmZlY3RpdmVuZXNzLgpSZWR1
Y2UgbmV0d29yayBtYW5hZ2VtZW50IGFuZCBzZWN1cml0eSBjb3N0cy5MZWFybiBob3cgdG8gaGly
ZSAKdGhlIG1vc3QgdGFsZW50ZWQgQ2lzY28gQ2VydGlmaWVkIHByb2Zlc3Npb25hbHMuIFZpc2l0
IHRoZSAKRW1wbG95ZXIgUmVzb3VyY2VzIFBvcnRhbApodHRwOi8vd3d3LmNpc2NvLmNvbS93ZWIv
bGVhcm5pbmcvZW1wbG95ZXJfcmVzb3VyY2VzL2luZGV4Lmh0bWwKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVsIG1haWxp
bmcgbGlzdApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBz
Oi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1saW51eC1k
ZXZlbAo=

