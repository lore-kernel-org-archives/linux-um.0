Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1V0rao-0003yV-2T
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Jul 2013 11:14:22 +0000
Received: from mout.gmx.net ([212.227.15.19])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V0ram-0004xF-2Y for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Jul 2013 11:14:22 +0000
Received: from [80.171.226.24] ([80.171.226.24]) by mail.gmx.com (mrgmx002)
	with ESMTPSA (Nemesis) id 0MQ2zr-1V4SEH0Xpr-005FlK for
	<user-mode-linux-devel@lists.sourceforge.net>; Sun, 21 Jul 2013 13:14:14
	+0200
Message-ID: <51EBC285.2030104@gmx.de>
Date: Sun, 21 Jul 2013 13:14:13 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
References: <51EAA7A7.4000104@gmx.de> <20130721010352.GB21484@thunk.org>
In-Reply-To: <20130721010352.GB21484@thunk.org>
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
Subject: Re: [uml-devel] fuzzying a user mode linux image often core dumps
	with
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

T24gMDcvMjEvMjAxMyAwMzowMyBBTSwgVGhlb2RvcmUgVHMnbyB3cm90ZToKPiBPbiBTYXQsIEp1
bCAyMCwgMjAxMyBhdCAwNTowNzoxOVBNICswMjAwLCBUb3JhbGYgRsO2cnN0ZXIgd3JvdGU6Cj4+
IEkgZG8gcnVuIHRoZSBmdXp6ZXIgdHJpbml0eSB3aXRoaW4gYSAzMiBiaXQgdXNlciBtb2RlIGxp
bnV4Lgo+PiBXaXRoIGxhdGVzdCBnaXQgdHJlZSBJIGRvIG9mdGVuIGdldCBhIGNvcmUgZHVtcCBs
aWtlIHRoZSBvbmUgYXR0YWNoZWQuCj4+Cj4+IEFsdGhvdWdoIGl0IGlzIHRoZSBuYXR1cmUgb2Yg
dHJpbml0eSB0byBjb3JydXB0IHRoZSBrZXJuZWwgL21lIHdvbmRlcnMgd2h5IGl0IGhhcHBlbnMg
bmVhcmx5IGFsd2F5Cj4+IGF0IHRoZSBzYW1lIHBsYWNlLiBUaGF0J3Mgd2h5IEkgZGVjaWRlZCB0
byBqdXN0IHJlcG9ydCBpdCBoZXJlLgo+IAo+IFRoYW5rcywgdGhpcyBpcyBhIGtub3duIHByb2Js
ZW0gZm9yIHdoaWNoIHRoZSBmaXggaXMgY2FuIGJlIGZvdW5kIGhlcmU6Cj4gCj4gCWh0dHA6Ly9w
YXRjaHdvcmsub3psYWJzLm9yZy9wYXRjaC8yNjAyNTAvCj4gCkFoIC0gc28gbm8gYmlzZWN0aW5n
IG5lY2Vzc2FyeS4KCj4gSSBob3BlIHRvIGdldCB0aGlzIGZpeGVkIGJlZm9yZSAtcmMyIGlzIHJl
bGVhc2VkOyB0aGUgb25seSBxdWVzdGlvbiBhdAo+IHRoZSBtb21lbnQgaXMgd2hldGhlciB0aGUg
Zml4IGlzIGdvaW5nIHRvIGdvIHRvIExpbnVzIHZpYSB0aGUgZXh0NAo+IHRyZWUgb3IgdGhlIFZG
UyB0cmVlLi4uLgoKeWVwIC0gTGludXMgaGFkIGl0IG5vdyBpbiBpdHMgdHJlZS0uCgpCVFcgdGhh
dCBpc3N1ZSBzZWVtcyB0byBiZSB0aGUgcmVhc29uIGZvciBhIGxvdCBvZiBlcnJhdGljYWxseSBj
cmFzaGVzCm9mIGFuIFVNTCB3aGlsZSBmdXp6eSB0ZXN0ZWQuCgotLSAKTWZHL1NpbmNlcmVseQpU
b3JhbGYgRsO2cnN0ZXIKcGdwIGZpbmdlciBwcmludDogN0IxQSAwN0Y0IEVDODIgMEY5MCBENEMy
IDg5MzYgODcyQSBFNTA4IDdEQjYgOURBMwoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClNlZSBldmVy
eXRoaW5nIGZyb20gdGhlIGJyb3dzZXIgdG8gdGhlIGRhdGFiYXNlIHdpdGggQXBwRHluYW1pY3MK
R2V0IGVuZC10by1lbmQgdmlzaWJpbGl0eSB3aXRoIGFwcGxpY2F0aW9uIG1vbml0b3JpbmcgZnJv
bSBBcHBEeW5hbWljcwpJc29sYXRlIGJvdHRsZW5lY2tzIGFuZCBkaWFnbm9zZSByb290IGNhdXNl
IGluIHNlY29uZHMuClN0YXJ0IHlvdXIgZnJlZSB0cmlhbCBvZiBBcHBEeW5hbWljcyBQcm8gdG9k
YXkhCmh0dHA6Ly9wdWJhZHMuZy5kb3VibGVjbGljay5uZXQvZ2FtcGFkL2Nsaz9pZD00ODgwODgz
MSZpdT0vNDE0MC9vc3RnLmNsa3RyawpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9k
ZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vm
b3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==

