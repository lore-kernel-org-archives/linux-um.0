Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <inguin@gmx.de>) id 1Lx1xR-0008Ae-I1
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Apr 2009 16:39:29 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 29vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1Lx1xI-0001iq-7J for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Apr 2009 16:39:29 +0000
Message-ID: <49F099A2.5070408@gmx.de>
Date: Thu, 23 Apr 2009 18:38:58 +0200
From: Ingo van Lil <inguin@gmx.de>
MIME-Version: 1.0
References: <20090418154021.GA14617@ivl.dyndns.org>
	<20090423160659.GD9820@c2.user-mode-linux.org>
In-Reply-To: <20090423160659.GD9820@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [Patch] Save FPU registers between task switches
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:

>> some time ago Jeff prepared a patch [1] for UML to stop saving the
>> process FP state between task switches. The assumption was that since
>> with SKAS0 every guest process runs inside a host process context the
>> host OS will take care of keeping the proper FP state. Unfortunately
>> this is not true for multi-threaded applications, where all guest
>> threads share a single host process context yet all may use the FPU on
>> their own. Although I haven't verified it I suspect things to be even
>> worse in SKAS3 mode where all guest processes run inside a single host
>> process.
> 
> This seems plausible.  Does reverting the patch fix any process crashes?

Hi Jeff,

the tiny test program I posted a few weeks ago [1] reproducibly crashes 
after a few seconds without the patch. Additionally I've been running 
UML with the patch for about a week now and I haven't seen the 
occasional erratic results that lead me to investigate the issue since then.

I've never been using the SKAS3 patch, so I cannot comment on that. I 
had hoped that Stanislav Meduna could try whether the patch fixes the 
problems he reported last September [2].

Regards,
Ingo

[1] http://marc.info/?l=user-mode-linux-devel&m=123912656515459&w=2
[2] http://marc.info/?l=user-mode-linux-devel&m=121819897821728&w=2

------------------------------------------------------------------------------
Stay on top of everything new and different, both inside and 
around Java (TM) technology - register by April 22, and save
$200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
300 plus technical and hands-on sessions. Register today. 
Use priority code J9JMT32. http://p.sf.net/sfu/p
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

