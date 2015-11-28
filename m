Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1a2neI-0004UJ-Uh
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Nov 2015 22:07:18 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1a2neH-0001Ng-TI
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Nov 2015 22:07:18 +0000
References: <1448746350-19998-1-git-send-email-mic@digikod.net>
	<1448746350-19998-3-git-send-email-mic@digikod.net>
From: Richard Weinberger <richard@nod.at>
Message-ID: <565A258D.4040206@nod.at>
Date: Sat, 28 Nov 2015 23:07:09 +0100
MIME-Version: 1.0
In-Reply-To: <1448746350-19998-3-git-send-email-mic@digikod.net>
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
Subject: Re: [uml-devel] [PATCH 2/2] um: Use race-free temporary file
	creation
To: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>, linux-kernel@vger.kernel.org
Cc: user-mode-linux-user@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

QW0gMjguMTEuMjAxNSB1bSAyMjozMiBzY2hyaWViIE1pY2thw6tsIFNhbGHDvG46Cj4gT3BlbiB0
aGUgbWVtb3J5IG1hcHBlZCBmaWxlIHdpdGggdGhlIE9fVE1QRklMRSBmbGFnIHdoZW4gYXZhaWxh
YmxlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IE1pY2thw6tsIFNhbGHDvG4gPG1pY0BkaWdpa29kLm5l
dD4KPiAtLS0KPiAgYXJjaC91bS9vcy1MaW51eC9tZW0uYyB8IDEyICsrKysrKysrKysrKwo+ICAx
IGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL3Vt
L29zLUxpbnV4L21lbS5jIGIvYXJjaC91bS9vcy1MaW51eC9tZW0uYwo+IGluZGV4IDc5OGFlYjQu
LmZlNTJlMmQgMTAwNjQ0Cj4gLS0tIGEvYXJjaC91bS9vcy1MaW51eC9tZW0uYwo+ICsrKyBiL2Fy
Y2gvdW0vb3MtTGludXgvbWVtLmMKPiBAQCAtMTA2LDYgKzEwNiwxOCBAQCBzdGF0aWMgaW50IF9f
aW5pdCBtYWtlX3RlbXBmaWxlKGNvbnN0IGNoYXIgKnRlbXBsYXRlKQo+ICAJCX0KPiAgCX0KPiAg
Cj4gKyNpZmRlZiBPX1RNUEZJTEUKPiArCWZkID0gb3Blbih0ZW1wZGlyLCBPX0NMT0VYRUMgfCBP
X1JEV1IgfCBPX0VYQ0wgfCBPX1RNUEZJTEUsIDA3MDApOwo+ICsJLyoKPiArCSAqIElmIHRoZSBy
dW5uaW5nIHN5c3RlbSBkb2VzIG5vdCBzdXBwb3J0IE9fVE1QRklMRSBmbGFnIHRoZW4gcmV0cnkK
PiArCSAqIHdpdGhvdXQgaXQuCj4gKwkgKi8KPiArCWlmIChmZCAhPSAtMSB8fCAoZXJybm8gIT0g
RUlOVkFMICYmIGVycm5vICE9IEVJU0RJUiAmJgoKV2h5IGFyZSB5b3UgaGFuZGxpbmcgRUlTRElS
PwoKPiArCQkJZXJybm8gIT0gRU9QTk9UU1VQUCkpCj4gKwkJcmV0dXJuIGZkOwo+ICsJZXJybm8g
PSAwOwoKV2h5IGFyZSB5b3UgcmVzZXR0aW5nIGVycm5vPwoKVGhhbmtzLAovL3JpY2hhcmQKCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1s
aW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==

