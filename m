Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEw0g-0001oG-1G for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 13:34:10 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CEw0W-00032Y-A3 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 13:34:09 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C4AB1A.9E5D1A9F"
Subject: RE: [uml-devel] 2.6.8.1: Kernel panic: handle_trap - failed to wait
	at end of syscall, errno = 4, status = 4479
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C4D@ABGEX01E.abg.fsc.net>
From: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
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
Date: Tue, 5 Oct 2004 22:33:48 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net
Cc: "Tsillas, Demetrios J" <jtsillas@enterasys.com>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4AB1A.9E5D1A9F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This looks like the problem I noticed on my system. It occurs with
2.6.8.1 on a host without sysemu support.

Please try applying this patch, it changes the the code to be equal to
2.6.9 (if the patch is broken, use the attachment please):

--- arch/um/kernel/skas/process.c	2004-09-17 19:20:15.000000000
+0200
+++ arch/um/kernel/skas/process.c	2004-09-21 14:32:22.129327631
+0200
@@ -68,25 +68,25 @@
 		return;
 	}
=20
-	handle_syscall(regs);
-	if(use_sysemu)
-		return;
+	if(!use_sysemu) {
+		err =3D ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET,
__NR_getpid);
+		if(err < 0)
+			panic("handle_trap - nullifying syscall failed,
errno =3D %d\n",
+			      errno);
=20
-	err =3D ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET,
__NR_getpid);
-	if(err < 0)
-		panic("handle_trap - nullifying syscall failed, errno =3D
%d\n",
-		      errno);
+		err =3D ptrace(PTRACE_SYSCALL, pid, 0, 0);
+		if(err < 0)
+			panic("handle_trap - continuing to end of
syscall failed, "
+			      "errno =3D %d\n", errno);
=20
-	err =3D ptrace(PTRACE_SYSCALL, pid, 0, 0);
-	if(err < 0)
-		panic("handle_trap - continuing to end of syscall
failed, "
-		      "errno =3D %d\n", errno);
-
-	CATCH_EINTR(err =3D waitpid(pid, &status, WUNTRACED));
-	if((err < 0) || !WIFSTOPPED(status) ||=20
-	   (WSTOPSIG(status) !=3D SIGTRAP))
-		panic("handle_trap - failed to wait at end of syscall, "
-		      "errno =3D %d, status =3D %d\n", errno, status);
+		CATCH_EINTR(err =3D waitpid(pid, &status, WUNTRACED));
+		if((err < 0) || !WIFSTOPPED(status) ||=20
+		   (WSTOPSIG(status) !=3D SIGTRAP))
+			panic("handle_trap - failed to wait at end of
syscall, "
+			      "err =3D %d, errno =3D %d, status =3D %x\n",
err, errno, status);
+	}
+
+	handle_syscall(regs);
 }
=20
 static int userspace_tramp(void *arg) =20

-----Original Message-----
From: user-mode-linux-devel-admin@lists.sourceforge.net
[mailto:user-mode-linux-devel-admin@lists.sourceforge.net] On Behalf Of
BlaisorBlade
Sent: Tuesday, October 05, 2004 9:44 PM
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Tsillas, Demetrios J
Subject: Re: [uml-devel] 2.6.8.1: Kernel panic: handle_trap - failed to
wait at end of syscall, errno =3D 4, status =3D 4479

On Tuesday 05 October 2004 21:22, Tsillas, Demetrios J wrote:
> I'm trying with root_fs.fc-2-client.pristine.20040504. I've got the=20
> incrementals in there:
Tried without any of them? Does it make any difference? Also, against
which tree are you applying patches, 2.6.8.1-1 or 2.6.9-rc2-mm4? And
does using different filesystems change anything?

> VFS: Mounted root (ext2 filesystem) readonly.
> Mounted devfs on /dev
> INIT: version 2.85 booting
> Kernel panic: handle_trap - failed to wait at end of syscall, errno =
=3D=20
> 4, status =3D 4479

This is quite strange. The child has been stopped by SIGCHLD, which is
completely unexpected (except if any syscall is executing on the host).
Have you made sure you have moved, inside the fs, /lib/tls to
/lib/notls?

About the 4479 value:
./testprogs/waitstatus 4479
WSTOPSIG(status) is 17

Signal 17 is SIGCHLD
waitstatus.c:

#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char * argv[])
{
        int status =3D 2943;
        if (argc >=3D 2)
                status =3D atol(argv[1]);
        if (WIFSIGNALED(status))
                printf("error, process signaled\n");
        if (WIFEXITED(status))
                printf("error, process exited\n");
        if (!WIFSTOPPED(status))
                printf("error, process not stopped\n");
        if (WSTOPSIG(status) !=3D SIGTRAP)
                printf("WSTOPSIG(status) is %d\n", WSTOPSIG(status));
        return 0;
}

--
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give
us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out
more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

------_=_NextPart_001_01C4AB1A.9E5D1A9F
Content-Type: application/octet-stream;
	name="patch-sysemu-panic"
