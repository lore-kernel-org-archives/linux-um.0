Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATPio-0006ER-6x
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 10:03:02 -0800
Received: from osiris.silug.org ([64.240.156.225])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1ATPin-0002kz-LC
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 10:03:01 -0800
From: Steven Pritchard <steve@kspei.com>
Subject: Re: [uml-devel] [PATCH] Locking user-mode kernel RAM into host physical RAM
Message-ID: <20031208180250.GA7787@osiris.silug.org>
References: <200312081639.22888.matthew-list@bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312081639.22888.matthew-list@bytemark.co.uk>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 8 Dec 2003 12:02:50 -0600
To: Matthew Bloch <matthew-list@bytemark.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Dec 08, 2003 at 04:39:08PM +0000, Matthew Bloch wrote:
> I hope that it's obvious enough to warrant inclusion in the next release of 
> the UML patch; my only thought was whether instead of putting 
> setuid-requiring code into the kernel, mem= should accept a file descriptor 
> as an argument and have the memory mapping optionally done by an external 
> process.  This strikes me as a bit weird from most angles, but obviously it 
> allows isolation of code which needs root privileges, and would probably be 
> very little work to add to the filemap patch for this purpose.

I've long thought that it would be Really Nice if UML could do some
setup things (like this, chroot(), etc.) that need to be done as root
early on, then drop privileges and continue normally.

I once worked on a patch to add chroot() support, but, well, that
didn't go too well.  :-)  (Actually, it worked fine, but by the time
the kernel options were being parsed, there were already several
threads, meaning only the thread doing option parsing was chroot()'d.
Not quite what I intended...)

Steve
-- 
Steven Pritchard - K&S Pritchard Enterprises, Inc.
Email: steve@kspei.com             http://www.kspei.com/
Phone: (618)398-7360               Mobile: (618)567-7320


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
