Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQ1ZQ-0000MP-Eb for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 03:11:36 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BQ1ZP-0005jP-MQ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 03:11:35 -0700
Received: from localhost (henrik@localhost)
	by filer.marasystems.com (8.11.6/8.11.6) with ESMTP id i4IABXa05422
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 18 May 2004 12:11:33 +0200
From: Henrik Nordstrom <uml@hno.marasystems.com>
In-Reply-To: <Pine.LNX.4.44.0405180119500.28239-200000@filer.marasystems.com>
Message-ID: <Pine.LNX.4.44.0405181202490.5370-200000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463811839-1085372461-1084875093=:5370"
Subject: [uml-devel] [patch] 2.4.26-1 hostfs very broken
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 18 May 2004 12:11:33 +0200 (CEST)
To: user-mode-linux-devel@lists.sourceforge.net


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811839-1085372461-1084875093=:5370
Content-Type: TEXT/PLAIN; charset=US-ASCII

Attached is a revised patch to fix hostfs operation in 2.4.26-1. This 
replaces the earlier patch sent yesterday.

  + Correct default root path
  + Fix open flags when opening files
  + Don't create files when opening (only on create)
  + Set gid to 0 to not confuse with host permissions
  + Handle files not writable on the host
  + Signal completetion on I/O operations

This has been tested so far that

   - It boots my hostfs root read-only without destroying the contents
   - I can manually mount a directory from the host read-write and normal 
read/write operations seem to work (creation of files, writing etc)

The patch does change some functions in the common framework shared with 
humfs but from what I can tell the issues corrected in the common files 
should affect humfs as well and I do not expect these changes to have any 
ill effect on humfs, but I have not verified humfs operation.

Regards
Henrik

---1463811839-1085372461-1084875093=:5370
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="12-hostfs.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0405181211330.5370@filer.marasystems.com>
Content-Description: 
Content-Disposition: attachment; filename="12-hostfs.patch"

