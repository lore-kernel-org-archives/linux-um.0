Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B9FIX-0006z3-Tc for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 19:24:49 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1B9FIX-0006DE-8o
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 19:24:49 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Timer patch for 2.6
Message-ID: <20040402040124.GB5559@ccure.user-mode-linux.org>
References: <20040401181616.26d1fcb7.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401181616.26d1fcb7.zaitcev@redhat.com>
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
Date: Thu, 1 Apr 2004 23:01:24 -0500
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Apr 01, 2004 at 06:16:16PM -0800, Pete Zaitcev wrote:
> I was unable to verify that it actually works in UML. My UML seems to
> be hosed by a recent Fedora update, known good setups fail to work, too.
> So, I am posting this mainly for review. I am terribly confused by
> the way timers work in UML. In particular, it appears that every
> process has to set up a timer. 

In tt mode, each UML process gets a host process, the kernel is mapped
into each process, and it runs in each process.  That means that the
kernel switches host processes every time there's a context switch.
So, every process needs its own timer.

For this, what needs to happen is that, on every context switch, the 
timer has to be reset to fire at the appropriate time.  The switch
will happen some time in the middle of the interval, so the remaining
time needs to be calculated, and the timer for the new process set
accordingly.  The timer of the outgoing process can just be disabled.

Things are somewhat more sane in skas mode.  There are two processes -
kernel and user, and both need a timer.  However, there's a
complication.  The kernel process needs to be able to manipulate the
user process' timer, which would appear to call for another ptrace op
or something.

I haven't taken a good look at the patch yet.

Thanks for doing this...

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
