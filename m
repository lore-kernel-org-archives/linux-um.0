Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bharrosh@panasas.com>) id 1Vn5Th-0005a6-Vu
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Dec 2013 11:46:22 +0000
Received: from natasha.panasas.com ([209.166.131.148])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vn5Th-000475-5t for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Dec 2013 11:46:21 +0000
Message-ID: <529B2182.7090006@panasas.com>
Date: Sun, 1 Dec 2013 13:46:10 +0200
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <529755F0.80509@panasas.com> <2225498.R88CYgz3JQ@sandpuppy>
In-Reply-To: <2225498.R88CYgz3JQ@sandpuppy>
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
Subject: Re: [uml-devel] x86_64 when mem > 384M loadable modules do not work
To: Richard Weinberger <richard@nod.at>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On 11/28/2013 06:09 PM, Richard Weinberger wrote:
> 
> Does the attached patch fix the issue?
> 

Yes it is good. I'm very grateful. With this I now am able
to fully stress the UML Fedora18 and almost not get stuck at all.

(stuckness is usually do to stressed system and allocation
 failing where Kernel would not cope, but an HW system would
 fail just the same)

> Thanks,
> //richard
> 

Thank you sir Richard. One very happy camper here
Boaz


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

