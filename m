Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1d84vo-0006h7-Vm
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 May 2017 13:12:00 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d84vn-0004XE-2d
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 May 2017 13:12:00 +0000
References: <8EF94724-26BB-423D-B75F-1CF6646F72C3@m3y3r.de>
	<CAFLxGvyHNTgYm6FP1LUFV4TSTna4aHTfV+4rEfv55-s0W_9uxA@mail.gmail.com>
	<20170508170235.Horde.YC-JKHq_morEKrQOv2d0DV3@webmail.your-server.de>
	<d46e744a-da30-fe81-fb4d-2a4648550a27@nod.at>
	<76397EFF-15DB-4F55-B402-DBE7BA1FB02D@m3y3r.de>
	<3f832424-0ae6-1009-cf87-c94794e919ef@nod.at>
	<0419DC3A-B4B7-4005-B068-EF0583433B92@m3y3r.de>
	<D39536F2-909A-40FB-B47F-44A31C56D286@m3y3r.de>
	<66f46b90-6312-449f-2c52-d12fc53f18f6@nod.at>
	<20170509101536.Horde.EnvMo4uaHVafhqi80MdUNWc@webmail.your-server.de>
From: Richard Weinberger <richard@nod.at>
Message-ID: <0c36ac98-761a-bf07-a6ef-13f0f7b7b561@nod.at>
Date: Tue, 9 May 2017 15:11:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170509101536.Horde.EnvMo4uaHVafhqi80MdUNWc@webmail.your-server.de>
Content-Type: multipart/mixed; boundary="------------E5A1A9AB41AD38A61A2365EA"
Subject: Re: [uml-devel] [uml-user] UML on WSL
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
To: Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------E5A1A9AB41AD38A61A2365EA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Thomas,

Am 09.05.2017 um 10:15 schrieb Thomas Meyer:
> attached patch work correctly under Linux. But no change under WSL. As stated in the relevant GH issue, there seems to be far more road blockers to make UML work under WSL.
> 
> With you patch I get under WSL:
> 
> thomas@DESKTOP-DQBDJ0U:/mnt/c/Users/thomas/VmShare$ ./linux
> Core dump limits :
>         soft - NONE
>         hard - NONE
> Checking that ptrace can change system call numbers...check_ptrace : failed to modify system call: Invalid Argument

Okay, now it fails later.
UML needs to cancel  syscalls on the host side, it does so by turning them into a getpid() which has no side
effects and, on non-ancient systems, by using PTRACE_SYSEMU.
Let's figure whether they support PTRACE_SYSEMU, can you test the attached patch?

Also please test segv1.c, it tests whether WSL allows us to handle page faults in userspace.
It should output this:
SIGSEGV at 0xdeadbeef, fixing up
x=3, &x=0xdeadbeef

IOW we write to 0xdeadbeef, catch the fault and fix it.

Thanks,
//richard

--------------E5A1A9AB41AD38A61A2365EA
Content-Type: text/x-patch;
 name="uml_no_syscallchange.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="uml_no_syscallchange.diff"

diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 22a358ef1b0c..37c42cead79d 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -259,7 +259,7 @@ static void __init check_sysemu(void)
 static void __init check_ptrace(void)
 {
 	int pid, syscall, n, status;
-
+#if 0
 	non_fatal("Checking that ptrace can change system call numbers...");
 	pid =3D start_ptraced_child();
=20
@@ -293,6 +293,7 @@ static void __init check_ptrace(void)
 	}
 	stop_ptraced_child(pid, 0, 1);
 	non_fatal("OK\n");
+#endif
 	check_sysemu();
 }
=20

--------------E5A1A9AB41AD38A61A2365EA
Content-Type: text/x-csrc;
 name="segv1.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="segv1.c"

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/ucontext.h>
#include <signal.h>
#include <errno.h>

static void segv(int sig, siginfo_t *info, void *context)
{
	ucontext_t *c =3D context;
	mcontext_t m =3D c->uc_mcontext;
	void *fault_addr =3D (void *)m.gregs[REG_CR2];
	void *addr;

	printf("SIGSEGV at 0x%lx, fixing up\n", (unsigned long)fault_addr);

	addr =3D mmap(fault_addr, 4096, PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_=
PRIVATE, 0, 0);
	if (addr =3D=3D MAP_FAILED) {
		printf("map failed!\n");
		exit(1);
	}
}

static void install_handler(void)
{
	struct sigaction sa;

	sa.sa_sigaction =3D segv;
	sa.sa_flags =3D SA_SIGINFO;

	sigaction(SIGSEGV, &sa, NULL);
}

int main(void)
{
	int *x =3D (void *)0xdeadbeef;

	install_handler();

	*x =3D 3;

	printf("x=3D%i, &x=3D%p\n", *x, x);

	return 0;
}

--------------E5A1A9AB41AD38A61A2365EA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--------------E5A1A9AB41AD38A61A2365EA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--------------E5A1A9AB41AD38A61A2365EA--


