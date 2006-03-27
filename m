Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FO0Hp-0002OW-Qg for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Mar 2006 14:34:09 -0800
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FO0Ho-0006VB-8Q
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 27 Mar 2006 14:34:09 -0800
Content-Disposition: inline
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200603280034.08974.blaisorblade@yahoo.it>
Subject: [uml-devel] Fwd: Re: SMP skas requirements
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
Date: Tue, 28 Mar 2006 00:34:08 +0200
To: user-mode-linux-devel@lists.sourceforge.net



----------  Forwarded Message  ----------

Subject: Re: SMP skas requirements
Date: Tuesday 28 March 2006 00:32
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@projects.sourceforge.net

On Tuesday 21 March 2006 00:44, Blaisorblade wrote:
> On Monday 20 March 2006 22:06, Jeff Dike wrote:
> > There is some interest from a group inside Intel in helping with skas
> > SMP.  I wrote up the following, and I'd appreciate some review to see
> > if I missed anything.
> >
> > 				Jeff
> >
> > Summary, details below:
> >
> > Locking between threads of skas0 data page
> > Locking between threads of tlb flushing
> > Create one host thread per UML process when SMP is enabled,
> > 	propagating CLONE_VM to host
> > Use userspace_pids array properly
> > Make an SMP cleaning pass over UML arch

There are tons of places where spinlocks are used improperly. We need
 stricter locking, however that is complicated by the addition of atomic
 sections where UML can't sleep.

For instance, sigio_lock needs to be irqsave (I'll test the patch for this
shortly). On the other side, uml_console_write shouldn't take any lock, it
seems (see Documentation/tty.txt).

> Especially maybe_map must pin the pages (see implementation of 4G/4G
> copy_*_user from Ingo Molnar).
>
> > Add locking to filehandle
>
> I'll work on this, I had come up with a nice design time ago, if you merge
> a lockless filehandle I'll be glad to add locking to it. If you have a
> somehow stable code base on it, let me know and I'll work on the patches.
>
> > Details:
> >
> > Of particular concern is the filehandle abstraction, which is used for
> > file descriptor management.  With hostfs and humfs, it is easy to hit
> > the file descriptor limit.  filehandles transparently deal with this
> > by detecting -EMFILE from the host, closing descriptors in order to
> > free up slots, and reopening closed files when they become active
> > again.  The problem is that there is currently nothing preventing a
> > descriptor from being reclaimed while it is being used.  A descriptor
> > is first checked to see if it's open (and reopened if not), and then
> > used.  The descriptor reclaiming code running on a different processor
> > could close the descriptor after it's checked for validity and before
> > it's used.  We need something to prevent this, like a
> > get_fh()/put_fh() around all such operations.
>
> My design was that you:
> a) take the list lock
> b) remove the fd from the list
> c) drop the list lock
> instead of simply bringing the fd upfront
> d) call read (or whatever) on the interested fd
> e) redo a)-c) but now to _add_ the fd on list, on the front
>
> This may also need a reference count if in step b) the fd may already be on
> the list.
>
> *) when _any_ fd API of the existing set (os_*) is called, it detects
> -EMFILE/-ENFILE and closes fd's on the back of the list (i.e. we do LRU on
> the list)
> *) using new APIs is only needed to register an fd as "reclaimable" - this
> is optional since it can be used only for file-based fds (not for pipes,
> probably not for sockets)

--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

-------------------------------------------------------

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
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
