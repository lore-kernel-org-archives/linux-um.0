Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vOQl-0005L4-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 14:47:47 -0700
Received: from h-66-166-78-130.snvacaid.covad.net ([66.166.78.130] helo=TerraLuna.Org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19vOQd-0008C9-Tu
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 14:47:40 -0700
Subject: Re: [uml-devel] SKAS: Why pass mm vs. current?
Message-ID: <20030905214737.GF1601@pathfinder>
References: <20030905020623.GA1601@pathfinder> <200309052012.h85KCojh001348@ccure.karaya.com> <20030905210818.GE1601@pathfinder> <1062797281.23069.46.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062797281.23069.46.camel@serpentine.internal.keyresearch.com>
From: stevegt@TerraLuna.Org
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
Date: Fri, 5 Sep 2003 14:47:37 -0700
To: Bryan O'Sullivan <bos@keyresearch.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Sep 05, 2003 at 02:28:01PM -0700, Bryan O'Sullivan wrote:
> On Fri, 2003-09-05 at 14:08, stevegt@TerraLuna.Org wrote:
> 
> > But why not get mm from current when needed deeper down, rather than
> > pass it in the first place?  That would avoid having to change the
> > interface.
> 
> That's what the 2.6 host-skas patch already does.  Remember, the
> host-skas3 patch is a quickish hack to get the needed functionality, not
> an interface change frozen in stone.

So that sounds like it answers one of my first questions -- there's
actually no special context that needs to be preserved down through the
call stack, so neither mm nor current need to be explicitly passed at
all?  I.E.  the global current is still current all the way down?  I was
beginning to suspect that there was something about UML's interaction
with the host that made current not be valid deeper down.

If I fix this by creating a new patch, can we post it as skas3.1 or
something?  It looks like it would satisfy a lot of people's problem
with the interface change on 2.4 kernels.

Steve
-- 
Steve Traugott  (KG6HDQ)
Speaker Coordinator, Silicon Valley Linux Users Group
http://www.svlug.org
--
UNIX/Linux Infrastructure Architect, TerraLuna LLC
stevegt@TerraLuna.Org   
http://www.stevegt.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
