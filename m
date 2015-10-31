Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1ZsbTo-0005Mt-S7
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 Oct 2015 19:06:20 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZsbTn-00026i-C0
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 31 Oct 2015 19:06:20 +0000
References: <1445416947-824802-1-git-send-email-aivanov@brocade.com>
	<562D236E.7020108@kot-begemot.co.uk> <562DFC90.9030308@nod.at>
	<5631BB4E.4010301@kot-begemot.co.uk>
	<CAFLxGvwDXWhw+mssT4quUaRC3DFAtRAGksmV-wuYrdzLWZEa0w@mail.gmail.com>
	<1446304232.3238.8.camel@m3y3r.de> <5634DAA4.70308@nod.at>
	<1446304594.3238.11.camel@m3y3r.de> <5634DC7B.3010707@nod.at>
	<1446305051.3238.13.camel@m3y3r.de> <5634DEAB.8090909@nod.at>
	<1446306242.3238.16.camel@m3y3r.de>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56351123.9020304@nod.at>
Date: Sat, 31 Oct 2015 20:06:11 +0100
MIME-Version: 1.0
In-Reply-To: <1446306242.3238.16.camel@m3y3r.de>
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
To: Thomas Meyer <thomas@m3y3r.de>, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Am 31.10.2015 um 16:44 schrieb Thomas Meyer:
> Am Samstag, den 31.10.2015, 16:30 +0100 schrieb Richard Weinberger:
>> Am 31.10.2015 um 16:24 schrieb Thomas Meyer:
>>> Am Samstag, den 31.10.2015, 16:21 +0100 schrieb Richard Weinberger:
>>>> Am 31.10.2015 um 16:16 schrieb Thomas Meyer:
>>>>> mhh. strange. I didn't see this behaviour on my machine, but my
>>>>> machine
>>>>> is a rare single core system so, likely a race condition while
>>>>> relaying
>>>>> the timer interrupt to the userspace process.
>>>>
>>>> Here I can trigger it by starting UML, logging in and waiting
>>>> ~5min.
>>>> Then i try to run "top" --> top hangs forever.
>>>>
>>>>> But I'm out of ideas how this could happen!
>>>>
>>>> Maybe some stupid timeslice over/underflow.
>>>>
>>>>> what happens when you send the hanging process a SIGVTALRM
>>>>> signal?
>>>>> does
>>>>> it proceed correctly?
>>>>
>>>> You mean sending SIGVTALRM to the UML host process?
>>>
>>> No, to the hanging userspace process, maybe the uml host process
>>> did
>>> receive a timer interrupt, but failed to relay this signal to the
>>> correct userspace process.
>>
>> Well, this is not what top expects and dies.
>>         signal 26 (VTALRM) was caught by top, please
>>         see http://www.debian.org/Bugs/Reporting
>>

This happens when i send the signal _within_ UML.
Of course, top terminates.

> So you did send a VTALARM in the UML system to the top process?
> When yes then this was a misunderstanding! I wanted you to send a
> SIGVTALRM on the uml host system to the hanging pid. does this resolve
> the hang?

I also sent SIGVTALRM to the hanging pid on the host side.
It did not help. :(

Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

