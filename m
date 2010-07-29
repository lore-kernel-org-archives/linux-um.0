Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ratheesh.ksz@gmail.com>) id 1OeIUQ-0007Jh-83
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jul 2010 02:04:54 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OeIUP-0008Ff-Fm for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jul 2010 02:04:54 +0000
Received: by iwn34 with SMTP id 34so58399iwn.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 28 Jul 2010 19:04:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100728184956.GA25818@c-98-229-117-200.hsd1.ma.comcast.net>
References: <AANLkTi=VnBo4uZ6UUd7WZoKYY1M2D2+YaaX9+wKmNXaK@mail.gmail.com>
	<20100728184956.GA25818@c-98-229-117-200.hsd1.ma.comcast.net>
Date: Thu, 29 Jul 2010 07:34:48 +0530
Message-ID: <AANLkTimg9p_kVZvDtAkn4W5xBjJXn4GwZXAdPZzfg5jV@mail.gmail.com>
From: ratheesh k <ratheesh.ksz@gmail.com>
Subject: Re: [uml-devel] reading heap memory in kernel space .
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Jul 29, 2010 at 12:19 AM, Jeff Dike <jdike@addtoit.com> wrote:
> Why do you want a physical address?  It's useless to a debugger.

I agree .
I would like to know this .Could you help me .How do i find uml_physmem val=
ue ?

-Ratheesh

> On Wed, Jul 28, 2010 at 09:54:37PM +0530, ratheesh k wrote:
>> I have a simple user space program .
>>
>> char *ptr=3D(char *)malloc(100);
>> strcpy(ptr , "Hi Kernel =A0, How are you ");
>> .........
>> sendmsg(...)
>> ........
>>
>>
>> I compiled this program =A0and executed on 2.6.32 user mode linux .
>> when i run uml under gdb , i would like to read all memory location
>> staring from ptr .( whole string ) from kernel .
>> I have set some break points on some system calls ( sys_sendmsg ). gdb
>> will break there and if know ptr address , should i convert to
>> physical address space ? How will i do that ? how will i get
>> uml_physmem value ?
>
> Why do you want a physical address? =A0It's useless to a debugger.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Jeff
>
> --
> Work email - jdike at linux dot intel dot com
>

---------------------------------------------------------------------------=
---
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

