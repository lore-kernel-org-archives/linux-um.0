Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtNTJ-0003Xn-UE for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 01:58:53 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CtNTJ-0001BC-8Y for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 01:58:53 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SIGSEGV and SA_NODEFER
References: <200501182128.j0ILSgxi013966@ccure.user-mode-linux.org>
	<200501242045.09164.blaisorblade@yahoo.it>
	<20050125084506.GA562@bytesex>
In-Reply-To: <20050125084506.GA562@bytesex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501251116.18892.blaisorblade@yahoo.it>
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
Date: Tue, 25 Jan 2005 11:16:18 +0100
To: Gerd Knorr <kraxel@bytesex.org>, Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 25 January 2005 09:45, Gerd Knorr wrote:
> > > binutils-2.14/ld/testsuite/ld-sparc/tlssunbin64.dd
> > > binutils-2.14/ld/testsuite/ld-sparc/tlssunbin64.rd
> > > binutils-2.14/ld/testsuite/lde/ld-/ld-sld-spd-spa-sparsparcparc/arc/trc
> > >/tlc /tls/tlsstlssulssunssunbsunbiunbinnbin6bin64in64.n64.s64.s4.s.ss
> > > binubinutinutinutilutilstils-ils-2ls-2.s-2.1-2.142.14/.14/l14/ld4/ld//l
> > >d/tl
> > > d/ted/tes/testtestsestsustsuitsuitsuiteuite/ite/lte/lde/ld-/ld-sld-spd-
> > >spa-s
> > > parsparcparc/arc/trc/tlc/tls/tlsstlssulssunssunbsunbiunbinnbin6bin64in6
> > >4.n64 .s64.sd4.sd.sdsd
> > > binutils-2.14/ld/testsuite/ld-sparc/tlssunbin64.td
> > > binutils-2.14/ld/testsuite/ld-sparc/tlssunbinpic32.s
> > > binutils-2.14/ld/testsuite/ld-sparc/tlssunbinpic64.s
> > > binutils-2.14/ld/testsuite/ld-sparc/tlssunnopic32.dd
> > >
> > > I had all that output piped to tee, which output it to out.txt, and the
> > > corresponding line of out.txt isn't glitched, so it seems to just be a
> > > cosmetic bug in the display code.  But I thought I'd report it anyway.
> >
> > Good thing, thanks...

> I remember having seen a comment (and patch?) on one of the lists for
> the tty line buffering, because of data loss in case the buffers are
> full.  Don't remember the details but this could be related.

> > > I'm using stdin/stdout as the console.  (And even though you put it
> > > into raw mode, I still can't ctrl-c out of the processs I'm running,
> > > either.)

> Hmm, ^C works perfectly fine for me.  Usually I work with a virtual
> serial line as console ("console=ttyS0 ssl0=fd:0,fd:1 con=pts"), works
> better than the uml console as applications don't expect the linux vt
> ioctls work on these devices ;)

About this, Rob: do you use /dev/console in the inittab line? If you do, then 
that's the problem - it should become a FAQ somewhere I guess.

> I'm still at 2.6.10 + patches though, not yet at 2.6.11-rc2.

> > However, I'm not sure that patch is at fault... there is a locking
> > problem which *could* maybe be responsible of this...; I actually wonder
> > about why this locking problem has never shown up in reports or in
> > testing (it exists, only it's a race condition)... there is a situation
> > where it shows up with a side effect, indeed, so the problem exists...

> Heavy swapping (see other mail) and thus some stuff running _very_ slow
> might open such race windows wide enougth that one actually hits them.

Yes, my only doubt was that he seemed to mean that the guest was swapping, and 
*this* different situation would have the opposite effect, probably.

> The uml-terminal-cleanup patch doesn't touch how the uml terminal lines
> output (xterm, pty, ...) works, it's more the input side which has been
> reworked a bit, especially the console handling (console meaning the
> device the kernel sends the printk messages to, not the linux vt
> subsystem).

>   Gerd

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
