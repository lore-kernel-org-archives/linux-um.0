Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A4iW5-0003Bo-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 01 Oct 2003 08:03:49 -0700
Received: from 101.24.177.216.inaddr.g4.net ([216.177.24.101] helo=sparrow.stearns.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A4iW4-0003nE-6X
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 01 Oct 2003 08:03:48 -0700
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Subject: Re: [uml-devel] Networking without tun/tap?
In-Reply-To: <20030930215459.GB18354@shell.blacknet.de>
Message-ID: <Pine.LNX.4.44.0310011102420.2280-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 1 Oct 2003 11:03:40 -0400 (EDT)
To: Goetz Bock <bock@blacknet.de>
Cc: ML-uml-devel <User-mode-linux-devel@lists.sourceforge.net>

Good morning, all,

On Tue, 30 Sep 2003, Goetz Bock wrote:

> > I like to install uml on a server running a 2.4.20 kernel but has no tun/tap
> > configured in. Module support is disabled. Is their any way to get virtual
> > networking running without rebooting the mashine? I have root access to the
> > server.
> That is definitely a uml-users question, but still:
> You can get the uml-switch/daemon networking to work, but than your
> uml's will be unable to access the real network. (you could also use the
> pcap driver)

	And, as a last option, I believe the slirp transport runs as a 
non-root userspace process on the host.
	Cheers,
	- Bill

---------------------------------------------------------------------------
        "Fear leads to anger. Anger leads to hate. Hate leads to using
Windows NT for mission-critical applications."  (What Yoda *meant* to
say)
        -- Devin L. Ganger
(Courtesy of James Wilkinson <jamesw@student.unsw.edu.au>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
Linux articles at:                         http://www.opensourcedigest.com
--------------------------------------------------------------------------



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
