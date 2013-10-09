Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stian@nixia.no>) id 1VTrRP-00077C-4X
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Oct 2013 10:56:31 +0000
Received: from ramslauken.nlc.no ([195.159.66.51])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VTrRN-0004al-GZ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Oct 2013 10:56:31 +0000
Received: from mail.nlc.no (ramslauken.nlc.no [195.159.66.51])
	(Authenticated sender: stian@nixia.no)
	by ramslauken.nlc.no (Postfix) with ESMTPA id A04D21CC755
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed,  9 Oct 2013 12:35:31 +0200 (CEST)
MIME-Version: 1.0
Date: Wed, 09 Oct 2013 12:35:31 +0200
From: stian@nixia.no
In-Reply-To: <52546386.3050608@gmx.de>
References: "\"<524C6643.2040209@gmx.de>	<CAFLxGvwiH7L4oAW8tw6FyeGczg+rKjUDCdkLKdegy9yX==2cMA@mail.gmail.com>	<524DBD5D.1040203@gmx.de>	<524DBFBB.1050002@nod.at>	<524DC278.3020106@gmx.de>	<524DC394.6030406@nod.at>	<524DC675.4020201@gmx.de>	<524E57BA.805@nod.at>	<52517109.90605@gmx.de>"
	<CAMuHMdXrU0e_6AxvdboMkDs+N+tSWD+b8ou92j28c0vsq2eQQA@mail.gmail.com>"
	<5251C334.3010604@gmx.de>
	<CAMuHMdUo8dSd4s3089ZDEc485wL1sFxBKLeaExJuqNiQY+S-Lw@mail.gmail.com>
	<52546386.3050608@gmx.de>
Message-ID: <5c4228ccd2c402864ab4e91d9ec24bf2@nixia.no>
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
Subject: Re: [uml-devel] BUG: soft lockup for a user mode linux image
To: user-mode-linux-devel@lists.sourceforge.net

RGVuIDIwMTMtMTAtMDggMjE6NTYsIHNrcmV2IFRvcmFsZiBGw7Zyc3RlcjoKPiBXZWxsLCB0aGUg
cXVpY2smZGlydHkgaGFjayBiZWxvdyBhdCBsZWFzdCB3b3JrcyBmb3IgdGhlIG1vbWVudCB0bwo+
IG92ZXJjb21lIHRoZSBzb2Z0IGxvb2t1cCBhbmQgdGhlIGhhbmcvdW5yZXNwb25zaXZlbmVzcyBv
ZiB0aGUgMzIgYml0Cj4gdXNlciBtb2RlIGxpbnV4IGd1ZXN0IDoKPgo+Cj4gZGlmZiAtLWdpdCBh
L21tL3BhZ2Utd3JpdGViYWNrLmMgYi9tbS9wYWdlLXdyaXRlYmFjay5jCj4gaW5kZXggZjUyMzZm
OC4uN2U5NDgzYyAxMDA2NDQKPiAtLS0gYS9tbS9wYWdlLXdyaXRlYmFjay5jCj4gKysrIGIvbW0v
cGFnZS13cml0ZWJhY2suYwo+IEBAIC0xNTAzLDYgKzE1MDMsOCBAQCBzdGF0aWMgdm9pZCBiYWxh
bmNlX2RpcnR5X3BhZ2VzKHN0cnVjdAo+IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsCj4gICAgICAg
ICAgICAgICAgIH0KPgo+ICBwYXVzZToKPiArICAgICAgICAgICAgICAgaWYgKHBhdXNlIDwgMCkK
PiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKCmNhbiB3ZSBjb21iaW5lIGluIHRoZSBk
ZWJ1ZyBwcmludGsoKSBtZW50aW9uZWQgYmVsb3csIHRoYXQgcHJpbnRzIG91dCAKcGFnZXNfZGly
dGllZCBhbmQgdGFza19yYXRlbGltaXQ6Cgo+PiBpZiAocGF1c2UgPCAwKSB7Cj4+ICAgICAgICAg
cHJpbnRrKCJwYWdlc19kaXJ0aWVkID0gJWx1XG4iLCBwYWdlc19kaXJ0aWVkKTsKPj4gICAgICAg
ICBwcmludGsoInRhc2tfcmF0ZWxpbWl0ID0gJWx1XG4iLCB0YXNrX3JhdGVsaW1pdCk7Cj4+ICAg
ICAgICAgcHJpbnRrKCJwYXVzZSA9ICVsZFxuIiwgcGF1c2UpOwogICAgICAgICAgICBicmVhazsK
Pj4gfQoKSSBoYXZlIG5vdCByZWFkIHRoZSBzb3VyY2UsIHNvIHdoYXQgaXMgdGhlIGRlZmluaXRp
b24gb2YgSFo/IEFyZSAKcGFnZXNfZGlydGllZCBhbmQgdGFza19yYXRlbGltaXQgYXRvbWljYWxs
eSBzYWZlIHVuZGVyIFVNTCBoZXJlLCBhbmQgYXJlIAp3aGF0IGRhdGF0eXBlIGFyZSB0aGV5PyAo
dW5zaWduZWQgbG9uZyk/IFRoZSBkZWZpbmluaW9uIG9mIEhaIHdpbGwgYWxsIAppbiBhbGwgZGVj
aWRlIHdoYXQga2luZCBvZiBtdWx0aXBsaWNhdGlvbiBhbmQgZGl2aXNpb24gd2UgYWN0dWFsbHkg
CnBlcmZvcm0gaGVyZTsgc28gbGV0IHVzIGhvcGUgaXQgaXMgbm90IHNvbWV0aGluZyBsaWtlIChz
aWduZWQgY2hhcikKCj4+Pj4+ICAgICAgICAgICAgICAgICBCVUdfT04ocGFnZXNfZGlydGllZCA8
IDApOwo+Pj4+PiAgICAgICAgICAgICAgICAgQlVHX09OKHRhc2tfcmF0ZWxpbWl0IDwgMCk7CgpU
aGVzZSB3aWxsIG5ldmVyIGhpdCBpZiBwYWdlc19kaXJ0aWVkIGFuZCB0YXNrX3JhdGVsaW1pdCBh
cmUgdW5zaWduZWQuCgoKU3RpYW4gU2tqZWxzdGFkCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KT2N0
b2JlciBXZWJpbmFyczogQ29kZSBmb3IgUGVyZm9ybWFuY2UKRnJlZSBJbnRlbCB3ZWJpbmFycyBj
YW4gaGVscCB5b3UgYWNjZWxlcmF0ZSBhcHBsaWNhdGlvbiBwZXJmb3JtYW5jZS4KRXhwbG9yZSB0
aXBzIGZvciBNUEksIE9wZW5NUCwgYWR2YW5jZWQgcHJvZmlsaW5nLCBhbmQgbW9yZS4gR2V0IHRo
ZSBtb3N0IGZyb20gCnRoZSBsYXRlc3QgSW50ZWwgcHJvY2Vzc29ycyBhbmQgY29wcm9jZXNzb3Jz
LiBTZWUgYWJzdHJhY3RzIGFuZCByZWdpc3RlciA+Cmh0dHA6Ly9wdWJhZHMuZy5kb3VibGVjbGlj
ay5uZXQvZ2FtcGFkL2Nsaz9pZD02MDEzNDA3MSZpdT0vNDE0MC9vc3RnLmNsa3RyawpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgt
ZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1t
b2RlLWxpbnV4LWRldmVsCg==

