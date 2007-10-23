Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IkRPx-0003o6-Tl for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Oct 2007 14:36:06 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IkRPw-0002QS-NT
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Oct 2007 14:36:05 -0700
Date: Tue, 23 Oct 2007 17:35:45 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071023213545.GA11026@c2.user-mode-linux.org>
References: <1f154f440710161936h4800b0c5nb3140ff504212625@mail.gmail.com>
	<20071017155504.GD9497@c2.user-mode-linux.org>
	<1f154f440710170916j4fdb857fw40c9b2fd2b66f63f@mail.gmail.com>
	<20071017171920.GA10388@c2.user-mode-linux.org>
	<1f154f440710171243x40898f8bq386c91c59789fb42@mail.gmail.com>
	<20071017204527.GB12812@c2.user-mode-linux.org>
	<1f154f440710171629meb5a3ces92b8fdeacc371857@mail.gmail.com>
	<20071018200432.GA9204@c2.user-mode-linux.org>
	<1f154f440710231221r76d63ec2h640e95c7afa05a6a@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1f154f440710231221r76d63ec2h640e95c7afa05a6a@mail.gmail.com>
Subject: Re: [uml-devel] Dramatic drop in C3 state residency with NO_HZ patches
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Hrishikesh <hrishikesh.amur@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Oct 23, 2007 at 04:21:03PM -0300, Hrishikesh wrote:
> Yes, that double negative was a slipup. I did get some numbers out and they
> look pretty good. I ran upto 5 instances of UML simultaneously and in the
> tickful case, each instance adds roughly about 100 wakeups per second. 

HZ == 100, so that makes sense.

> So
> after 5 instances, C3 residency comes down to about 95% when all the
> instances are simply idling. With NO_HZ applied, the change is minimal with
> C3 residency still approximately 98%. UML is not even among the top three of
> the bad-list of wakers-up :-)

Cool.  I'm suprised that 500 wakeups/sec only brings you down < 5%.

So, things are good, except I need to figure out the !NO_HZ busy loop.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
