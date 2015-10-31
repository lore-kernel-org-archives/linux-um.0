Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1ZsXqp-0003aR-9n
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 Oct 2015 15:13:51 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZsXqn-0001UB-Bg
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 Oct 2015 15:13:51 +0000
References: <1445416947-824802-1-git-send-email-aivanov@brocade.com>
	<562D236E.7020108@kot-begemot.co.uk> <562DFC90.9030308@nod.at>
	<5631BB4E.4010301@kot-begemot.co.uk>
	<CAFLxGvwDXWhw+mssT4quUaRC3DFAtRAGksmV-wuYrdzLWZEa0w@mail.gmail.com>
	<1446304232.3238.8.camel@m3y3r.de>
From: Richard Weinberger <richard@nod.at>
Message-ID: <5634DAA4.70308@nod.at>
Date: Sat, 31 Oct 2015 16:13:40 +0100
MIME-Version: 1.0
In-Reply-To: <1446304232.3238.8.camel@m3y3r.de>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH v3] um: Switch clocksource to hrtimers
To: Thomas Meyer <thomas@m3y3r.de>, Richard Weinberger <richard.weinberger@gmail.com>, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Am 31.10.2015 um 16:10 schrieb Thomas Meyer:
> Am Samstag, den 31.10.2015, 14:54 +0100 schrieb Richard Weinberger:
>> On Thu, Oct 29, 2015 at 7:23 AM, Anton Ivanov
>> <anton.ivanov@kot-begemot.co.uk> wrote:
>>> I got the first patchset to build, it works very well on a single
>>> core
>>> host or with CPU pinning of the UML - the performance gain is >
>>> 25%.
>>>
>>> However, I introduced a race somewhere along the way - it crashes
>>> UML
>>> reliably if you do not pin CPUs.
>>
>> How does the crash look like?
>> I see also an issue with that patch, after UML has an uptime of a few
>> minutes
>> a task which does nanosleep() will never wake up.
>>
>> [<000000006001a29d>] __switch_to+0x53/0x82
>> [<00000000602995d2>] __schedule+0x2f4/0x3f7
>> [<0000000060299751>] schedule+0x7c/0x95
>> [<000000006029b871>] do_nanosleep+0x8b/0x134
>> [<0000000060068a41>] hrtimer_nanosleep+0xb2/0x15a
>> [<0000000060068b90>] SyS_nanosleep+0xa7/0xbf
>> [<000000006001d492>] handle_syscall+0x6a/0x84
>> [<00000000600304a8>] userspace+0x3d8/0x463
>> [<000000006001a180>] fork_handler+0x85/0x87
>> [<ffffffffffffffff>] 0xffffffffffffffff
>>
> 
> Hi, 
> 
> is this crash/hang about the "switch clocksource to hrtimers" patch or
> about the next patch that improves UBD improvements?

Whoops. Forgot to mention. "switch clocksource to hrtimers" is the bad one.
So far I can trigger the issue only by starting UML and waiting some time.

Thanks,
//richard


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

