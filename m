Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CwwCV-0000eo-5z for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Feb 2005 21:40:15 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CwwCR-0000wd-Hy for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Feb 2005 21:40:15 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: uml-patch-2.4.27-1 not fixed Re: [uml-devel] 2.4.27 guest bug
	reconfirmed Re bug report [ 745826 ] run cat /dev/urandom
References: <418E5CA1.90308@praguespringpeople.org>
	<200411151821.11779.blaisorblade_spam@yahoo.it>
	<419A205F.7000107@praguespringpeople.org>
In-Reply-To: <419A205F.7000107@praguespringpeople.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502040639.20694.blaisorblade@yahoo.it>
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
Date: Fri, 4 Feb 2005 06:39:20 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Struan Bartlett <struan@praguespringpeople.org>

On Tuesday 16 November 2004 16:44, Struan Bartlett wrote:
> I've compiled and ran the test (below) on a virgin 2.4.27 kernel patched
> with uml-patch-2.4.27-1.bz2.
>
> Result: the bug is still readily reproducible and _is not fixed_ in this
> patch.

> P.S. Jeff Dike: if CONFIG_NETFILTER=y is set in .config, the patched
> kernel fails to compile.
This one was probably just a "clean-to-fix" bug.

Ok, I have just one more clue now (not the solution yet). The first problem 
was that I went searching for "scheduler fixes" from 2.6: well, I merged some 
more, but without success. So, I've looked again at the infamous line 564, 
and what I realized (don't ask me why I missed this last time) is that this 
BUG line:

        if (unlikely(in_interrupt())) {
                printk("Scheduling in interrupt\n");
                BUG();
        }
is triggered because of a bug in the urandom driver - which you use in both 
your reproducing methods. So, we are down to some bug related to code in 
urandom.c; since it works in mainline, I think the problem probably lies in 
code managing interrupts and / or timing (since they are related to random 
numbers generation).

Btw, I just got the same panic by simply running "cat /dev/urandom"!

> >>cat /dev/urandom

> >>The devastating symptom: within 5 seconds the guest kernel has paniced
> >>and exited with the message (below) "kernel BUG at sched.c:564!".

> >>_Conclusion_
> >>
> >>If such a simple pair of commands as this causes such devastating
> >>consequences, it seems the 2.4.27 kernel sched.c line 564 needs to be
> >>taken a look at - unless, that is, Jeff Dike's recent post about
> >>uml-patch-2.4.27-1 "a nasty scheduler race fixed" addresses this bug.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