ZGlmZiAtcnUgbGludXgtMi40LjI2LTEub3JpZy9hcmNoL3VtL2ZzL2hvc3Rm
cy9leHRlcm5mcy5jIGxpbnV4LTIuNC4yNi0xLmhuby9hcmNoL3VtL2ZzL2hv
c3Rmcy9leHRlcm5mcy5jDQotLS0gbGludXgtMi40LjI2LTEub3JpZy9hcmNo
L3VtL2ZzL2hvc3Rmcy9leHRlcm5mcy5jCU1vbiBNYXkgMTcgMjM6MzY6MTcg
MjAwNA0KKysrIGxpbnV4LTIuNC4yNi0xLmhuby9hcmNoL3VtL2ZzL2hvc3Rm
cy9leHRlcm5mcy5jCVR1ZSBNYXkgMTggMDA6MTA6NDIgMjAwNA0KQEAgLTEx
MzMsNyArMTEzMyw3IEBADQogCWlmKChtb3VudF9hcmcgIT0gTlVMTCkgJiYg
KCptb3VudF9hcmcgIT0gJ1wwJykpDQogCQlyb290ID0gbW91bnRfYXJnOw0K
IA0KLQlyZXR1cm4odW1sX3N0cmR1cChtb3VudF9hcmcpKTsNCisJcmV0dXJu
KHVtbF9zdHJkdXAocm9vdCkpOw0KIH0NCiANCiBzdHJ1Y3Qgc3VwZXJfYmxv
Y2sgKmhvc3Rmc19yZWFkX3N1cGVyKHN0cnVjdCBzdXBlcl9ibG9jayAqc2Is
IHZvaWQgKmRhdGEsIA0KZGlmZiAtcnUgbGludXgtMi40LjI2LTEub3JpZy9h
cmNoL3VtL2ZzL2hvc3Rmcy9ob3N0X2ZpbGUuYyBsaW51eC0yLjQuMjYtMS5o
bm8vYXJjaC91bS9mcy9ob3N0ZnMvaG9zdF9maWxlLmMNCi0tLSBsaW51eC0y
LjQuMjYtMS5vcmlnL2FyY2gvdW0vZnMvaG9zdGZzL2hvc3RfZmlsZS5jCU1v
biBNYXkgMTcgMjM6MzY6MTcgMjAwNA0KKysrIGxpbnV4LTIuNC4yNi0xLmhu
by9hcmNoL3VtL2ZzL2hvc3Rmcy9ob3N0X2ZpbGUuYwlUdWUgTWF5IDE4IDEx
OjQwOjQ3IDIwMDQNCkBAIC03MiwyOCArNzIsMjEgQEANCiB7DQogCWNoYXIg
dG1wW0hPU1RGU19CVUZTSVpFXSwgKmZpbGU7DQogCWludCBtb2RlID0gMCwg
ZXJyOw0KKwlzdHJ1Y3Qgb3BlbmZsYWdzIGZsYWdzID0gT1BFTkZMQUdTKCk7
DQogDQotCWlmKHIgJiYgIXcpIA0KLQkJbW9kZSA9IE9fUkRPTkxZOw0KLQll
bHNlIGlmKCFyICYmIHcpIA0KLQkJbW9kZSA9IE9fV1JPTkxZOw0KLQllbHNl
IGlmKHIgJiYgdykgDQotCQltb2RlID0gT19SRFdSOw0KLQllbHNlIHsNCi0J
ICAJcHJpbnRrKCJJbXBvc3NpYmxlIG1vZGUgaW4gaG9zdF9vcGVuX2ZpbGUg
LSByID0gJWQsIHcgPSAlZCIsIA0KLQkJICAgICAgIHIsIHcpOw0KLQkJcmV0
dXJuKC1FSU5WQUwpOw0KLQl9DQotDQorCWlmIChyKQ0KKwkgICAgZmxhZ3Mg
PSBvZl9yZWFkKGZsYWdzKTsNCisJaWYgKHcpDQorCSAgICBmbGFncyA9IG9m
X3dyaXRlKGZsYWdzKTsNCiAJaWYoYXBwZW5kKQ0KLQkJbW9kZSB8PSBPX0FQ
UEVORDsNCisJICAgIGZsYWdzID0gb2ZfYXBwZW5kKGZsYWdzKTsNCiANCiAJ
ZXJyID0gLUVOT01FTTsNCiAJZmlsZSA9IGdldF9wYXRoKHBhdGgsIHRtcCwg
c2l6ZW9mKHRtcCkpOw0KIAlpZihmaWxlID09IE5VTEwpDQogCQlnb3RvIG91
dDsNCiAJDQotCWVyciA9IG9wZW5fZmlsZWhhbmRsZShmaWxlLCBvZl9jcmVh
dGUob2ZfcmR3cihPUEVORkxBR1MoKSkpLCBtb2RlLCBmaCk7DQorCWVyciA9
IG9wZW5fZmlsZWhhbmRsZShmaWxlLCBmbGFncywgMCwgZmgpOw0KICBvdXQ6
DQogCWZyZWVfcGF0aChmaWxlLCB0bXApOw0KIAlyZXR1cm4oZXJyKTsNCmRp
ZmYgLXJ1IGxpbnV4LTIuNC4yNi0xLm9yaWcvYXJjaC91bS9mcy9ob3N0ZnMv
aG9zdF9mcy5jIGxpbnV4LTIuNC4yNi0xLmhuby9hcmNoL3VtL2ZzL2hvc3Rm
cy9ob3N0X2ZzLmMNCi0tLSBsaW51eC0yLjQuMjYtMS5vcmlnL2FyY2gvdW0v
ZnMvaG9zdGZzL2hvc3RfZnMuYwlNb24gTWF5IDE3IDIzOjM2OjE3IDIwMDQN
CisrKyBsaW51eC0yLjQuMjYtMS5obm8vYXJjaC91bS9mcy9ob3N0ZnMvaG9z
dF9mcy5jCVR1ZSBNYXkgMTggMTE6Mzg6NTEgMjAwNA0KQEAgLTExMSwxMCAr
MTExLDE0IEBADQogew0KIAljb25zdCBjaGFyICpwYXRoW10gPSB7IGphaWxf
ZGlyLCBtb3VudCwgZmlsZSwgTlVMTCB9Ow0KIAlpbnQgdWlkOw0KKwlpbnQg
Z2lkOw0KKwlpbnQgcmM7DQogDQorCS8qIFRoZXNlIHNob3VsZCBiZSBtb3Vu
dCBmbGFncyBmcm9tIGFuIGludGVybmFsICJzdXBlcmJsb2NrIiAqLw0KIAkq
dWlkX291dCA9IDA7DQorCSpnaWRfb3V0ID0gMDsNCiAJcmV0dXJuKGhvc3Rf
c3RhdF9maWxlKHBhdGgsIGRldl9vdXQsIGlub2RlX291dCwgbW9kZV9vdXQs
IG5saW5rX291dCwgDQotCQkJICAgICAgJnVpZCwgZ2lkX291dCwgc2l6ZV9v
dXQsIGF0aW1lX291dCwgbXRpbWVfb3V0LCANCisJCQkgICAgICAmdWlkLCAm
Z2lkLCBzaXplX291dCwgYXRpbWVfb3V0LCBtdGltZV9vdXQsIA0KIAkJCSAg
ICAgIGN0aW1lX291dCwgYmxrc2l6ZV9vdXQsIGJsb2Nrc19vdXQpKTsNCiB9
DQogDQpAQCAtMTM4LDYgKzE0MiwxMiBAQA0KIAkJZ290byBvdXQ7DQogDQog
CWVyciA9IGhvc3Rfb3Blbl9maWxlKHBhdGgsIDEsIDEsIGZoKTsNCisJaWYg
KGVyciA9PSAtRUlTRElSKSB7DQorCSAgICBrZnJlZShmaCk7DQorCSAgICBy
ZXR1cm4gTlVMTDsNCisJfQ0KKwlpZiAoZXJyID09IC1FUEVSTSkNCisJICAg
IGVyciA9IGhvc3Rfb3Blbl9maWxlKHBhdGgsIDEsIDAsIGZoKTsNCiAJaWYo
ZXJyKQ0KIAkJZ290byBvdXRfZnJlZTsNCiANCkBAIC0xNzUsMTAgKzE4NSw5
IEBADQogCQkJCWxlbiAtIGlnbm9yZV9lbmQpOw0KIA0KICBvdXQ6DQotCWlm
KGVyciA8IDApDQotCQkoKmNvbXBsZXRpb24pKGJ1ZiwgZXJyLCBhcmcpOw0K
LQllbHNlIGVyciA9IDA7DQotDQorCSgqY29tcGxldGlvbikoYnVmLCBlcnIs
IGFyZyk7DQorCWlmIChlcnIgPiAwKQ0KKwkgICAgZXJyID0gMDsNCiAJcmV0
dXJuKGVycik7DQogfQ0KIA0KQEAgLTE5MSw4ICsyMDAsOSBAQA0KIA0KIAll
cnIgPSB3cml0ZV9maWxlKGZoLCBvZmZzZXQgKyBzdGFydCwgYnVmICsgc3Rh
cnQsIGxlbik7DQogDQotCWlmKGVyciA8IDApDQotCQkoKmNvbXBsZXRpb24p
KChjaGFyICopIGJ1ZiwgZXJyLCBhcmcpOw0KKwkoKmNvbXBsZXRpb24pKChj
aGFyICopIGJ1ZiwgZXJyLCBhcmcpOw0KKwlpZiAoZXJyID4gMCkNCisJICAg
IGVyciA9IDA7DQogCXJldHVybihlcnIpOw0KIH0NCiANCg==
---1463811839-1085372461-1084875093=:5370--


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
