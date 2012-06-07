Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <martin.partel@gmail.com>) id 1SckSc-0005Tg-Dq
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 21:41:42 +0000
Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SckSb-0002FR-PM
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 21:41:42 +0000
Received: by lbol5 with SMTP id l5so1060451lbo.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 07 Jun 2012 14:41:35 -0700 (PDT)
Message-ID: <4FD1200D.8030101@gmail.com>
Date: Fri, 08 Jun 2012 00:41:33 +0300
From: =?ISO-8859-1?Q?Martin_P=E4rtel?= <martin.partel@gmail.com>
MIME-Version: 1.0
References: <4FD1164B.6060307@gmail.com> <4FD11C88.6090308@nod.at>
In-Reply-To: <4FD11C88.6090308@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] um: pass siginfo to guest process
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>

(ack, forgot to reply to list)

On 06/08/2012 12:26 AM, Richard Weinberger wrote:

> Am 07.06.2012 22:59, schrieb Martin P=E4rtel:
>> Signal handlers in UML guest processes now get correct siginfo_t fields
>> for SIGTRAP, SIGFPE, SIGILL and SIGBUS. Specifically, si_addr and si_code
>> are now correct where previously they were si_addr =3D NULL and si_code =
=3D 128.
>
> What exactly is broken?
> In my SIGSEGV test case si_addr is not NULL, it contains the correct faul=
ting address.
>


SIGSEGV is probably fine. At least SIGFPE is not. Test program below.



>> +
>> +			ptrace(PTRACE_GETSIGINFO, pid, 0,&si);
>> +
>
> Doesn't this leak the host siginfo_t into the guest?
>


Docs for PTRACE_GETSIGINFO say `si' gets a copy. After that, `si' is not =

used for anything other than giving it to the guest. But I really can't =

say I understand the surrounding code too well so please review carefully :)



---
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <signal.h>

void handler(int num, siginfo_t *info, void *data)
{
     printf("CAUGHT SIGNAL %d - si_addr =3D %p - si_code =3D %d\n", num, =

info->si_addr, info->si_code);
     _exit(1);
}

int main()
{
     struct sigaction act;
     act.sa_sigaction =3D &handler;
     sigemptyset(&act.sa_mask);
     act.sa_flags =3D SA_SIGINFO;

     sigaction(SIGFPE, &act, NULL);

     printf("%d\n", 3 / 0);

     return 0;
}

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

