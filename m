Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E0kGL-0001wn-68	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Aug 2005 11:16:13 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1E0kGK-00025Y-ES
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Aug 2005 11:16:13 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Host kernel requirements for UML
References: <20050803094805.GA6090@in.ibm.com>
	<20050803143957.GB4701@ccure.user-mode-linux.org>
	<20050803171507.GA15047@in.ibm.com>
In-Reply-To: <20050803171507.GA15047@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508042022.30184.blaisorblade@yahoo.it>
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
Date: Thu, 4 Aug 2005 20:22:30 +0200
To: user-mode-linux-devel@lists.sourceforge.net, vatsa@in.ibm.com
Cc: Jeff Dike <jdike@addtoit.com>

On Wednesday 03 August 2005 19:15, Srivatsa Vaddagiri wrote:
> On Wed, Aug 03, 2005 at 10:39:57AM -0400, Jeff Dike wrote:
> > On Wed, Aug 03, 2005 at 03:18:05PM +0530, Srivatsa Vaddagiri wrote:
> > > Hi,
> > > 	I am trying to get a quick answer for a question I had on UML.
> > > As I understand, UML kernel makes use of host kernel's
> > > system call interface for its functionality. The questions is, does the
> > > host kernel need to support *all* system calls or only a subset?

> > Only a small subset.

> Thanks for the info. Is there any place where this subset is documented?
Surely not. However, that *does not* yet include any fancy 2.6 features. Why 
are you looking for it? What are you going to port/run UML to?

> I was hoping to avoid looking at the unresoled symbols in UML binary to
> get this info!

That wouldn't work... how would you discover that recent UMLs require the host 
to support PTRACE_O_SYSGOOD (a ptrace option set through PTRACE_SETOPTIONS)?

That's only in recent ones and that support has been added in 2.4, so it's 
safe.

Hey, if you look at the man page, you won't find out what they're about, 
either!

For the core, it just requires (*heavily*) mmap and friends, standard 
filesystem support (possibly including largefile-aware versions) and signals. 
But it extends a lot for terminal support, for instance it will make the 
stdin/stdout terminal "raw" with cfmakeraw(3), probably through some IOCTLs, 
bundled inside libraries...
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
