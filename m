Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPRSL-0008Cg-M1 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 12:10:09 -0800
Received: from pimout2-ext.prodigy.net ([207.115.63.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPRSL-0002SL-0h for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 12:10:09 -0800
From: Chris Wedgwood <cw@f00f.org>
Subject: Re: [uml-devel] [PATCH] UML: Use PTRACE_KILL instead of SIGKILL to
	kill host-OS processes (take #2)
Message-ID: <20041103200930.GA10669@taniwha.stupidest.org>
References: <20041103113736.GA23041@taniwha.stupidest.org>
	<1099482457.16445.1.camel@imp.csi.cam.ac.uk>
	<20041103120829.GA23182@taniwha.stupidest.org>
	<200411032028.44376.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411032028.44376.blaisorblade_spam@yahoo.it>
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
Date: Wed, 3 Nov 2004 12:09:30 -0800
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>, Gerd Knorr <kraxel@bytesex.org>

On Wed, Nov 03, 2004 at 08:28:44PM +0100, Blaisorblade wrote:

> I'm going to test this.

please do

> I thought that Gerd Knorr patch (which I sent cc'ing LKML and most
> of you) already solved this (I actually modified that one, replacing
> his SIGCONT kill()ing with a PTRACE_KILL, but I did this in the
> places he identified).

it might, i'm going to check soon

what worries me is that two very different code paths might be fixing
the same problem which makes me think the flow of execution here is
very vague and needs cleaninng up

also, check your return values for errors --- i bet you will see
some.  os_kill_process has this problem too --- many invocations of it
are pointless and fail, especially those from relase_thread_tt (i need
to check the details here, this is all from memory and im getting old)

> I guess that old_pid should either already be dead there or going to
> die after a little, but I'm going to check (after I get UML to run
> in the current snapshot...)

it should build pretty close to as-is, if not let me know and i'll
sent you what i have


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
