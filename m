Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Iibck-0006j4-IT for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Oct 2007 13:05:42 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Iibch-0005we-FC
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Oct 2007 13:05:42 -0700
Date: Thu, 18 Oct 2007 16:04:32 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071018200432.GA9204@c2.user-mode-linux.org>
References: <1f154f440710161936h4800b0c5nb3140ff504212625@mail.gmail.com>
	<20071017155504.GD9497@c2.user-mode-linux.org>
	<1f154f440710170916j4fdb857fw40c9b2fd2b66f63f@mail.gmail.com>
	<20071017171920.GA10388@c2.user-mode-linux.org>
	<1f154f440710171243x40898f8bq386c91c59789fb42@mail.gmail.com>
	<20071017204527.GB12812@c2.user-mode-linux.org>
	<1f154f440710171629meb5a3ces92b8fdeacc371857@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1f154f440710171629meb5a3ces92b8fdeacc371857@mail.gmail.com>
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

On Wed, Oct 17, 2007 at 07:29:47PM -0400, Hrishikesh wrote:
> No, I think I haven't been clear enough. The story is right :-) When it is
> "busy-looping" like in the second case is when the C3 residency comes down,
> as expected. Like you said, it looks broken, and has to be fixed.

Yes, your original post was a bit confusing:

> This happens when you run a
> patched kernel but without the NO_HZ and HR timers options disabled.

To my highly logical mind, that double-negative says that you saw the
C3 drop with NO_HZ and hrtimers enabled.

There was also this, which I paid insufficient attention to:

> This does not happen when the tickless option _is_ enabled.

However, it does look like the tickless support induces UML into a
busy loop when NO_HZ is disabled.

BTW, can you measure C3 time with a before-NO_HZ UML, so we can see
that NO_HZ has some sort of benefit on power consumption?

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
