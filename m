Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYIwX-0007kg-DP
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 21:49:25 -0800
Received: from nevyn.them.org ([66.93.172.17] ident=Debian-exim)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.24)
	id 1AYIwX-0003DA-0N
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 21:49:25 -0800
From: Daniel Jacobowitz <dan@debian.org>
Subject: Re: [uml-devel] 2.4.22-[67] problems
Message-ID: <20031222054914.GA8813@nevyn.them.org>
References: <20031220011323.GW18100@alcor.net> <20031220171450.GB10692@ccure.user-mode-linux.org> <20031221004742.GE9354@alcor.net> <200312211658.44353.blaisorblade_spam@yahoo.it> <20031221224001.GO9354@alcor.net> <20031221231638.GR9354@alcor.net> <200312220025.hBM0PlFI012918@ccure.user-mode-linux.org> <20031222040857.GV9354@alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031222040857.GV9354@alcor.net>
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
Date: Mon, 22 Dec 2003 00:49:14 -0500
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, 224431@bugs.debian.org, 224502@bugs.debian.org, debian-glibc@lists.debian.org

On Sun, Dec 21, 2003 at 08:08:57PM -0800, Matt Zimmerman wrote:
> On Sun, Dec 21, 2003 at 07:25:47PM -0500, Jeff Dike wrote:
> 
> > mdz@debian.org said:
> > > I have just verified this myself.  Building user-mode-linux
> > > 2.4.22-7um-1 on woody works fine (even when running on unstable), but
> > > building it on unstable does not.
> > 
> > Conversely, does a unstable-built UML run on woody?
> 
> The unstable-built UML is broken on woody as well.  So far, my most
> reproducible test case so far (not 100%, but close) is to start up a netcat
> listener, and connect to it with input from /dev/zero, i.e. just push a
> bunch of data over a TCP connection.  What happens is this:

...

Matt, could you try with different compilers?  This sounds a lot more
to me like a compiler bug than a libc one (but that's just a hunch).

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
