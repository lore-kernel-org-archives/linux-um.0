Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtZhu-0004AR-El for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 15:02:46 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CtZhr-0002q8-Ku for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jan 2005 15:02:46 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20041118160909.GA7630@halcrow.us>
	<200501252337.58219.blaisorblade@yahoo.it>
	<20050125224650.GA6136@halcrow.us>
In-Reply-To: <20050125224650.GA6136@halcrow.us>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501260002.04171.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [uml-user] keyring syscalls
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
Date: Wed, 26 Jan 2005 00:02:03 +0100
To: Michael Halcrow <uml@halcrow.us>
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Tuesday 25 January 2005 23:46, Michael Halcrow wrote:
> On Tue, Jan 25, 2005 at 11:37:57PM +0100, Blaisorblade wrote:
> > On Tuesday 25 January 2005 22:54, Michael Halcrow wrote:
> > > On Thu, Nov 18, 2004 at 06:39:26PM +0100, Blaisorblade wrote:
> >
> > Well, it should be fixed in the -mm tree (and probably in 2.6.11-rc2-bk2,
> > I guess, though it's not tested)... browse the patches at
> > http://user-mode-linux.sourceforge.net/patches.html.
>
> I did notice that and tried to build it, but I had build errors.
> Specifically, the compiler complains that the PTRACE_SETOPTIONS symbol
> is undeclared in arch/um/kernel/process.c.  If I include
> linux/ptrace.h and try again, then the new syscalls (vperfctr_*) are
> undeclared in arch/um/kernel/sys_call_table.c.
Yes, that was fixed some patches later... Jeff added those syscalls to match 
-mm (since he works on that)... I made him notice and I thought I even posted 
a patch.
> I just gave up at that 
> point; I'll wait for the official 2.6.11 release.
That *will* have to work.
> In the meantime, 
> I'll see if I can't backport the changes in the 2.6.11-rc2 patch to
> 2.6.10.
>
> Thanks,
> Mike
> .___________________________________________________________________.
>                          Michael A. Halcrow
>        Security Software Engineer, IBM Linux Technology Center
> GnuPG Fingerprint: 05B5 08A8 713A 64C1 D35D  2371 2D3C FDDA 3EB6 601D

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
