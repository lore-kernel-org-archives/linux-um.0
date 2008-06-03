Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K3cnd-0004YV-Ow for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 13:08:06 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K3cnc-00054R-DO
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2008 13:08:05 -0700
Date: Tue, 3 Jun 2008 13:07:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20080603130709.fcf6a751.akpm@linux-foundation.org>
In-Reply-To: <878wxmfg99.fsf@hades.wkstn.nix>
References: <20080603190235.GA9511@c2.user-mode-linux.org>
	<20080603123211.e129c222.akpm@linux-foundation.org>
	<200806031543.56864.dhazelton@enter.net>
	<878wxmfg99.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 1/6] UML - Deal with host time going backwards
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Nix <nix@esperi.org.uk>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, dhazelton@enter.net

On Tue, 03 Jun 2008 20:52:18 +0100
Nix <nix@esperi.org.uk> wrote:

> On 3 Jun 2008, Daniel Hazelton said:
> 
> > On Tuesday 03 June 2008 03:32:11 pm Andrew Morton wrote:
> >> On Tue, 3 Jun 2008 15:02:35 -0400
> >>
> >> Jeff Dike <jdike@addtoit.com> wrote:
> >> > Protection against the host's time going backwards - keep track of the
> >> > time at the last tick and if it's greater than the current time, keep
> >> > time stopped until the host catches up.
> >>
> >> Strange.  What would cause the host's time (or at least UML's perception
> >> of it) to go backwards?
> >
> > A wild guess would be that the UML process is running "fast" at some point and 
> > its expectation of the host's time is skewed forward because of that.
> 
> Quite so. Simply running ntp on the host (in slew-only mode, no less!) 
> can cause this.
> 
> > Another possibility is that the hosts clock got reset between the times UML 
> > has checked it and the correction was a negative one.
> 
> That too.
> 

So if I change the host's time by an hour, the time will not advance at all
on the guest for the next hour? Sounds suboptimal :)

I suppose the guest should be running an ntp client synced to something
sane anyway?

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
