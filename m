Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CL2ez-0004zT-1Q for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 09:53:01 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CL2ey-0002y0-7T for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 09:53:00 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] What to send to Andrew next
References: <200410220516.i9M5GwFL007932@ccure.user-mode-linux.org>
In-Reply-To: <200410220516.i9M5GwFL007932@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410221852.27232.blaisorblade_spam@yahoo.it>
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
Date: Fri, 22 Oct 2004 18:52:27 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Friday 22 October 2004 07:16, Jeff Dike wrote:
> We've pretty much got -mm and -linus caught up with the updates that had
> been sitting around.
Yes, our new development way is very effective.
> At this point, my patch list is a mix of things that both are and aren't
> ready for prime time.  So, I'd like opinions on what's ready.

> The names below are the ones at
> 	http://user-mode-linux.sourceforge.net/patches.html

> Here's my take on it:
>
> Ready -
> 	catch_eintr_generic_console_write
I changed slightly the comment:
               /* The terminal becomes a bit less raw, to handle \n also as
                * "Carriage Return", not only as "New Line".
And added:

Otherwise, the new
                * line won't start at the first column.*/

I'm sending it now.
> 	fix-some-warnings - some things left over from your patch
> 	need-bash - I changed the comment :-)
Both already applied.
> 	syscall-returns - the start of the x86_64 stuff, this one cleans up
> int -> long declarations in the system calls
> 	type-sizes - ditto for some other types

> 	syscalls - factors the system calls between generic and arch-specific
> a bit better, I consider this safe because you can look at sys_call_table
> before and after and see that they're the same
I think this is not needed for now - however, I'll write some script for doing 
the check by hand.

And why on x86_64 you do:
#define NR_syscalls 1024
?

> 	tmp-exec
Agreed
> 	defconfig
Probably outdated - I already updated the defconfig here and I'll merge that.
> 	smp-link
Agreed, but I added the same change to the dyn.lds.S script, so I'll send this 
myself. Don't answer "SKAS does not support SMP" - it does not hurt, so let's 
avoid fixing it only when we start SKAS + SMP support.

> 	fix-ptrace-interfaces - straightforward interface fixes
Yes, agreed.

> 	no-chans - makes sure something hits the screen when someone makes
> a bogus config
NO: But why does not the no_config prints a meaningful message? We could also 
insert some #error directives when nothing of this is selected.
When you select no Block Scheduler (no deadline, no CFQ, nothing...) you get a 
#error, in fact.

> 	no-timestamp
Ok.
> 	comments
Ok.

Missing at least:

irq-bits - needed for mainline updates at least since -bk4, but not complete.
Other stuff, which I have here:
-some stuff about SYSEMU support, coming from Bodo work, to fix bugs 
introduced by me/you/Laurent.
- some patches I already sent to the ML and to you to review, which got no 
answer. I want them reviewed, but you should give a look to your mails...

1) FOR INSTANCE, I sent the patch avoiding SIGPROF being touched by 
change_signals(). Why did not you bother at it?
2) copy_from_user_skas() does not make sense. When accessing the page tables, 
they would be happy to get some locking. If you want to take a look to the 
4G-4G patch from Ingo Molnar, which must do something identical, 

> Uncertain -
> 	use-va_end - looks good to me, but have you figured out why it causes
> crashes?
No, I'm busy with other work - SYSEMU. It will be sorted out before 2.6.10, 
however.

> 	export-Symbols - I need to look at that phys_t change, which doesn't
> belong there
Everything apart the "phys_t" change is already merged.

> 	Single_Linking_Step - leftovers, build linux, add archhelp, you
> sent something like this to Andrew, so this may be essentially already
> there

Yes, already in 2.6.9.

> do_signal and the rest of Bodo's fixes - I want his test cases before 
> I send these anywhere, although the ones that make UML look like the other
> arches might be OK.
Well, yes, but let's try to be fast on these. They are very good patches and 
fix also security problems.
> Dangerous -
> 	3-level-pagetables and the rest of the x86_64 stuff
Yes, it must wait.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
