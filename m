Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vNon-0000Xj-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 14:08:33 -0700
Received: from h-66-166-78-130.snvacaid.covad.net ([66.166.78.130] helo=TerraLuna.Org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19vNom-000315-DO
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 14:08:32 -0700
Subject: Re: [uml-devel] SKAS: Why pass mm vs. current?
Message-ID: <20030905210818.GE1601@pathfinder>
References: <20030905020623.GA1601@pathfinder> <200309052012.h85KCojh001348@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309052012.h85KCojh001348@ccure.karaya.com>
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
Date: Fri, 5 Sep 2003 14:08:19 -0700
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Sep 05, 2003 at 04:12:50PM -0400, Jeff Dike wrote:
> stevegt@TerraLuna.Org said:
> > I have a question about why the skas patch passes mm down through the
> > do_mmap* call tree.  Why not just use current->mm when needed, the way
> > the original kernel does?  Or, if there's a context issue, then why
> > not pass all of current as a task_struct pointer, instead of just
> > current->mm?
> 
> Because the only thing needed is the mm.  I don't like passing a lot of 
> information through an interface when only one piece of it is actually needed.

Makes sense.  

But why not get mm from current when needed deeper down, rather than
pass it in the first place?  That would avoid having to change the
interface.  I'm happy to put that patch together, if you don't see
anything wrong with the idea.

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
