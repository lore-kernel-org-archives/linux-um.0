Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Ag6vQ-0006WO-6x for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Jan 2004 10:36:32 -0800
Received: from mta11.adelphia.net ([68.168.78.205])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ag6vP-0007fd-Qv for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Jan 2004 10:36:31 -0800
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20040112183623.GB1436@alcor.net>
References: <20031220171450.GB10692@ccure.user-mode-linux.org>
	<20031221005257.GF9354@alcor.net> <20031221010656.GH9354@alcor.net>
	<20031228093317.GK17472@alcor.net>
	<20031228095115.GL17472@alcor.net>
	<20031228101240.GN17472@alcor.net>
	<20031228113042.GO17472@alcor.net>
	<20031230184330.GD1365@alcor.net>
	<200401060258.i062wWFI023087@ccure.user-mode-linux.org>
	<20040108070718.GI28393@alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040108070718.GI28393@alcor.net>
Subject: [uml-devel] Panic with slirp transport and gcc 3.3
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
Date: Mon, 12 Jan 2004 10:36:23 -0800
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, debian-gcc@lists.debian.org, ballombe@debian.org, 176485@bugs.debian.org

On Wed, Jan 07, 2004 at 11:07:18PM -0800, Matt Zimmerman wrote:

> On Mon, Jan 05, 2004 at 09:58:32PM -0500, Jeff Dike wrote:
> 
> > mdz@debian.org said:
> > > It turns out that this problem seems to be due to compiler
> > > incompatibility. UML had been built with gcc 2.95 due to old breakage,
> > > and when built with gcc 3.3 (as glibc is), everything starts working
> > > again.  My suspicion is that this is due to certain recent changes in
> > > pthreads.
> > 
> > Is it your opinion that there's no problem in UML itself?  Having a field
> > in the sigcontext getting magically munged is somewhat worrying.  I'd be 
> > happier knowing what exactly was happening so I can be sure this wasn't
> > exposing some subtle UML bug.
> 
> I was not able to come to a satisfactory conclusion as to the origin of the
> problem, and once I found a solution, I stopped looking.  I'm copying
> debian-gcc and debian-glibc in case they're interested.
> 
> Summary for debian-{gcc,glibc}:
> 
> UML built with gcc-2.95 fails to run correctly on a current unstable system
> with a 2.4 kernel.  The symptoms are very strange; This started to happen recently; UML had been building
> with gcc 2.95 successfully for over 9 months now with no problems.
> 
> Details are here: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=224431

By the way, the original reason why I started building UML with gcc-2.95 was
because building with 3.x broke the slirp transport like so:

Kernel panic: read of switch_pipe failed, errno = 9

errno 9 is EBADF.  I never did find the real cause of that bug, but it has
resurfaced now that I am building with gcc 3.3 again to fix the other, worse
bug.  I would be interested to know if anyone else has run into it.  More
information is here:

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=176485&archive=yes

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
