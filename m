Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E10cP-0001lE-KJ	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Aug 2005 04:44:05 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E10cO-0003R2-Cc
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Aug 2005 04:44:05 -0700
Message-ID: <42F350F9.5050306@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <42D7D802.2080100@fujitsu-siemens.com>
	<20050730155454.GA4585@ccure.user-mode-linux.org>
In-Reply-To: <20050730155454.GA4585@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Some changes in SKAS0
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
Date: Fri, 05 Aug 2005 13:43:53 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>, BlaisorBlade <blaisorblade_spam@yahoo.it>

Jeff Dike wrote:
>>  Thus I added SA_NOMASK to the flags for the handler.
> 
> 
> This patch causes sleep to hang sometimes for me.  A sleep during
> shutdown reproducably hangs, as does the sleep before a reboot after a
> fsck found errors.
> 
> I had to track it down by bisection.  I'm somewhat mystified by this.
> The only situation where this could cause a change in behavior is one
> that shouldn't happen, as far as I can see.
> 
> But it's definitely the cause.  Pop the patch, the hangs go away, push
> it, they come back.  I did this a couple times to be sure.
> 
> I'll debug this and figure out what's happening.
> 
> 				Jeff
> 
Could you already find out what happens? On what subarch did you see the problem?
If I understand correctly, a sleep() done by a UML userspace-task hangs?

	Bodo


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
