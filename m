Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vLAk-0001TA-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 11:19:02 -0700
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19vLAj-0003CP-Mc
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 11:19:01 -0700
Received: from 216-15-124-77.c3-0.smr-ubr3.sbo-smr.ma.cable.rcn.com ([216.15.124.77] helo=mizar.alcor.net)
	by smtp01.mrf.mail.rcn.net with esmtp (Exim 3.35 #4)
	id 19vLAi-0006bQ-00
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 14:19:00 -0400
Received: from mdz by mizar.alcor.net with local (Exim 3.36 #1 (Debian))
	id 19vLAi-0000LE-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 14:19:00 -0400
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] hostfs as root
Message-ID: <20030905181900.GV11825@alcor.net>
References: <19654.193.212.97.12.1062774897.squirrel@pluto.nixia.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19654.193.212.97.12.1062774897.squirrel@pluto.nixia.no>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 5 Sep 2003 14:19:00 -0400
To: user-mode-linux-devel@lists.sourceforge.net

On Fri, Sep 05, 2003 at 05:14:57PM +0200, stian@nixia.no wrote:

> The problem occurs when you create a file you are later not allowed to
> open if I'm seeing this right, so, the best fix would be not to close the
> file when we create them in the first place. Fix the behavour that we
> 
> create file
> close file
> open file again
> do action
> 
> If that is redone till
> 
> create file
> do action
> 
> 
> The mode issue goes pretty much away, since trying to open a file you are
> not allowed to read will normally fail both in host and uml. Only problem
> is when creating new files as far as I can see.
> 
> 
> Might be more job, but the result is more cleaner than than chmod stuff on
> the fly.

That is what the original bug was, and that is how it was fixed.  Michael's
problem is that mount(8) creates a file with mode 0, closes it, and then
tries to open it.

-- 
 - mdz


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
