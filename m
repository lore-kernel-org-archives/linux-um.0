Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKaac-00083E-Ly	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 04:59:10 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EKaaa-0004vf-98
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 04:59:10 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] a question about sigsetjmp() in copy_from/to_user()
References: <3524bf1f050927070645b999bd@mail.gmail.com>
In-Reply-To: <3524bf1f050927070645b999bd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509281041.15953.blaisorblade@yahoo.it>
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
Date: Wed, 28 Sep 2005 10:41:15 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Young Koh <young.koh@gmail.com>

On Tuesday 27 September 2005 16:06, Young Koh wrote:
> Hi,

> i have a question about copy_from/to_user() implementation in skas mode.

Ok, and here I'll explain also about TT mode, since they're reasonably 
similar, and TT mode is more similar to i386.
> as my understanding,
> when copy_from/to_user() is  invoked, before the address translation
> happens, UML kernel calls sigsetjmp() to come back when there is a
> segmentation fault. and if there is, it seems that the system call an
> application triggered eventually returns EFAULT.
Yes, copy_*_user returns a failure code and the calling code is supposed to 
check and return EFAULT.

Assuming the fault is a *real* fault, i.e. an unfixable one - maybe we simply 
need to call handle_page_fault() and load the page from swap.
> then, it seems to me 
> that sigsetjmp() is to catch the error when the application gave the
> invalid user space address.
Exactly.
> my question is, if so, shouldn't the error be caught when UML kernel
> translates the user space address to the kernel space address? i mean,
> UML kernel must know the valid memory regions
Well, saying "regions" is a bit confusing - in fact, you are coping with 
installed mappings (mmap()s done on the host), which are like page tables 
(populated on fault).
> and if the address is 
> out of the valid regions, then it knows the address is invalid before
> UML tries to access the address.

> why should it use sigsetjmp() and let 
> a segfault occur?
In general, because it would be faster, because you must optimize for the fast 
path, when a segfault won't occur and predoing the checking 

1) Background: TT mode and i386 implementation. They can access the user 
address directly, so they do, and catch the error afterwards. Why? Because 
when we care for performance, the application will pass correct address. So 
it's better to optimize the performance of the fast path (correct address) 
than the one of the slow path. The hardware walking of page tables is faster 
than the software one (even due to TLBs, which are processor caches of page 
tables).

Whenever a fault occur, the i386 exception handler (see 
search_exception_tables() and 
grep ".section __ex_table" include/asm-i386/*)

and/or the TT mode fault catcher make copy_*_user return an error.

2) SKAS instead. SKAS is like 4G/4G on the host (it is actually a 3G/3G).

In SKAS mode, we actually walk the page tables, because we cannot access the 
host mapping - we're using a different mapping set.

In fact, what you see doesn't catch user space wrong addresses.

It catches kernelspace faulting addresses - which is legal to happen, because 
i386 implementation catches any fault, and doesn't make a distinction, and 
which happens, when you try to do things like "cat /dev/kmem" - you're trying 
to do copy_to_user(to, offset /* which is 0 */, size).

In fact, that sigsegjmp() was added back in 2.4.24-?um (IIRC) and then around 
~2.6.7-um after I and Jeff analyzed this.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
