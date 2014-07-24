Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Thu, 24 Jul 2014 16:16:18 +0800
From: Real Name <enjoymindful@gmail.com>
Message-ID: <20140724081618.GA1797@name>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] gprof missing functions
To: binutils@sourceware.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

hi,
  When trace the UML linux kernel with gprof, it seems gprof missing some
functions.

There are new_thread_handler and fork_handler in "arch/um/kernel/process.c".
gprof catchs the new_thread_handler function, but there is no sign about
fork_handler. Because the two functions are in the same file, so it is not
kernel configuration issue. I'm sure the two functions have been executed.

And new_thread_handler call a few functions, such as, kernel_init and kthreadd.
gprof catch kthreadd but missing kernel_init. I traced the UML kernel with gdb,
so I'm sure kernel_init called by new_thread_handler.

I search with google, but failed to get useful information about gprof missing
function issue. Is there any clue/suggestion how to make gprof catch all functions?

thanks

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

