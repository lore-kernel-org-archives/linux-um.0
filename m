Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bharrosh@panasas.com>) id 1WJ6d9-0003Xc-Fh
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 19:28:27 +0000
Received: from natasha.panasas.com ([209.166.131.148])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WJ6d8-0003nT-Ni for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 19:28:27 +0000
Message-ID: <530F91D0.1020408@panasas.com>
Date: Thu, 27 Feb 2014 21:28:16 +0200
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <530F8C69.9080801@panasas.com> <530F908D.6090601@nod.at>
In-Reply-To: <530F908D.6090601@nod.at>
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

On 02/27/2014 09:22 PM, Richard Weinberger wrote:
> 
> 
> Am 27.02.2014 20:05, schrieb Boaz Harrosh:
>> Hi Richard, uml hackers
>>
>> Since some time my "echo t > /proc/sysrq-trigger" stopped producing the proper global back-traces for all Kernel threads.
>> All I get is:
> 
> I have an idea, do you see this regression starting with v3.12?
> 
> Thanks,
> //richard
> 

Yes. You are right since 3.12 Yes. 3.11 is like before. But please see my other mail
it has more info.

Thanks, sir
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

