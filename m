Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dt1RZ-0005BK-J0	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 03:59:53 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1Dt1RZ-0004Hr-7Y	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 03:59:53 -0700
Message-ID: <42D6459B.6080702@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Am I doing something wrong with -skas0?
References: <200507122346.40320.rob@landley.net>
	<42D504D8.1010606@fujitsu-siemens.com> <200507131647.53822.rob@landley.net>
In-Reply-To: <200507131647.53822.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Thu, 14 Jul 2005 12:59:39 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net

Rob Landley wrote:
> On Wednesday 13 July 2005 07:11, Bodo Stroesser wrote:
> 
>>Rob Landley wrote:
>>
>>>Am I doing it right?  Is there anything I can do to help track this down?
>>>
>>>Rob
>>
>>The value of EIP reported in your earlier mail is quite surprising.
>>Could you please "objdump" vmlinux and send the part of
>>"stub_segv_handler"?
>>
>> Bodo
> 
> 
> I'm guessing you want objdump -d, and here's stub_segv_handler from that:
> 
> 081020b0 <stub_segv_handler>:
>  81020b0:       8b 44 24 5c             mov    0x5c(%esp),%eax
>  81020b4:       a3 04 f0 ff bf          mov    %eax,0xbffff004
>  81020b9:       8b 44 24 3c             mov    0x3c(%esp),%eax
>  81020bd:       a3 00 f0 ff bf          mov    %eax,0xbffff000
>  81020c2:       8b 44 24 38             mov    0x38(%esp),%eax
>  81020c6:       a3 08 f0 ff bf          mov    %eax,0xbffff008
>  81020cb:       b8 14 00 00 00          mov    $0x14,%eax
>  81020d0:       cd 80                   int    $0x80
>  81020d2:       89 c3                   mov    %eax,%ebx
>  81020d4:       b8 25 00 00 00          mov    $0x25,%eax
>  81020d9:       b9 0a 00 00 00          mov    $0xa,%ecx
>  81020de:       cd 80                   int    $0x80
>  81020e0:       58                      pop    %eax
>  81020e1:       58                      pop    %eax
>  81020e2:       58                      pop    %eax
>  81020e3:       b8 77 00 00 00          mov    $0x77,%eax
>  81020e8:       cd 80                   int    $0x80
>  81020ea:       c3                      ret
> 
> Rob
Hi Jeff,

stub_segv_handler misses the "push ebp" at the beginning. As you
do the normally corresponding "pop eax" explicitly, I think stack
pointer is wrong on call of sigreturn.

I have no idea, what makes happen this. Maybe it depends on compiler
version?

	Bodo

P.S.:
Normally, stub_segv_handler should look like this:

a02090d0 <stub_segv_handler>:
a02090d0:       55                      push   %ebp
a02090d1:       89 e5                   mov    %esp,%ebp
a02090d3:       8b 45 60                mov    0x60(%ebp),%eax
a02090d6:       a3 04 f0 ff bf          mov    %eax,0xbffff004
a02090db:       8b 45 40                mov    0x40(%ebp),%eax
a02090de:       a3 00 f0 ff bf          mov    %eax,0xbffff000
a02090e3:       8b 45 3c                mov    0x3c(%ebp),%eax
a02090e6:       a3 08 f0 ff bf          mov    %eax,0xbffff008
a02090eb:       b8 14 00 00 00          mov    $0x14,%eax
a02090f0:       cd 80                   int    $0x80
a02090f2:       89 c3                   mov    %eax,%ebx
a02090f4:       b8 25 00 00 00          mov    $0x25,%eax
a02090f9:       b9 0a 00 00 00          mov    $0xa,%ecx
a02090fe:       cd 80                   int    $0x80
a0209100:       58                      pop    %eax
a0209101:       58                      pop    %eax
a0209102:       58                      pop    %eax
a0209103:       b8 77 00 00 00          mov    $0x77,%eax
a0209108:       cd 80                   int    $0x80
a020910a:       5d                      pop    %ebp
a020910b:       c3                      ret


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
