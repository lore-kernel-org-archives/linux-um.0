Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtOmx-0007Lj-M5 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 03:23:15 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CtOmr-00013C-UI for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 03:23:15 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SIGSEGV and SA_NODEFER
References: <200501182128.j0ILSgxi013966@ccure.user-mode-linux.org>
	<200501251116.18892.blaisorblade@yahoo.it>
	<200501250516.39648.rob@landley.net>
In-Reply-To: <200501250516.39648.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501251240.35872.blaisorblade@yahoo.it>
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
Date: Tue, 25 Jan 2005 12:40:35 +0100
To: Rob Landley <rob@landley.net>
Cc: Gerd Knorr <kraxel@bytesex.org>, user-mode-linux-devel@lists.sourceforge.net

On Tuesday 25 January 2005 11:16, Rob Landley wrote:
> On Tuesday 25 January 2005 05:16 am, Blaisorblade wrote:
> > > > > I'm using stdin/stdout as the console.  (And even though you put it
> > > > > into raw mode, I still can't ctrl-c out of the processs I'm
> > > > > running, either.)
> > >
> > > Hmm, ^C works perfectly fine for me.  Usually I work with a virtual
> > > serial line as console ("console=ttyS0 ssl0=fd:0,fd:1 con=pts"), works
> > > better than the uml console as applications don't expect the linux vt
> > > ioctls work on these devices ;)

> > About this, Rob: do you use /dev/console in the inittab line? If you do,
> > then that's the problem - it should become a FAQ somewhere I guess.

> I'm not using init, I'm running my script as init.  So I'd guess it's
> using /dev/console, yes.

> I know that /dev/console is funky.  That's why I want the option to let
> ctrl-c kill the whole vmlinux instance.  (Possibly as a command line
> option.)  I'll look into that later...

> > > I'm still at 2.6.10 + patches though, not yet at 2.6.11-rc2.

> > > > However, I'm not sure that patch is at fault... there is a locking
> > > > problem which *could* maybe be responsible of this...; I actually
> > > > wonder about why this locking problem has never shown up in reports
> > > > or in testing (it exists, only it's a race condition)... there is a
> > > > situation where it shows up with a side effect, indeed, so the
> > > > problem exists...
> > >
> > > Heavy swapping (see other mail) and thus some stuff running _very_ slow
> > > might open such race windows wide enougth that one actually hits them.
> >
> > Yes, my only doubt was that he seemed to mean that the guest was
> > swapping, and *this* different situation would have the opposite effect,
> > probably.
>
> Host is swapping, client configured without even support for swap.  (If I
> can get the darn client vmlinux down to 1 megabyte, I'd be thrilled. 
> Didn't somebody once make the entire block layer configurable out once? 
> With hostfs, I don't need it...)

Do you trust hostfs so much? You don't need user IDs on your FS, I guess. I'm 
not at all happy with this, but I don't want someone using hostfs over its 
possibilities. NFS is much better, anyway. And somebody says it's also faster 
(and since hostfs does limited caching, it makes sense - hostfs must avoid 
having any inode cache, since it closes the host fd only when the inode is 
evicted from the cache; I don't think it's possible to cache data without an 
inode to link to, so it's clear it's slow).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
