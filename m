Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CxC1y-0005hZ-RS for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 14:34:26 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CxC1x-0002Pe-Bq for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 14:34:26 -0800
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20050204143917.1f9507cb.akpm@osdl.org>
In-Reply-To: <4203F40C.8040707@yahoo.com.au>
References: <42021E35.8050601@fujitsu-siemens.com>
	<4202C18F.5010605@yahoo.com.au>
	<42036C2C.5040503@fujitsu-siemens.com>
	<4203F40C.8040707@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Race condition in ptrace
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
Date: Fri, 4 Feb 2005 14:39:17 -0800
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: bstroesser@fujitsu-siemens.com, roland@redhat.com, jdike@addtoit.com, blaisorblade_spam@yahoo.it, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Bodo Stroesser wrote:
> > Nick Piggin wrote:
> > 
> >> Bodo Stroesser wrote:
> 
> >> I don't see how this could help because AFAIKS, child->saving is only
> >> set and cleared while the runqueue is locked. And the same runqueue lock
> >> is taken by wait_task_inactive.
> >>
> > 
> > Sorry, that not right. There are some routines called by sched(), that 
> > release
> > and reacquire the runqueue lock.
> > 
> 
> Oh yeah, it is the wake_sleeping_dependent / dependent_sleeper crap.
> Sorry, you are right. And that's definitely a bug in sched.c, because
> it breaks wait_task_inactive, as you've rightly observed.
> 
> Andrew, IMO this is another bug to hold 2.6.11 for.

Sure.  I wouldn't consider Bodo's patch to be the one to use though..


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
