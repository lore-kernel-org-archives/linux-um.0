Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AeUGL-0006Un-T4 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jan 2004 23:07:25 -0800
Received: from mta13.mail.adelphia.net ([68.168.78.44] helo=mta13.adelphia.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AeUGL-0006oS-H7 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jan 2004 23:07:25 -0800
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: Resolution (Re: [uml-devel] 2.4.22-[67] problems)
Message-ID: <20040108070718.GI28393@alcor.net>
References: <20031220011323.GW18100@alcor.net>
	<20031220171450.GB10692@ccure.user-mode-linux.org>
	<20031221005257.GF9354@alcor.net> <20031221010656.GH9354@alcor.net>
	<20031228093317.GK17472@alcor.net>
	<20031228095115.GL17472@alcor.net>
	<20031228101240.GN17472@alcor.net>
	<20031228113042.GO17472@alcor.net>
	<20031230184330.GD1365@alcor.net>
	<200401060258.i062wWFI023087@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401060258.i062wWFI023087@ccure.user-mode-linux.org>
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
Date: Wed, 7 Jan 2004 23:07:18 -0800
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, 224431@bugs.debian.org, debian-gcc@lists.debian.org

On Mon, Jan 05, 2004 at 09:58:32PM -0500, Jeff Dike wrote:

> mdz@debian.org said:
> > It turns out that this problem seems to be due to compiler
> > incompatibility. UML had been built with gcc 2.95 due to old breakage,
> > and when built with gcc 3.3 (as glibc is), everything starts working
> > again.  My suspicion is that this is due to certain recent changes in
> > pthreads.
> 
> Is it your opinion that there's no problem in UML itself?  Having a field
> in the sigcontext getting magically munged is somewhat worrying.  I'd be 
> happier knowing what exactly was happening so I can be sure this wasn't
> exposing some subtle UML bug.

I was not able to come to a satisfactory conclusion as to the origin of the
problem, and once I found a solution, I stopped looking.  I'm copying
debian-gcc and debian-glibc in case they're interested.

Summary for debian-{gcc,glibc}:

UML built with gcc-2.95 fails to run correctly on a current unstable system
with a 2.4 kernel.  The symptoms are very strange; This started to happen recently; UML had been building
with gcc 2.95 successfully for over 9 months now with no problems.

Details are here: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=224431

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
