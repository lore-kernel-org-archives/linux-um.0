Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AtyLD-0008Fy-4H
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 19 Feb 2004 16:16:27 -0800
Received: from [69.93.28.254] (helo=unix.easyadmin ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AtyFf-0003B4-TA
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 19 Feb 2004 16:10:43 -0800
Subject: Re: [uml-devel] Re: [discuss] UML and AMD-64
From: Matt Ayres <matta@tektonic.net>
In-Reply-To: <20040113175635.GE2673@jaa.iki.fi>
References: <E1AgMua-00075F-00@hermes.virtue>
	 <20040113175635.GE2673@jaa.iki.fi>
Content-Type: text/plain
Message-Id: <1077235841.8412.37.camel@wopr.tektonic.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Thu, 19 Feb 2004 19:10:41 -0500
To: Jani Averbach <jaa@jaa.iki.fi>
Cc: trb@categorical.net, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, discuss@x86-64.org, aj@suse.de

Did you use the skas3 patch?  My understand from looking at it is that
skas3 is written for i386 only, hence you would only be able to run a
32-bit kernel.  

On Tue, 2004-01-13 at 12:56, Jani Averbach wrote:
> On 2004-01-13 22:40+1100, Tim Barbour wrote:
> > I am wondering whether an AMD-64 box can host user-mode Linux. I know that an
> > AMD-64 system is supposed to be able to run 32-bit applications, but does that
> > extend as far as running a 32-bit UML virtual machine ?
> > 
> > Is there any possibility of running a 64-bit UML virtual machine on an AMD-64 ?
> > 
> 
> I have used an 32bit UML in my AMD64 (pure 64bit system). So it is
> doable. I can't remember any hiccups and installation was really
> straightforward.
> 
> BR, Jani
-- 
Matt Ayres <matta@tektonic.net>
TekTonic



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
