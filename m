Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXmPi-0006KX-M0
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 20 Dec 2003 11:05:22 -0800
Received: from userbb201.dsl.pipex.com ([62.190.241.201] helo=irishsea.home.craig-wood.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AXmPi-0007PG-9L
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 20 Dec 2003 11:05:22 -0800
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Subject: Re: [uml-devel] 2.4.22-[67] problems
Message-ID: <20031220190519.GA25646@axis.demon.co.uk>
References: <20031220011323.GW18100@alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031220011323.GW18100@alcor.net>
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
Date: Sat, 20 Dec 2003 19:05:19 +0000
To: user-mode-linux-devel@lists.sourceforge.net, 224431@bugs.debian.org, 224502@bugs.debian.org

On Fri, Dec 19, 2003 at 05:13:23PM -0800, Matt Zimmerman wrote:
> There definitely seems to be something awry here, even in skas mode.
> I am getting a lot of ENOSYS errors inside UML:

FYI I had no end of trouble building 2.4.22-7 with Debian testing
(with gcc 2-95).  I got it to compile OK (with lots of warnings), but
I couldn't get it to run reliably.

I've changed to building it in a woody chroot and it runs perfectly
now!

> 2. CONFIG_UML_REAL_TIME_CLOCK=y was added to the configuration

Watch out if running on > 2 GHz CPU - see list archives for patch the
UML will hang quite early on.

Sorry not a very scientific report!

-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
