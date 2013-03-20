Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <f.fainelli@gmail.com>) id 1UIMv9-0002VV-OA
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Mar 2013 17:35:27 +0000
Received: from mail-ee0-f50.google.com ([74.125.83.50])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UIMv8-00028R-Mc
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Mar 2013 17:35:27 +0000
Received: by mail-ee0-f50.google.com with SMTP id e51so1277464eek.9
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 20 Mar 2013 10:35:20 -0700 (PDT)
Message-ID: <5149F353.1080505@openwrt.org>
Date: Wed, 20 Mar 2013 18:35:15 +0100
From: Florian Fainelli <florian@openwrt.org>
MIME-Version: 1.0
References: <5783794.b5gPVMPLlO@bender>
	<2521.1363798017@warthog.procyon.org.uk>
In-Reply-To: <2521.1363798017@warthog.procyon.org.uk>
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

TGUgMDMvMjAvMTMgMTc6NDYsIERhdmlkIEhvd2VsbHMgYSDDqWNyaXQgOgo+IEZsb3JpYW4gRmFp
bmVsbGkgPGZsb3JpYW5Ab3BlbndydC5vcmc+IHdyb3RlOgo+Cj4+IENvbW1pdCAxMGI2Mzk1NiAo
VUFQSTogUGx1bWIgdGhlIFVBUEkgS2J1aWxkcyBpbnRvIHRoZSB1c2VyCj4+IGhlYWRlciBpbnN0
YWxsYXRpb24gYW5kIGNoZWNraW5nKSBicmVha3MgVU1MIG1ha2UgaGVhZGVyc19pbnN0YWxsIHdp
dGgKPj4gdGhlIGZvbGxvd2luZzoKPgo+IFVtbW0uLi4gIFdoeSB3b3VsZCB5b3UgZG8gdGhhdD8g
IFN1cmVseSBVTUwgZG9lc24ndCBoYXZlIGl0cyBvd24gdXNlcnNwYWNlLAo+IGJ1dCByYXRoZXIg
Ym9ycm93cyBmcm9tIHRoZSBob3N0IGFyY2g/CgpXZWxsLCBmaXJzdCBiZWNhdXNlIGl0IHVzZWQg
dG8gd29yayBhbmQgc2Vjb25kIGJlY2F1c2UgSSBidWlsZCAKdG9vbGNoYWlucyB3aGljaCBoYXZl
IGxpdHRsZSB0byBub3RoaW5nIGluIGNvbW1vbiB3aXRoIHRoZSBob3N0IGl0IGlzIApydW5uaW5n
IG9uIChkaWZmZXJlbnQgbGliYyBldGMuLi4pLiBJIGNhbiBjZXJ0YWlubHkgYWRkIGFuIGV4Y2Vw
dGlvbiB0byAKdGhlIGJ1aWxkIHN5c3RlbSB0ZWxsaW5nIGl0IG5vdCB0byB0cnkgdG8gbWFrZSBo
ZWFkZXJzX2luc3RhbGwgZm9yIFVNTC4KLS0KRmxvcmlhbgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CkV2ZXJ5b25lIGhhdGVzIHNsb3cgd2Vic2l0ZXMuIFNvIGRvIHdlLgpNYWtlIHlvdXIgd2ViIGFw
cHMgZmFzdGVyIHdpdGggQXBwRHluYW1pY3MKRG93bmxvYWQgQXBwRHluYW1pY3MgTGl0ZSBmb3Ig
ZnJlZSB0b2RheToKaHR0cDovL3Auc2YubmV0L3NmdS9hcHBkeW5fZDJkX21hcgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2
ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5u
ZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2Rl
LWxpbnV4LWRldmVsCg==

