Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <inguin@gmx.de>) id 1KxNIY-00022k-Cn
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Nov 2008 14:54:26 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1KxNIP-0000Dk-LG for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Nov 2008 14:54:26 +0000
Message-ID: <491061F1.7030909@gmx.de>
Date: Tue, 04 Nov 2008 15:53:37 +0100
From: Ingo van Lil <inguin@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040504050708040607000805"
Subject: [uml-devel] hostfs leaks file descriptors
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
To: user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040504050708040607000805
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi there,

when hostfs is used as the UML's root filesystem its file descriptors 
aren't closed when the kernel is rebooted. Subsequently, after a couple 
of reboots the guest will reach the maximum number of allowed file 
descriptors (usually 1024) and fail to open any more files.

I tried to fix the problem myself, see patch. It works for me, but I'm 
not sure if it's the correct solution.

Cheers,
Ingo

--------------040504050708040607000805
Content-Type: text/plain;
 name="hostfs-close-files-on-exit.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="hostfs-close-files-on-exit.patch"

SW5kZXg6IGhvc3Rmc19rZXJuLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gaG9zdGZzX2tlcm4uYwko
cmV2aXNpb24gODEzNSkKKysrIGhvc3Rmc19rZXJuLmMJKHdvcmtpbmcgY29weSkKQEAgLTE2
LDYgKzE2LDcgQEAKICNpbmNsdWRlIDxsaW51eC9saXN0Lmg+CiAjaW5jbHVkZSA8bGludXgv
c3RhdGZzLmg+CiAjaW5jbHVkZSA8bGludXgva2Rldl90Lmg+CisjaW5jbHVkZSA8bGludXgv
bW91bnQuaD4KICNpbmNsdWRlIDxhc20vdWFjY2Vzcy5oPgogI2luY2x1ZGUgImhvc3Rmcy5o
IgogI2luY2x1ZGUgImtlcm5fdXRpbC5oIgpAQCAtMTAzNywzICsxMDM4LDE3IEBACiBtb2R1
bGVfaW5pdChpbml0X2hvc3RmcykKIG1vZHVsZV9leGl0KGV4aXRfaG9zdGZzKQogTU9EVUxF
X0xJQ0VOU0UoIkdQTCIpOworCitzdGF0aWMgdm9pZCBob3N0ZnNfZXhpdGNhbGwodm9pZCkK
K3sKKwlzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnJvb3Rfc2IgPSBjdXJyZW50LT5mcy0+cm9vdG1u
dC0+bW50X3NiOworCWlmIChyb290X3NiLT5zX3R5cGUgPT0gJmhvc3Rmc190eXBlKSB7CisJ
CXN0cnVjdCBpbm9kZSAqaW5vZGU7CisJCWxpc3RfZm9yX2VhY2hfZW50cnkoaW5vZGUsICZy
b290X3NiLT5zX2lub2RlcywgaV9zYl9saXN0KSB7CisJCQlpZihIT1NURlNfSShpbm9kZSkt
PmZkICE9IC0xKSB7CisJCQkJY2xvc2VfZmlsZSgmSE9TVEZTX0koaW5vZGUpLT5mZCk7CisJ
CQl9CisJCX0KKwl9Cit9CitfX3VtbF9leGl0Y2FsbChob3N0ZnNfZXhpdGNhbGwpOwo=
--------------040504050708040607000805
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--------------040504050708040607000805
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--------------040504050708040607000805--

