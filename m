Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CsPBZ-0001w2-JL for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Jan 2005 09:36:33 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CsPBX-0002Ck-Pr
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Jan 2005 09:36:33 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] SIGSEGV and SA_NODEFER
References: <200501182128.j0ILSgxi013966@ccure.user-mode-linux.org>
	<200501211318.16848.rob@landley.net>
	<200501212058.16992.blaisorblade@yahoo.it>
In-Reply-To: <200501212058.16992.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501221134.44585.rob@landley.net>
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
Date: Sat, 22 Jan 2005 11:34:44 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 21 January 2005 02:58 pm, Blaisorblade wrote:

> That is -mm1, I've already looked at both... the patches listed below are
> minor fixes / improvements...
>
> The name of the 2.6.11-rc1-mm2 patch which probably fixed your issue is:
>
> uml-fix-a-stack-corruption-crash.patch

I reverted that patch, rebuilt vmlinux, tried again, and it's happily halfway 
through the binutils build as I type.  That fix doesn't seem to be it.  
(Makes a certain amount of sense, since I wasn't seeing a crash, I was seeing 
a hang.)

> If it's not a problem, try removing it from -mm2 and recompiling, and test
> if you get the crash with the new kernel (which is what I expect)...
>
> > More later, lunch is over...
>
> Here, now, I must go to dinner... bye!

Another interesting point is that with -mm2 (patched or unpatched), I'm seeing 
output hiccups when the system swaps.  Here's a cut and paste of a section 
where it was extracting the binutils tarball:

binutils-2.14/gas/testsuite/gas/hppa/unsorted/common.s
binutils-2.14/gas/testsuite/gas/hppa/unsorted/fragbug.s
binutils-2.14/gas/testsuite/gas/hppa/unsorteortedrted/ted/ged/gld/glo/globglobalobalobalbbalbualbuglbug.bug.sug.sg.s.ss
binutils-2.14/gas/testsuite/gas/hppa/unsorted/importbug.s

And later on...

binutils-2.14/ld/testsuite/ld-sparc/tlssunbin64.dd
binutils-2.14/ld/testsuite/ld-sparc/tlssunbin64.rd
binutils-2.14/ld/testsuite/lde/ld-/ld-sld-spd-spa-sparsparcparc/arc/trc/tlc/tls/tlsstlssulssunssunbsunbiunbinnbin6bin64in64.n64.s64.s4.s.ss
binubinutinutinutilutilstils-ils-2ls-2.s-2.1-2.142.14/.14/l14/ld4/ld//ld/tld/ted/tes/testtestsestsustsuitsuitsuiteuite/ite/lte/lde/ld-/ld-sld-spd-spa-sparsparcparc/arc/trc/tlc/tls/tlsstlssulssunssunbsunbiunbinnbin6bin64in64.n64.s64.sd4.sd.sdsd
binutils-2.14/ld/testsuite/ld-sparc/tlssunbin64.td
binutils-2.14/ld/testsuite/ld-sparc/tlssunbinpic32.s
binutils-2.14/ld/testsuite/ld-sparc/tlssunbinpic64.s
binutils-2.14/ld/testsuite/ld-sparc/tlssunnopic32.dd

It did it about five or six times, that I noticed.  (And it did it before I 
reverted the stack fix patch, so that's not it.)

I had all that output piped to tee, which output it to out.txt, and the 
corresponding line of out.txt isn't glitched, so it seems to just be a 
cosmetic bug in the display code.  But I thought I'd report it anyway.  I'm 
using stdin/stdout as the console.  (And even though you put it into raw 
mode, I still can't ctrl-c out of the processs I'm running, either.)

Rob


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
