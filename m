Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <toralf.foerster@gmx.de>) id 1Ou1y0-0006na-S7
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Sep 2010 11:40:28 +0000
Received: from mailout-de.gmx.net ([213.165.64.23] helo=mail.gmx.net)
	by sog-mx-2.v43.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1Ou1xy-0005xG-E9 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Sep 2010 11:40:28 +0000
From: Toralf =?utf-8?q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Date: Fri, 10 Sep 2010 13:40:16 +0200
MIME-Version: 1.0
Message-Id: <201009101340.18552.toralf.foerster@gmx.de>
Subject: [uml-devel] [Resend] uml build error for kernel
	v2.6.36-rc3-337-g48d00d6
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
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net

SGVsbG8sCgooaGFkIGhhdmUgcHJvYmxlbXMgd2l0aCBteSBtYWlsZXIgdGhlcmVmb3JlIHByb2Jh
Ymx5IHlvdSBnb3QgdGhpcyBtYWlsIAphbHJlYWR5KQoKVGhlIHVtbCBidWlsZCBpcyBicm9rZW4g
c2luY2Ugc29tZSByZXZpc2lvbnMsIGEgYnVpbGQgZ2l2ZXMgOgoKLi4uCiAgQ0MgICAgICBhcmNo
L3VtL2RyaXZlcnMvaG9zdGF1ZGlvX2tlcm4ubwphcmNoL3VtL2RyaXZlcnMvaG9zdGF1ZGlvX2tl
cm4uYzogSW4gZnVuY3Rpb24g4oCYaG9zdGF1ZGlvX29wZW7igJk6CmFyY2gvdW0vZHJpdmVycy9o
b3N0YXVkaW9fa2Vybi5jOjIwNDogZXJyb3I6IOKAmF9fcGFyYW1fZHNw4oCZIHVuZGVjbGFyZWQg
KGZpcnN0IAp1c2UgaW4gdGhpcyBmdW5jdGlvbikKYXJjaC91bS9kcml2ZXJzL2hvc3RhdWRpb19r
ZXJuLmM6MjA0OiBlcnJvcjogKEVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIApyZXBvcnRl
ZCBvbmx5IG9uY2UKYXJjaC91bS9kcml2ZXJzL2hvc3RhdWRpb19rZXJuLmM6MjA0OiBlcnJvcjog
Zm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbi4pCmFyY2gvdW0vZHJpdmVycy9ob3N0YXVk
aW9fa2Vybi5jOiBJbiBmdW5jdGlvbiDigJhob3N0bWl4ZXJfb3Blbl9taXhkZXbigJk6CmFyY2gv
dW0vZHJpdmVycy9ob3N0YXVkaW9fa2Vybi5jOjI2NTogZXJyb3I6IOKAmF9fcGFyYW1fbWl4ZXLi
gJkgdW5kZWNsYXJlZCAoZmlyc3QgCnVzZSBpbiB0aGlzIGZ1bmN0aW9uKQphcmNoL3VtL2RyaXZl
cnMvaG9zdGF1ZGlvX2tlcm4uYzoyNzI6IGVycm9yOiDigJhfX3BhcmFtX2RzcOKAmSB1bmRlY2xh
cmVkIChmaXJzdCAKdXNlIGluIHRoaXMgZnVuY3Rpb24pCm1ha2VbMV06ICoqKiBbYXJjaC91bS9k
cml2ZXJzL2hvc3RhdWRpb19rZXJuLm9dIEVycm9yIDEKbWFrZTogKioqIFthcmNoL3VtL2RyaXZl
cnNdIEVycm9yIDIKCgotLSAKTWZHL0tpbmQgcmVnYXJkcwpUb3JhbGYgRsO2cnN0ZXIKCnBncCBm
aW5nZXIgcHJpbnQ6IDdCMUEgMDdGNCBFQzgyIDBGOTAgRDRDMiA4OTM2IDg3MkEgRTUwOCA3REI2
IDlEQTMKMDM1MWQ2YTEzZTEyZjExNjk3MTEyZDNjNjc0YmVmNWUKYmQ2YTg1MGY0MDU3NzE2NDU1
MzY2MjJhZGNkNzhmNGNiZTBlZGI5NDc3MDQwY2VmMzEwZTE1ZTEzMjgyMzM5ZAoKCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQpBdXRvbWF0ZSBTdG9yYWdlIFRpZXJpbmcgU2ltcGx5Ck9wdGltaXplIElU
IHBlcmZvcm1hbmNlIGFuZCBlZmZpY2llbmN5IHRocm91Z2ggZmxleGlibGUsIHBvd2VyZnVsLCAK
YXV0b21hdGVkIHN0b3JhZ2UgdGllcmluZyBjYXBhYmlsaXRpZXMuIFZpZXcgdGhpcyBicmllZiB0
byBsZWFybiBob3cKeW91IGNhbiByZWR1Y2UgY29zdHMgYW5kIGltcHJvdmUgcGVyZm9ybWFuY2Uu
IApodHRwOi8vcC5zZi5uZXQvc2Z1L2RlbGwtc2ZkZXYyZGV2Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5n
IGxpc3QKVXNlci1tb2RlLWxpbnV4LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczov
L2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgtZGV2
ZWwK

