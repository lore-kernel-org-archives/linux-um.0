Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKqi5-00033i-1Q for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 21:07:25 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CKqi3-0002wb-KB
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 21:07:24 -0700
Message-Id: <200410220516.i9M5GwFL007932@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] What to send to Andrew next
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
Date: Fri, 22 Oct 2004 01:16:58 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

We've pretty much got -mm and -linus caught up with the updates that had been
sitting around.

At this point, my patch list is a mix of things that both are and aren't ready
for prime time.  So, I'd like opinions on what's ready.

The names below are the ones at 
	http://user-mode-linux.sourceforge.net/patches.html

Here's my take on it:

Ready -
	catch_eintr_generic_console_write
	fix-some-warnings - some things left over from your patch
	need-bash - I changed the comment :-)
	syscall-returns - the start of the x86_64 stuff, this one cleans up
int -> long declarations in the system calls
	type-sizes - ditto for some other types
	syscalls - factors the system calls between generic and arch-specific
a bit better, I consider this safe because you can look at sys_call_table before
and after and see that they're the same
	tmp-exec
	defconfig
	smp-link
	fix-ptrace-interfaces - straightforward interface fixes
	no-chans - makes sure something hits the screen when someone makes
a bogus config
	no-timestamp
	comments

Uncertain -
	use-va_end - looks good to me, but have you figured out why it causes
crashes?
	export-Symbols - I need to look at that phys_t change, which doesn't
belong there
	Single_Linking_Step - leftovers, build linux, add archhelp, you
sent something like this to Andrew, so this may be essentially already there
	do_signal and the rest of Bodo's fixes - I want his test cases before
I send these anywhere, although the ones that make UML look like the other
arches might be OK.

Dangerous -
	3-level-pagetables and the rest of the x86_64 stuff

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
