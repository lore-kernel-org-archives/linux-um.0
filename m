Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPrea-0005gW-Sk for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 16:36:16 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BPrea-0002fJ-4i for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 16:36:16 -0700
Received: from localhost (henrik@localhost)
	by filer.marasystems.com (8.11.6/8.11.6) with ESMTP id i4HNaEm28418
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 18 May 2004 01:36:14 +0200
From: Henrik Nordstrom <uml@henrik.marasystems.com>
In-Reply-To: <Pine.LNX.4.44.0405172331390.27355-100000@filer.marasystems.com>
Message-ID: <Pine.LNX.4.44.0405180119500.28239-200000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463811839-1725160448-1084836974=:28239"
Subject: [uml-devel] 2.4.26-1 hostfs very broken
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
Date: Tue, 18 May 2004 01:36:14 +0200 (CEST)
To: user-mode-linux-devel@lists.sourceforge.net


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811839-1725160448-1084836974=:28239
Content-Type: TEXT/PLAIN; charset=US-ASCII

hostfs is currently broken in very many ways

a) Mounting fails because it tries to open the hostfs filesystem directory 
as a file.

b) Any file I/O operations hang as their completion function is never 
called unless there is an error.

c) Even if the hostfs is mounted read-only all file operations is done 
read-write. Not sure if it at all cares about the read-only state..

d) Seem to create empty files on any attempt to access (open/stat etc) a 
non-existing file.

e) Mounting of directories ontop of the hostfs fails miserably (/proc 
mount disappeared, still showing the hostfs content)

Attached is a patch with my attempts to correct issues 'a' and 'b' by 
trying to compare with how humfs operates..

Regards
Henrik

---1463811839-1725160448-1084836974=:28239
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="12-hostfs.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0405180136140.28239@filer.marasystems.com>
Content-Description: 
Content-Disposition: attachment; filename="12-hostfs.patch"

