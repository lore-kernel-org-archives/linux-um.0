Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DgSSf-0004Dt-Vp	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 12:13:05 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DgSSc-0007dT-8L	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 12:13:03 -0700
Subject: Re: [uml-devel] 2.6.12-rc6-mm1 patches testing
From: antoine <antoine@nagafix.co.uk>
In-Reply-To: <200506091917.48234.blaisorblade@yahoo.it>
References: <1118280325.10107.124.camel@localhost>
	<1118336009.10190.74.camel@localhost>
	<200506091917.48234.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1118345008.10190.145.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Thu, 09 Jun 2005 20:23:28 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, 2005-06-09 at 19:17 +0200, Blaisorblade wrote:
> On Thursday 09 June 2005 18:53, antoine wrote:
> > On Thu, 2005-06-09 at 17:31 +0100, antoine wrote:
> > > > > Now, if someone could have a look at hppfs I could resurect my
> > > > > honeypots.
> > > >
> > > > I've not the time, however test the attached patches. The first one
> > > > fixes the basical bugs; the second one could be needed to fix a fd
> > > > leak... but I don't think it's needed at all, so test with only the
> > > > first and let me know if the 2nd is needed, or if there are any
> > > > problems (in that case, a ready-to-use hppfs configuration +
> > > > explaination would be happily accepted, I've really little time now).
> > >
> > > Works fine with just the first patch. Thank you very much!
> >
> > Small correction: local file override works fine (files in the host's
> > fake proc appear in the guest's /proc)
> That is allowed, too? The daemon uses normal files only to forcibly "remove" 
> entries, while it uses sockets for the rest.
AFAIK That has always been the case. I was using it to hardcode the
cpuinfo and cmdline shown in honeypots.

> Also, have you tested if it's the chroot and/or SELinux interacting? The 
> daemon communicates through a Unix domain socket when host contents are 
> supplied ... the base path is $ARGV[0], i.e. the first parameter...
Yep, I was running this instance outside of the chroot for now (because
of the libcap lib dependency) and not where the honeypot.pl expected it.
Also, the path was wrong chroot/proc/proc, 'lsof' showed me what I was
doing wrong, but it still isn't working as expected - more on this
later.

BTW, I copied /lib/libnss* to the chroot but the pcap interface does not
come up:
ifconfig eth1 0.0.0.0 promisc up
SIOCSIFFLAGS: No such device
SIOCSIFFLAGS: No such device
So something else must be missing... Any ideas?

Antoine



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
