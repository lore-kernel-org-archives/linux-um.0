Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bernat@luffy.cx>) id 1SbpfH-0005i8-17
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Jun 2012 09:02:59 +0000
Received: from bart.luffy.cx ([78.47.78.131])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SbpfB-0002uD-5t
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Jun 2012 09:02:59 +0000
Received: from webmail.luffy.cx (conis.luffy.cx [10.116.129.5])
	by bart.luffy.cx (Postfix) with ESMTP id 450B114110
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue,  5 Jun 2012 11:02:46 +0200 (CEST)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_3c8956d5f328930ff9a56109c85c1d99"
Date: Tue, 05 Jun 2012 11:02:46 +0200
From: Vincent Bernat <bernat@luffy.cx>
Message-ID: <e8f6af0d0128c4a4dde5f3f3fbaac46e@luffy.cx>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] UML: Fix gdbserver "Couldn't write debug register" error
To: user-mode-linux-devel@lists.sourceforge.net

--=_3c8956d5f328930ff9a56109c85c1d99
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8;
 format=flowed

Hi!

Using gdbserver  inside an UML  instance displays "Couldn't  write 
debug
register". I have discovered this  patch from Barry Friedman which 
works
fine for me:
  
http://www.mail-archive.com/user-mode-linux-devel@lists.sourceforge.net/msg06753.html

Here is a rebased version of this patch:


--=_3c8956d5f328930ff9a56109c85c1d99
Content-Transfer-Encoding: base64
Content-Type: text/x-diff;
 name=uml_ptrace64_fix.patch
Content-Disposition: attachment;
 filename=uml_ptrace64_fix.patch

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L3VtL3B0cmFjZV82NC5jIGIvYXJjaC94ODYvdW0vcHRyYWNl
XzY0LmMKaW5kZXggM2I1MmJmMC4uNTgzMDcwYyAxMDA2NDQKLS0tIGEvYXJjaC94ODYvdW0vcHRy
YWNlXzY0LmMKKysrIGIvYXJjaC94ODYvdW0vcHRyYWNlXzY0LmMKQEAgLTEyMCw3ICsxMjAsNyBA
QCBpbnQgcG9rZV91c2VyKHN0cnVjdCB0YXNrX3N0cnVjdCAqY2hpbGQsIGxvbmcgYWRkciwgbG9u
ZyBkYXRhKQogCWVsc2UgaWYgKChhZGRyID49IG9mZnNldG9mKHN0cnVjdCB1c2VyLCB1X2RlYnVn
cmVnWzBdKSkgJiYKIAkJKGFkZHIgPD0gb2Zmc2V0b2Yoc3RydWN0IHVzZXIsIHVfZGVidWdyZWdb
N10pKSkgewogCQlhZGRyIC09IG9mZnNldG9mKHN0cnVjdCB1c2VyLCB1X2RlYnVncmVnWzBdKTsK
LQkJYWRkciA9IGFkZHIgPj4gMjsKKwkJYWRkciA9IGFkZHIgPj4gMzsKIAkJaWYgKChhZGRyID09
IDQpIHx8IChhZGRyID09IDUpKQogCQkJcmV0dXJuIC1FSU87CiAJCWNoaWxkLT50aHJlYWQuYXJj
aC5kZWJ1Z3JlZ3NbYWRkcl0gPSBkYXRhOwpAQCAtMTg3LDcgKzE4Nyw3IEBAIGludCBwZWVrX3Vz
ZXIoc3RydWN0IHRhc2tfc3RydWN0ICpjaGlsZCwgbG9uZyBhZGRyLCBsb25nIGRhdGEpCiAJZWxz
ZSBpZiAoKGFkZHIgPj0gb2Zmc2V0b2Yoc3RydWN0IHVzZXIsIHVfZGVidWdyZWdbMF0pKSAmJgog
CQkoYWRkciA8PSBvZmZzZXRvZihzdHJ1Y3QgdXNlciwgdV9kZWJ1Z3JlZ1s3XSkpKSB7CiAJCWFk
ZHIgLT0gb2Zmc2V0b2Yoc3RydWN0IHVzZXIsIHVfZGVidWdyZWdbMF0pOwotCQlhZGRyID0gYWRk
ciA+PiAyOworCQlhZGRyID0gYWRkciA+PiAzOwogCQl0bXAgPSBjaGlsZC0+dGhyZWFkLmFyY2gu
ZGVidWdyZWdzW2FkZHJdOwogCX0KIAlyZXR1cm4gcHV0X3VzZXIodG1wLCAodW5zaWduZWQgbG9u
ZyAqKSBkYXRhKTsK
--=_3c8956d5f328930ff9a56109c85c1d99
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--=_3c8956d5f328930ff9a56109c85c1d99
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--=_3c8956d5f328930ff9a56109c85c1d99--



