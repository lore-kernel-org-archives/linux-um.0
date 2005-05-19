Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYl8A-0004yu-F2	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 May 2005 06:32:06 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DYl87-0006pn-G8	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 May 2005 06:32:06 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Question about the kernel thread in UML TT mode
References: <000c01c55c59$37dd1e50$9eb3c68a@SHZ.ST.COM>
In-Reply-To: <000c01c55c59$37dd1e50$9eb3c68a@SHZ.ST.COM>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505191531.31247.blaisorblade@yahoo.it>
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
Date: Thu, 19 May 2005 15:31:30 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Alex LIU <alex.liu@st.com>, 'Jeff Dike' <jdike@addtoit.com>

On Thursday 19 May 2005 11:57, Alex LIU wrote:
> On May 18, 2005 9:31 PM, Jeff wrote:
> >> But P and Q are different threads and they will be scheduled
> >> differently,right?

> > No, they're two different ways of looking at the same thread.  They're
> > scheduled somewhat differently, but that's just reflecting the two ways
> > of

> looking at it.  If it's runnable on the host, it's runnable inside UML, but
> not the other way around.

> Then how does the UML thread interact with its corresponding host thread in
> TT mode? Also use the switch_pipe?

> >> And in the function outer_tramp, the thread A see the thread B was
> >> stopped with a SIGSTOP signal. Why? Since the thread B is blocked by
> >> the signal SIGUSR1...

> > The handler calls suspend_new_thread, which stops itself.

> Exactly! I'm wrong...

> Then I have another question:

> In UML function new_thread_handler, the current sigcontext is defined as
> following:

> 	UPT_SC(&current->thread.regs.regs) = (void *) (&sig + 1);

> Why? What does "&sig + 1" mean?
I think that's because sig is on the stack, and &sig + 1 points to the datas 
saved by the kernel when entering the signal handler, i.e. the registers of 
the caller, saved to be restored on return.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
