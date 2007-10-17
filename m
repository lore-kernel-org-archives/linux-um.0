Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IiFlr-0000uD-NO for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Oct 2007 13:45:39 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IiFlq-0006H7-4F
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Oct 2007 13:45:39 -0700
Date: Wed, 17 Oct 2007 16:45:27 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071017204527.GB12812@c2.user-mode-linux.org>
References: <1f154f440710161936h4800b0c5nb3140ff504212625@mail.gmail.com>
	<20071017155504.GD9497@c2.user-mode-linux.org>
	<1f154f440710170916j4fdb857fw40c9b2fd2b66f63f@mail.gmail.com>
	<20071017171920.GA10388@c2.user-mode-linux.org>
	<1f154f440710171243x40898f8bq386c91c59789fb42@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1f154f440710171243x40898f8bq386c91c59789fb42@mail.gmail.com>
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

On Wed, Oct 17, 2007 at 03:43:01PM -0400, Hrishikesh wrote:
> Ok the straces do seem to tell the story; they follow below:

Except they're telling the wrong story:

> for the case where is the kernel is patched and NO_HZ enabled,

> {it_interval={0, 0}, it_value={0, 91986}}) = 0
> nanosleep({0, 91986000}, {0, 91986000}) = 0

.1 sec

> {it_interval={0, 0}, it_value={0, 291955}}) = 0
> nanosleep({0, 291955000}, {0, 291955000}) = 0

.3 sec

> {it_interval={0, 0}, it_value={1, 701741}}) = 0
> nanosleep({1, 701741000}, {1, 701741000}) = 0

1.7 sec

> for the case where the kernel is patched, but NO_HZ is __not__ enabled,
> there is a do_nanosleep() every 100 or so us.
> 
> setitimer(ITIMER_VIRTUAL, {it_interval={0, 0}, it_value={0, 0}},
> {it_interval={0, 0}, it_value={0, 0}}) = 0
> nanosleep({0, 0}, {0, 0})               = 0

This actually looks very broken - it's sleeping for no time,
practically a busy-loop.  And this case is keeping the host in C3
longer than the second-long sleeps in the first case?

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
