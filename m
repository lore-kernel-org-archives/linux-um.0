Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDnpU-0006Mu-Gp for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 10:10:12 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DDnpS-0005kY-4h
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 10:10:12 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Re: Supporting building on x86-64 host as 32-bit UML
Message-ID: <20050322190731.GA8975@bytesex>
References: <200503191904.05870.blaisorblade@yahoo.it>
	<20050320150306.GA14594@bytesex>
	<200503221853.20853.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503221853.20853.blaisorblade@yahoo.it>
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
Date: Tue, 22 Mar 2005 20:07:31 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Mar 22, 2005 at 06:53:20PM +0100, Blaisorblade wrote:
> On Sunday 20 March 2005 16:03, Gerd Knorr wrote:
> > > 1) how the user must choose what he wants (SUBARCH=i386 can be useful,
> > > maybe a Kconfig option would be nice - we need to choose the default
> > > depending on the host arch).
> >
> > That one is easy -- just use "linux32 make ...".  That will switch the
> > personality and "uname" will return "i686" instead of "x86_64" then ;)
> linux32 is a SuSE specific alias like the "i386" for Fedora, right (they both 
> alias setarch, IIRC)?

Don't have a "setarch" binary here.  But most likely they do almost the
same, yes.

> > Not needed I think.  Thats used for kconfig and other stuff which runs
> > on the _host_ machine (for cross compiles), thus it doesn't hurt if it
> > is 64 bit.
> I'm not sure, but that's probably needed for the userspace utilities that 
> print out some headers (with offsets inside host proc. specific structs).

Uhm, ok, then it probably is needed.  This also means that you can't
cross-compile uml kernels, right?

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
