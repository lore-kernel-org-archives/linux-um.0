Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cs4jU-00074R-Nu for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Jan 2005 11:46:12 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Cs4jP-0001UM-MN for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Jan 2005 11:46:12 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SIGSEGV and SA_NODEFER
References: <200501182128.j0ILSgxi013966@ccure.user-mode-linux.org>
	<200501211335.37894.blaisorblade@yahoo.it>
	<200501211318.16848.rob@landley.net>
In-Reply-To: <200501211318.16848.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501212058.16992.blaisorblade@yahoo.it>
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
Date: Fri, 21 Jan 2005 20:58:16 +0100
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 21 January 2005 19:18, Rob Landley wrote:
> On Friday 21 January 2005 07:35 am, Blaisorblade wrote:
> > > Ooh, ooh!  Hang in TT mode is what I'm seeing with my makefile hang. 
> > > (sh -x dosn't help if the makefile doesn't call out to stuff with it.)
> > >
> > > If the previous patch doesn't address it, is there a new patch I could
> > > try?
> >
> > Well, you solved this problem with the 2.6.11-rc1-mm2, right (from the
> > message below)?
>
> With 2.6.11-rc1-mm2, my toolchain build runs through to completion under
> UML. (Very very slowly, but it does.  Tested on a 1.6 ghz 2 meg cache
> computer, which runs it under UML at about the speed of my 700 mhz 128k
> cache laptop without UML.  But hey, it's using tt mode, and completing
> correctly.  That's the important thing...)
>
> > The patch which was merged there is the one posted with title
> > "[uml-devel] [PATCH] Fix stack corruption" on this list..., I guess... it
> > will be in 2.6.9-bs6 and 2.6.10-bb1 (both to release) - are you willing
> > to test one of them, when I do the release? I'd be very thankful to
> > accept your help...
>
> I'll happily try out 2.6.10-bb1, sure.

> The mm2 changelog says it has:

That is -mm1, I've already looked at both... the patches listed below are 
minor fixes / improvements...

The name of the 2.6.11-rc1-mm2 patch which probably fixed your issue is:

uml-fix-a-stack-corruption-crash.patch

If it's not a problem, try removing it from -mm2 and recompiling, and test if 
you get the crash with the new kernel (which is what I expect)...
>
> More later, lunch is over...
Here, now, I must go to dinner... bye!
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
