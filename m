Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPvsQ-0004ym-B5 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Nov 2004 20:39:06 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CPvsM-0004i0-D4
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Nov 2004 20:39:06 -0800
Message-Id: <200411050548.iA55m4DZ007773@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: [patch 09/20] uml: use SIG_IGN for empty
	sighandler 
In-Reply-To: Your message of "Thu, 04 Nov 2004 05:11:44 +0100."
	<200411040511.54892.blaisorblade_spam@yahoo.it> 
References: <20041103231735.8C1E955C79@zion.localdomain>
	<200411040451.iA44pJ5G012816@ccure.user-mode-linux.org>
	<200411040511.54892.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Fri, 05 Nov 2004 00:48:04 -0500
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org, linux-kernel@vger.kernel.org, cw@f00f.org

blaisorblade_spam@yahoo.it said:
> I had a doubt on this, but I was not getting much feedback from you...
Yeah, sorry.

> Also, if you reject this, I'd require a comment-only patch for it: "as
> soon as I remember why" makes me think back to my yesterday's class,
> when  the teacher said "put comments in your code or you'll soon
> forget what it  does!" 8-O (yes, 1st year University student :-( ). 

The thing is, you often don't realize what's going to be mysterious until it 
actually is, and then it's too late for the comment :-)

In this case, it wants to be bounced out of sigprocmask when a SIGWINCH 
arrives.  In order to do so, it must have a handler registered, even if
it does nothing.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
