Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bharrosh@panasas.com>) id 1WJ70J-0004eq-Aw
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 19:52:23 +0000
Received: from natasha.panasas.com ([209.166.131.148])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WJ70I-0005Vz-LE for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 19:52:23 +0000
Message-ID: <530F976C.2090400@panasas.com>
Date: Thu, 27 Feb 2014 21:52:12 +0200
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <530F8C69.9080801@panasas.com> <530F8F14.9050606@nod.at>
	<530F9126.2030206@panasas.com>
In-Reply-To: <530F9126.2030206@panasas.com>
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
Subject: Re: [uml-devel] sysreq t back traces stopped working please help
To: Richard Weinberger <richard@nod.at>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On 02/27/2014 09:25 PM, Boaz Harrosh wrote:
> On 02/27/2014 09:16 PM, Richard Weinberger wrote:
>> Hi!
>>
>> Am 27.02.2014 20:05, schrieb Boaz Harrosh:
>>> Hi Richard, uml hackers
>>>
>>> Since some time my "echo t > /proc/sysrq-trigger" stopped producing the proper global back-traces for all Kernel threads.
>>> All I get is:
>>
>> "some time" is a bit vague. Do you have more details?
>>
> 
> OK I've found my problem Da. It all goes to con0 and not at all to /var/log/messages (Fedora)
> I'll recheck my log levels I see in  code KERN_INFO so i do think it should appear but I'll
> recheck.
> 

OK I do not understand. I do see my KERN_DEBUG level at /var/log/messages
say from nfs.ko (dprintk) But I do not see these backtrace output at
/var/log/messages.

At con0 I see everything.

Thanks
Boaz


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

