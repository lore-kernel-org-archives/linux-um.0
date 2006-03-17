Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FKKlw-0003bS-Iv for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2006 11:38:04 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FKKlu-0007so-0g
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2006 11:38:04 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Occasional hang starting up.
References: <200603111301.42195.rob@landley.net>
	<20060314202249.GB22286@ccure.user-mode-linux.org>
	<20060316112251.A17140@almesberger.net>
In-Reply-To: <20060316112251.A17140@almesberger.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_b/wGEiBhOjfX7/Y"
Message-Id: <200603172036.59218.blaisorblade@yahoo.it>
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
Date: Fri, 17 Mar 2006 20:36:58 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Werner Almesberger <wa@almesberger.net>, Jeff Dike <jdike@addtoit.com>, Rob Landley <rob@landley.net>

--Boundary-00=_b/wGEiBhOjfX7/Y
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 16 March 2006 15:22, Werner Almesberger wrote:
> Jeff Dike wrote:
> > Having said that,
> > if you can get a stack from the hang, it might turn out to be an easily
> > diagnosed and fixed bug.
>
> Seems that arch/um/kernel/sigio_user.c:write_sigio_thread begins
> its poll before there are any fds in current_poll

Ah, and you mean it hangs...

> , so update_thread 
> caused by a add_sigio_fd shortly thereafter hangs while waiting for
> a response.

Clearly

> A sleep(1) at the beginning of write_sigio_thread "fixes" this :-)

Er... there's only one thing which seems unclear - poll(NULL, 0, -1) shouldn't 
fail with -EFAULT instead of hanging? Yep, it should. I didn't believe what 
you said, so. But then I went to check the implementation. And, indeed, it 
seems that Linux isn't up to this :-).

So:

1) I'll try to fix poll(2) to return -EINVAL. Dunno whether anyone will say 
"no, the app is stupid, it deserves no error", but hope not (with "try" I 
refer to this). Attached patch should do this.

2) write_sigio_thread should do a "down" on a semaphore/mutex and the first 
update_thread should "up" it. As usually, this semaphore would be indeed 
implemented as a pipe.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_b/wGEiBhOjfX7/Y
Content-Type: text/x-diff; charset="iso-8859-1";
	name="poll-mustn_t-hang-0-fds.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="poll-mustn_t-hang-0-fds.patch"

poll(2): don't hang caller if nfds == 0

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Werner Almesberger <wa@almesberger.net>

As Werner Almesberger observed in a real program, poll(2) will never return if
called with nfds == 0; which is stupid but not so badly deserving.

I looked at the code and verified that indeed such a case is never detected and
do_poll keeps looping, checking any fd passed, overlooking it wasn't passed any
and calling schedule_timeout() endlessly. At least it's a TASK_INTERRUPTIBLE
sleep...

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/fs/select.c
===================================================================
--- linux-2.6.git.orig/fs/select.c
+++ linux-2.6.git/fs/select.c
@@ -629,6 +629,10 @@ int do_sys_poll(struct pollfd __user *uf
 	struct fdtable *fdt;
 	int max_fdset;
 
+	/* Otherwise below code would hang! */
+	if (unlikely(nfds < 1))
+		return -EINVAL;
+
 	/* Do a sanity check on nfds ... */
 	rcu_read_lock();
 	fdt = files_fdtable(current->files);

--Boundary-00=_b/wGEiBhOjfX7/Y--

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
