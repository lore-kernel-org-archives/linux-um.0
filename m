Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZdwT-0002lu-7R for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 16:35:57 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EZdwS-0005te-Ss
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 16:35:57 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Making UML Single Threader
References: <200511061723.32848.rob@landley.net>
	<200511080109.06999.rob@landley.net>
	<4A8812BF-70D2-451C-9E9F-4502ED468120@stanford.edu>
In-Reply-To: <4A8812BF-70D2-451C-9E9F-4502ED468120@stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511081835.47575.rob@landley.net>
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
Date: Tue, 8 Nov 2005 18:35:47 -0600
To: Can Sar <csar@stanford.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 08 November 2005 01:44, Can Sar wrote:
> > Why?
>
> Trust me, I wouldn't do this if it were not for a reason. I have no
> intention of marketing this as a general purpose alternative to
> Linux. It's to check Linux for errors.

I just don't understand your potential use case.  (I've seen some really weird 
things done in embedded systems, and done a few myself, but I don't 
understand what the advantage is here...)

> >> So I don't care about systemcall interception or anything like that,
> >
> > *blink*  *blink*
> >
> > Ok, you want user mode linux, but you don't want it to actually run
> > user
> > processes, nor do want it to be able to intercept system calls.
> >
> > Um...  What's left?
>
> The ability to call the kernel implementation of some system calls
> and then halt the kernel.

Ah!  So you want the ability to test some kernel code, printf the result, and 
exit.  Right.  (And a kernel module doesn't do this because...?)

Jeff was going to split out the scheduler and filesystem into shared libraries 
or some such.  He mentions it in his intermittent diary, among other places.  
(Check the April 22 entry, for example):
http://user-mode-linux.sourceforge.net/diary.html
Also projects mentions it towards the end:
http://user-mode-linux.sourceforge.net/projects.html

I haven't really followed that work because I never had a use for it.  If I 
had to chop out kernel functions to run standalone, I'd guess your best bet 
is probably reading through starting from main() (in arch/um/kernel/main.c) 
and seeing at what point it's initialized enough stuff that you can do what 
you want.  (Assuming you don't need to do I/O or handle interrupts, and are 
doing single processor, then your big worry is probably memory allocation?  
I'm guessing here.)

Rob

P.S. What on earth is CONFIG_CMDLINE_ON_HOST?  It doesn't seem to ever be set 
anywhere, by anything...


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