QmluYXJ5IGZpbGVzIGxpbnV4LTIuNC4yNi0xLm9yaWcvYXJjaC91bS9mcy9i
dWlsdC1pbi5vIGFuZCBsaW51eC0yLjQuMjYtMS5obm8vYXJjaC91bS9mcy9i
dWlsdC1pbi5vIGRpZmZlcg0KZGlmZiAtcnUgbGludXgtMi40LjI2LTEub3Jp
Zy9hcmNoL3VtL2ZzL2hvc3Rmcy9leHRlcm5mcy5jIGxpbnV4LTIuNC4yNi0x
Lmhuby9hcmNoL3VtL2ZzL2hvc3Rmcy9leHRlcm5mcy5jDQotLS0gbGludXgt
Mi40LjI2LTEub3JpZy9hcmNoL3VtL2ZzL2hvc3Rmcy9leHRlcm5mcy5jCU1v
biBNYXkgMTcgMjM6MzY6MTcgMjAwNA0KKysrIGxpbnV4LTIuNC4yNi0xLmhu
by9hcmNoL3VtL2ZzL2hvc3Rmcy9leHRlcm5mcy5jCVR1ZSBNYXkgMTggMDA6
MTA6NDIgMjAwNA0KQEAgLTExMzMsNyArMTEzMyw3IEBADQogCWlmKChtb3Vu
dF9hcmcgIT0gTlVMTCkgJiYgKCptb3VudF9hcmcgIT0gJ1wwJykpDQogCQly
b290ID0gbW91bnRfYXJnOw0KIA0KLQlyZXR1cm4odW1sX3N0cmR1cChtb3Vu
dF9hcmcpKTsNCisJcmV0dXJuKHVtbF9zdHJkdXAocm9vdCkpOw0KIH0NCiAN
CiBzdHJ1Y3Qgc3VwZXJfYmxvY2sgKmhvc3Rmc19yZWFkX3N1cGVyKHN0cnVj
dCBzdXBlcl9ibG9jayAqc2IsIHZvaWQgKmRhdGEsIA0KQmluYXJ5IGZpbGVz
IGxpbnV4LTIuNC4yNi0xLm9yaWcvYXJjaC91bS9mcy9ob3N0ZnMvZXh0ZXJu
ZnMubyBhbmQgbGludXgtMi40LjI2LTEuaG5vL2FyY2gvdW0vZnMvaG9zdGZz
L2V4dGVybmZzLm8gZGlmZmVyDQpkaWZmIC1ydSBsaW51eC0yLjQuMjYtMS5v
cmlnL2FyY2gvdW0vZnMvaG9zdGZzL2hvc3RfZnMuYyBsaW51eC0yLjQuMjYt
MS5obm8vYXJjaC91bS9mcy9ob3N0ZnMvaG9zdF9mcy5jDQotLS0gbGludXgt
Mi40LjI2LTEub3JpZy9hcmNoL3VtL2ZzL2hvc3Rmcy9ob3N0X2ZzLmMJTW9u
IE1heSAxNyAyMzozNjoxNyAyMDA0DQorKysgbGludXgtMi40LjI2LTEuaG5v
L2FyY2gvdW0vZnMvaG9zdGZzL2hvc3RfZnMuYwlUdWUgTWF5IDE4IDAxOjEy
OjU1IDIwMDQNCkBAIC0xMzgsNiArMTM4LDEwIEBADQogCQlnb3RvIG91dDsN
CiANCiAJZXJyID0gaG9zdF9vcGVuX2ZpbGUocGF0aCwgMSwgMSwgZmgpOw0K
KwlpZiAoZXJyID09IC1FSVNESVIpIHsNCisJICAgIGtmcmVlKGZoKTsNCisJ
ICAgIHJldHVybiBOVUxMOw0KKwl9DQogCWlmKGVycikNCiAJCWdvdG8gb3V0
X2ZyZWU7DQogDQpAQCAtMTc1LDEwICsxNzksOSBAQA0KIAkJCQlsZW4gLSBp
Z25vcmVfZW5kKTsNCiANCiAgb3V0Og0KLQlpZihlcnIgPCAwKQ0KLQkJKCpj
b21wbGV0aW9uKShidWYsIGVyciwgYXJnKTsNCi0JZWxzZSBlcnIgPSAwOw0K
LQ0KKwkoKmNvbXBsZXRpb24pKGJ1ZiwgZXJyLCBhcmcpOw0KKwlpZiAoZXJy
ID4gMCkNCisJICAgIGVyciA9IDA7DQogCXJldHVybihlcnIpOw0KIH0NCiAN
CkBAIC0xOTEsOCArMTk0LDkgQEANCiANCiAJZXJyID0gd3JpdGVfZmlsZShm
aCwgb2Zmc2V0ICsgc3RhcnQsIGJ1ZiArIHN0YXJ0LCBsZW4pOw0KIA0KLQlp
ZihlcnIgPCAwKQ0KLQkJKCpjb21wbGV0aW9uKSgoY2hhciAqKSBidWYsIGVy
ciwgYXJnKTsNCisJKCpjb21wbGV0aW9uKSgoY2hhciAqKSBidWYsIGVyciwg
YXJnKTsNCisJaWYgKGVyciA+IDApDQorCSAgICBlcnIgPSAwOw0KIAlyZXR1
cm4oZXJyKTsNCiB9DQogDQpCaW5hcnkgZmlsZXMgbGludXgtMi40LjI2LTEu
b3JpZy9hcmNoL3VtL2ZzL2hvc3Rmcy9ob3N0X2ZzLm8gYW5kIGxpbnV4LTIu
NC4yNi0xLmhuby9hcmNoL3VtL2ZzL2hvc3Rmcy9ob3N0X2ZzLm8gZGlmZmVy
DQpCaW5hcnkgZmlsZXMgbGludXgtMi40LjI2LTEub3JpZy9hcmNoL3VtL2Zz
L2hvc3Rmcy9ob3N0ZnMubyBhbmQgbGludXgtMi40LjI2LTEuaG5vL2FyY2gv
dW0vZnMvaG9zdGZzL2hvc3Rmcy5vIGRpZmZlcg0K
---1463811839-1725160448-1084836974=:28239--


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
