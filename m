Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JxRmJ-0000ec-JD for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 May 2008 12:09:12 -0700
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JxRmI-0003VV-Sd
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 May 2008 12:09:11 -0700
From: Rob Landley <rob@landley.net>
Date: Sat, 17 May 2008 14:08:51 -0500
References: <200805031518.11029.rob@landley.net>
	<20080509152217.GF10169@c2.user-mode-linux.org>
In-Reply-To: <20080509152217.GF10169@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200805171408.51880.rob@landley.net>
Subject: Re: [uml-devel] =?iso-8859-1?q?=5BPATCH=5D_make_quiet_suppress_parse?=
	=?iso-8859-1?q?=5Fchan=5Fpair_boot=09messages?=
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Friday 09 May 2008 10:22:17 Jeff Dike wrote:
> On Sat, May 03, 2008 at 03:18:10PM -0500, Rob Landley wrote:
> > I usually use UML as a better fakeroot, meaning I run it with a command
> > line like "rootfstype=hostfs rw quiet
> > init=/path/to/some_shell_script.sh".  In this context, filling the screen
> > with parse_chan_pair error messages which don't actually hurt anything
> > defeats the purpose of "quiet".
> >
> > The patch turns several KERN_ERR into KERN_WARNING.  While I was there, I
> > merged the redundant printk() statements into a function, and added one
> > "else" after a test-for-null that did a printk but didn't do a continue.
>
> Looks reasonable.

Do I have to do anything to follow up, or is it queued to go upstream?  (I can 
redo the printk() with pr_warning(), it's just the original didn't and I 
didn't change it...)

Rob
-- 
"One of my most productive days was throwing away 1000 lines of code."
  - Ken Thompson.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
