Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKabt-00085v-Ao	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 05:00:29 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EKabr-0005Gg-UC
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 05:00:29 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509281346.23592.blaisorblade@yahoo.it>
Subject: [uml-devel] Clearing kmalloc_ok during shutdown is broken - malloc
	will clear our data.
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
Date: Wed, 28 Sep 2005 13:46:15 +0200
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

I've recently realized how potentially misguided that thing is.

And I am wondering about whether the recent "eactivate_all_fds failed, errno = 
9" (no, the initial "d" never comes out) may be due to this. Even if, now I 
see that was done even before... but first only on TT mode, then also in SKAS 
mode with commit 6770cb61ff6d557613a8382b28f9b0a919fb112f, which says "when 
getting a fatal signal".

But still, Jeff, how can we expect that malloc won't stomp over all our data 
which we preallocated with kmalloc and such?

There's no single mention of that in your original changelog, and this is 
untrivial, so I can assume you didn't realize this issue.

The git commit is 026549d28469f7d4ca7e5a4707f0d2dc4f2c164c.

On the other side, could you explain why you don't like kmalloc in first 
place? It surely works.

Also, there are some calls to kmalloc in the shutdown path - and they work. 
I know this because I saw a problem with one of them: it gave "might_sleep 
while atomic", and it was kmalloc in the shutdown, or rather, in panic() - 
for the broken sysrq t (where's the fix you promised?).

While looking for the "change" function, I thought even if it's static, that's 
still not enough to deserve such an insignificant name. Ah, it's in 
arch/um/drivers/net_user.c.

 <3>Debug: sleeping function called from invalid context 
at /home/paolo/Admin/kernel/6/VCS/linux-2.6.13/mm/slab.c:2096
in_atomic():1, irqs_disabled():0

a0327088:  [<a00164f2>] dump_stack+0x22/0x30
a03270a8:  [<a0049e1c>] __might_sleep+0xac/0xd0
a03270c8:  [<a0094fa0>] __kmalloc+0xc0/0x110
a03270f8:  [<a00129ba>] um_kmalloc+0x1a/0x20
a0327108:  [<a0038b6b>] change+0xcb/0x220
a03271d8:  [<a0038d10>] close_addr+0x20/0x30
a03271e8:  [<a00385bb>] iter_addresses+0x7b/0x90
a0327218:  [<a0041b0a>] tuntap_close+0x4a/0x70
a0327238:  [<a003827d>] close_devices+0x4d/0x90
a0327258:  [<a0012a92>] do_uml_exitcalls+0x22/0x40
a0327268:  [<a0013763>] uml_cleanup+0x13/0x20
.... panic...

The real solution for this warning is to replace um_kmalloc with malloc(), and 
set, during shutdown, kmalloc_only_atomic - which would switch 
__wrap_malloc() from um_kmalloc to um_kmalloc_atomic.

Or better yet, simply test in_atomic() and irqs_disabled() to choose between 
the atomic and normal versions.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
