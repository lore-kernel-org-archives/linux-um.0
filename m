Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZdoo-0002Vr-TR for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 16:28:02 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EZdon-0004XV-F7
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 16:28:02 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Making UML Single Threader
References: <200511061723.32848.rob@landley.net>
	<200511080109.06999.rob@landley.net>
	<20051108154618.GB4131@ccure.user-mode-linux.org>
In-Reply-To: <20051108154618.GB4131@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511081827.46640.rob@landley.net>
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
Date: Tue, 8 Nov 2005 18:27:46 -0600
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Can Sar <csar@stanford.edu>

On Tuesday 08 November 2005 09:46, Jeff Dike wrote:
> On Tue, Nov 08, 2005 at 01:09:06AM -0600, Rob Landley wrote:
> > > So I don't care about systemcall interception or anything like that,
> >
> > *blink*  *blink*
> >
> > Ok, you want user mode linux, but you don't want it to actually run user
> > processes, nor do want it to be able to intercept system calls.
> >
> > Um...  What's left?
>
> Only all of Linux.  It so happens that I want exactly the same thing for
> libUML, except I haven't had time to do anything about it.
>
> Try to think a little before calling someone's project dumb.

Sorry, wasn't trying to call it dumb.  (I linked to a similar patch for 
ripping out lots of "unnecessary" infrastructure, which Rik found dumb 
because there was really no advantage to removing it.  I should have 
clarified that _my_ question was "Why?".)

I didn't understand what he was trying to do.  (Hard to ponder implementing 
something if you don't know what it would do.)  A test harness for isolated 
kernel functions is something I can at least imagine...

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
