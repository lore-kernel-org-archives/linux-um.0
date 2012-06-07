Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <martin.partel@gmail.com>) id 1SclPC-0007QB-UV
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 22:42:14 +0000
Received: from mail-lpp01m010-f47.google.com ([209.85.215.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SclPC-0002wg-6X
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 22:42:14 +0000
Received: by lags15 with SMTP id s15so955034lag.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 07 Jun 2012 15:42:07 -0700 (PDT)
Message-ID: <4FD12E3D.7050401@gmail.com>
Date: Fri, 08 Jun 2012 01:42:05 +0300
From: =?ISO-8859-1?Q?Martin_P=E4rtel?= <martin.partel@gmail.com>
MIME-Version: 1.0
References: <4FD1164B.6060307@gmail.com> <4FD11C88.6090308@nod.at>
	<4FD11F90.5080407@gmail.com> <4FD1263B.5070208@nod.at>
In-Reply-To: <4FD1263B.5070208@nod.at>
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
To: Richard Weinberger <richard@nod.at>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On 06/08/2012 01:07 AM, Richard Weinberger wrote:

> Am 07.06.2012 23:39, schrieb Martin P=E4rtel:
>> On 06/08/2012 12:26 AM, Richard Weinberger wrote:
>>
>>> Am 07.06.2012 22:59, schrieb Martin P=E4rtel:
>>>> Signal handlers in UML guest processes now get correct siginfo_t fields
>>>> for SIGTRAP, SIGFPE, SIGILL and SIGBUS. Specifically, si_addr and si_c=
ode
>>>> are now correct where previously they were si_addr =3D NULL and si_cod=
e =3D 128.
>>>
>>> What exactly is broken?
>>> In my SIGSEGV test case si_addr is not NULL, it contains the correct fa=
ulting address.
>>>
>>
>>
>> SIGSEGV is probably fine. At least SIGFPE is not. Test program below.
>>
>>>> +
>>>> +            ptrace(PTRACE_GETSIGINFO, pid, 0,&si);
>>>> +
>>>
>>> Doesn't this leak the host siginfo_t into the guest?
>>>
>>
>>
>> Docs for PTRACE_GETSIGINFO say `si' gets a copy. After that, `si' is not=
 used for anything other than giving it to the guest. But I really can't sa=
y I
>> understand the surrounding code too well so please review carefully :)
>
> I was not talking about a memory leak.
> What I meant was a information leak.
> Using the host siginfo_t a guest process may get it's UID, PID, memory lo=
cation, etc... on the host side.
>


Oh, darn, indeed. Well, getting si_code right fixed my immediate =

problem, but I might look at this again some time next week unless =

you've fixed it yourself by then. Thanks!


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

