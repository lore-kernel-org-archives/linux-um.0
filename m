Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shane@hathawaymix.org>) id 1LP9Ea-0001rK-CT
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2009 05:33:08 +0000
Received: from out02.mta.xmission.com ([166.70.13.232])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LP9EW-0001aU-EI for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2009 05:33:08 +0000
Message-ID: <497561E8.9070902@hathawaymix.org>
Date: Mon, 19 Jan 2009 22:32:24 -0700
From: Shane Hathaway <shane@hathawaymix.org>
MIME-Version: 1.0
References: <49754AB5.3000701@hathawaymix.org>
	<20090120045959.GA18187@c2.user-mode-linux.org>
In-Reply-To: <20090120045959.GA18187@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [Patch] UML: spurious interrupt freezes guest
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
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> On Mon, Jan 19, 2009 at 08:53:25PM -0700, Shane Hathaway wrote:
>> A new instance of user mode linux that I created over the past couple of
>> days worked pretty well except that it had a habit of freezing after a
>> few minutes.  Every time it froze, the last message on the console was
>> either:
>>
>> spurious interrupt in ubd_handler, err = 4
> 
> What version and what's the workload?

I got the spurious interrupt with both Linux 2.6.28.1 and 2.6.27.12 as
guests.  The host runs 2.6.9-42.0.3.ELsmp.

I am putting OpenVPN and Asterisk inside the guest.  The guest is based
on Ubuntu 8.10.  The spurious interrupt happened more often when I
restricted the guest's RAM.  The processes in the guest normally consume
a total of about 20-24 MB of RAM.  I limited the guest's RAM to 48 MB
and gave it a 64 MB swap partition.  When I gave the guest only 32 MB,
the spurious interrupt seemed to happen more often.

The best way I found to trigger the spurious interrupt was to try to
"apt-get install" many packages at once.  The download would succeed,
but the guest would freeze partway through the install.

Shane

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