Content-Transfer-Encoding: base64
Content-Description: patch-sysemu-panic
Content-Disposition: attachment;
	filename="patch-sysemu-panic"

LS0tIGFyY2gvdW0va2VybmVsL3NrYXMvcHJvY2Vzcy5jCTIwMDQtMDktMTcgMTk6MjA6MTUuMDAw
MDAwMDAwICswMjAwCisrKyBhcmNoL3VtL2tlcm5lbC9za2FzL3Byb2Nlc3MuYwkyMDA0LTA5LTIx
IDE0OjMyOjIyLjEyOTMyNzYzMSArMDIwMApAQCAtNjgsMjUgKzY4LDI1IEBACiAJCXJldHVybjsK
IAl9CiAKLQloYW5kbGVfc3lzY2FsbChyZWdzKTsKLQlpZih1c2Vfc3lzZW11KQotCQlyZXR1cm47
CisJaWYoIXVzZV9zeXNlbXUpIHsKKwkJZXJyID0gcHRyYWNlKFBUUkFDRV9QT0tFVVNFUiwgcGlk
LCBQVF9TWVNDQUxMX05SX09GRlNFVCwgX19OUl9nZXRwaWQpOworCQlpZihlcnIgPCAwKQorCQkJ
cGFuaWMoImhhbmRsZV90cmFwIC0gbnVsbGlmeWluZyBzeXNjYWxsIGZhaWxlZCwgZXJybm8gPSAl
ZFxuIiwKKwkJCSAgICAgIGVycm5vKTsKIAotCWVyciA9IHB0cmFjZShQVFJBQ0VfUE9LRVVTRVIs
IHBpZCwgUFRfU1lTQ0FMTF9OUl9PRkZTRVQsIF9fTlJfZ2V0cGlkKTsKLQlpZihlcnIgPCAwKQot
CQlwYW5pYygiaGFuZGxlX3RyYXAgLSBudWxsaWZ5aW5nIHN5c2NhbGwgZmFpbGVkLCBlcnJubyA9
ICVkXG4iLAotCQkgICAgICBlcnJubyk7CisJCWVyciA9IHB0cmFjZShQVFJBQ0VfU1lTQ0FMTCwg
cGlkLCAwLCAwKTsKKwkJaWYoZXJyIDwgMCkKKwkJCXBhbmljKCJoYW5kbGVfdHJhcCAtIGNvbnRp
bnVpbmcgdG8gZW5kIG9mIHN5c2NhbGwgZmFpbGVkLCAiCisJCQkgICAgICAiZXJybm8gPSAlZFxu
IiwgZXJybm8pOwogCi0JZXJyID0gcHRyYWNlKFBUUkFDRV9TWVNDQUxMLCBwaWQsIDAsIDApOwot
CWlmKGVyciA8IDApCi0JCXBhbmljKCJoYW5kbGVfdHJhcCAtIGNvbnRpbnVpbmcgdG8gZW5kIG9m
IHN5c2NhbGwgZmFpbGVkLCAiCi0JCSAgICAgICJlcnJubyA9ICVkXG4iLCBlcnJubyk7Ci0KLQlD
QVRDSF9FSU5UUihlcnIgPSB3YWl0cGlkKHBpZCwgJnN0YXR1cywgV1VOVFJBQ0VEKSk7Ci0JaWYo
KGVyciA8IDApIHx8ICFXSUZTVE9QUEVEKHN0YXR1cykgfHwgCi0JICAgKFdTVE9QU0lHKHN0YXR1
cykgIT0gU0lHVFJBUCkpCi0JCXBhbmljKCJoYW5kbGVfdHJhcCAtIGZhaWxlZCB0byB3YWl0IGF0
IGVuZCBvZiBzeXNjYWxsLCAiCi0JCSAgICAgICJlcnJubyA9ICVkLCBzdGF0dXMgPSAlZFxuIiwg
ZXJybm8sIHN0YXR1cyk7CisJCUNBVENIX0VJTlRSKGVyciA9IHdhaXRwaWQocGlkLCAmc3RhdHVz
LCBXVU5UUkFDRUQpKTsKKwkJaWYoKGVyciA8IDApIHx8ICFXSUZTVE9QUEVEKHN0YXR1cykgfHwg
CisJCSAgIChXU1RPUFNJRyhzdGF0dXMpICE9IFNJR1RSQVApKQorCQkJcGFuaWMoImhhbmRsZV90
cmFwIC0gZmFpbGVkIHRvIHdhaXQgYXQgZW5kIG9mIHN5c2NhbGwsICIKKwkJCSAgICAgICJlcnIg
PSAlZCwgZXJybm8gPSAlZCwgc3RhdHVzID0gJXhcbiIsIGVyciwgZXJybm8sIHN0YXR1cyk7CisJ
fQorCisJaGFuZGxlX3N5c2NhbGwocmVncyk7CiB9CiAKIHN0YXRpYyBpbnQgdXNlcnNwYWNlX3Ry
YW1wKHZvaWQgKmFyZykK

------_=_NextPart_001_01C4AB1A.9E5D1A9F--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
