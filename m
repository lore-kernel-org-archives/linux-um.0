Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DLvuz-0004VJ-Ms for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Apr 2005 21:25:29 -0700
Received: from zproxy.gmail.com ([64.233.162.195])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DLvux-0004wI-LF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Apr 2005 21:25:29 -0700
Received: by zproxy.gmail.com with SMTP id 9so559409nzo
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 13 Apr 2005 21:25:18 -0700 (PDT)
Message-ID: <cbec11ac0504132125779afc07@mail.gmail.com>
From: Ian McDonald <imcdnzl@gmail.com>
Reply-To: Ian McDonald <imcdnzl@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3725_15504080.1113452718056"
Subject: [uml-devel] Problems with UML on Debian Sarge 64 host
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
Date: Thu, 14 Apr 2005 16:25:18 +1200
To: UML Developer <user-mode-linux-devel@lists.sourceforge.net>

------=_Part_3725_15504080.1113452718056
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi there,

In my continuing saga (which some are becoming familiar with) to get
UML 2.6.x working at all I have been given access to another machine
to develop on and my old machine is going to disappear.

This machine is Debian Sarge with gcc 3.3.5 on an AMD64 with 32 bit
userspace although 64 bit compiles can also occur.

I am doing all my UML builds with ARCH=3Dum SUBARCH=3Di386 at this point in=
 time.

The problem is that my bootup dies very early on and this is the total outp=
ut:
Checking for /proc/mm...not found
Checking PROT_EXEC mmap in /tmp...OK
tracing thread pid =3D 20981
OP_FORK failed to attach pid

I suspect that this is something to do with my mixed 32/64 bit
environment but I am not sure... Can anybody shed some light on this?

BTW I have also written a patch which I think is worth submitting into
the kernel tree as it gives better debugging of error messages in
arch/um/kernel/tt/tracer.c for where my process is dying.

When I run with my patch it shows that it is dying on the
PTRACE_ATTACH with an error EPERM but I can run other processes etc
like gdb which attach to processes.

Any help would be greatly appreciated.

Ian

------=_Part_3725_15504080.1113452718056
Content-Type: text/x-patch; name="tracer.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="tracer.diff"

LS0tIGFyY2gvdW0va2VybmVsL3R0L3RyYWNlci5jLnNhdgkyMDA1LTA0LTE0IDE1OjAyOjUwLjAw
MDAwMDAwMCArMTIwMAorKysgYXJjaC91bS9rZXJuZWwvdHQvdHJhY2VyLmMJMjAwNS0wNC0xNCAx
NTo0NToxMy4xNTE4Njg1NTIgKzEyMDAKQEAgLTY4LDE0ICs2OCwxNyBAQAogCiB2b2lkIGF0dGFj
aF9wcm9jZXNzKGludCBwaWQpCiB7Ci0JaWYoKHB0cmFjZShQVFJBQ0VfQVRUQUNILCBwaWQsIDAs
IDApIDwgMCkgfHwKLQkgICAocHRyYWNlKFBUUkFDRV9DT05ULCBwaWQsIDAsIDApIDwgMCkpCi0J
CXRyYWNlcl9wYW5pYygiT1BfRk9SSyBmYWlsZWQgdG8gYXR0YWNoIHBpZCIpOworCWludCBlcnI7
CisKKwlpZiAoIShlcnIgPSBwdHJhY2UoUFRSQUNFX0FUVEFDSCwgcGlkLCAwLCAwKSkpCisJCXRy
YWNlcl9wYW5pYygiT1BfRk9SSzogUFRSQUNFX0FUVEFDSCBmYWlsZWQsIHBpZCA9ICVkLCBlcnIg
PSAlZFxuIiwgcGlkLCAtZXJyKTsKKwlpZiAoIShlcnIgPSBwdHJhY2UoUFRSQUNFX0NPTlQsIHBp
ZCwgMCwgMCkpKQorCQl0cmFjZXJfcGFuaWMoIk9QX0ZPUks6IFBUUkFDRV9DT05UIGZhaWxlZCwg
cGlkID0gJWQsIGVyciA9ICVkXG4iLCBwaWQsIC1lcnIpOwogCXdhaXRfZm9yX3N0b3AocGlkLCBT
SUdTVE9QLCBQVFJBQ0VfQ09OVCwgTlVMTCk7Ci0JaWYgKHB0cmFjZShQVFJBQ0VfT0xEU0VUT1BU
SU9OUywgcGlkLCAwLCAodm9pZCAqKVBUUkFDRV9PX1RSQUNFU1lTR09PRCkgPCAwKQotCQl0cmFj
ZXJfcGFuaWMoIk9QX0ZPUks6IFBUUkFDRV9TRVRPUFRJT05TIGZhaWxlZCwgZXJybm8gPSAlZCIs
IGVycm5vKTsKLQlpZihwdHJhY2UoUFRSQUNFX0NPTlQsIHBpZCwgMCwgMCkgPCAwKQotCQl0cmFj
ZXJfcGFuaWMoIk9QX0ZPUksgZmFpbGVkIHRvIGNvbnRpbnVlIHByb2Nlc3MiKTsKKwlpZiAoIShl
cnIgPSBwdHJhY2UoUFRSQUNFX09MRFNFVE9QVElPTlMsIHBpZCwgMCwgKHZvaWQgKilQVFJBQ0Vf
T19UUkFDRVNZU0dPT0QpKSkKKwkJdHJhY2VyX3BhbmljKCJPUF9GT1JLOiBQVFJBQ0VfU0VUT1BU
SU9OUyBmYWlsZWQsIHBpZCA9ICVkLCBlcnIgPSAlZFxuIiwgcGlkLCAtZXJyKTsKKwlpZiAoIShl
cnIgPSBwdHJhY2UoUFRSQUNFX0NPTlQsIHBpZCwgMCwgMCkpKQorCQl0cmFjZXJfcGFuaWMoIk9Q
X0ZPUks6IFBUUkFDRV9DT05UICgyKSBmYWlsZWQsIHBpZCA9ICVkLCBlcnIgPSAlZFxuIiwgcGlk
LCAtZXJyKTsKIH0KIAogdm9pZCB0cmFjZXJfcGFuaWMoY2hhciAqZm9ybWF0LCAuLi4pCg==
------=_Part_3725_15504080.1113452718056--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
