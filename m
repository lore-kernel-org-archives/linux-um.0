Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <bharrosh@panasas.com>) id 1OujB2-0006PR-KJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2010 09:48:48 +0000
Received: from daytona.panasas.com ([67.152.220.89]
	helo=daytona.int.panasas.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OujB1-0001Od-OH for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Sep 2010 09:48:48 +0000
Message-ID: <4C8CA1F2.1060802@panasas.com>
Date: Sun, 12 Sep 2010 11:48:34 +0200
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <4C7C2DE4.3090203@iki.fi> <4C7E3715.2060803@panasas.com>
	<4C8C8291.2040303@iki.fi>
In-Reply-To: <4C8C8291.2040303@iki.fi>
Subject: Re: [uml-devel] UML development, anyone?
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
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: user-mode-linux-devel@lists.sourceforge.net

On 09/12/2010 09:34 AM, Sakari Ailus wrote:
>> - Please send a detailed bug report about that data corruption so someone
>>    can reproduce it. I'm not sure what block device you are using but it has
>>    a bug. If you have a good version 2.6.27 and a bad version 2.6.28. It should
>>    be easy to "git bisect" to the exact patch that broke the system, and should
>>    be easy to fix. (Tell me if you need help, it's easy really)
> 
> I did write about this back then but it seems no-one else had the same 
> problem. It's one thing to find it and the other to fix it. My wild 
> guess is that it's not a change to that actual driver that broke it.
> 

A "git bisect" should be the best way to find what exactly broke it. If it's
not the driver then fine, that will be found as well.
Can you reliably reproduce the data corruption? If yes then a git bisect should
be easy. Please try to see what you can do?

Thanks
Boaz

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

