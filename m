Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDpbt-0003ZZ-2L for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 12:04:17 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DDpbZ-0007sA-6I for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Mar 2005 12:04:17 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: Supporting building on x86-64 host as 32-bit UML
References: <200503191904.05870.blaisorblade@yahoo.it>
	<200503221853.20853.blaisorblade@yahoo.it>
	<20050322190731.GA8975@bytesex>
In-Reply-To: <20050322190731.GA8975@bytesex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503222102.11643.blaisorblade@yahoo.it>
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
Date: Tue, 22 Mar 2005 21:02:11 +0100
To: Gerd Knorr <kraxel@bytesex.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tuesday 22 March 2005 20:07, Gerd Knorr wrote:
> On Tue, Mar 22, 2005 at 06:53:20PM +0100, Blaisorblade wrote:
> > On Sunday 20 March 2005 16:03, Gerd Knorr wrote:
> > > > 1) how the user must choose what he wants (SUBARCH=i386 can be
> > > > useful, maybe a Kconfig option would be nice - we need to choose the
> > > > default depending on the host arch).
> > >
> > > That one is easy -- just use "linux32 make ...".  That will switch the
> > > personality and "uname" will return "i686" instead of "x86_64" then ;)
> >
> > linux32 is a SuSE specific alias like the "i386" for Fedora, right (they
> > both alias setarch, IIRC)?
>
> Don't have a "setarch" binary here.  But most likely they do almost the
> same, yes.
>
> > > Not needed I think.  Thats used for kconfig and other stuff which runs
> > > on the _host_ machine (for cross compiles), thus it doesn't hurt if it
> > > is 64 bit.
> >
> > I'm not sure, but that's probably needed for the userspace utilities that
> > print out some headers (with offsets inside host proc. specific structs).
>
> Uhm, ok, then it probably is needed.  This also means that you can't
> cross-compile uml kernels, right?
Eh? Those utilities must run on the compile host, and they are compiled with 
HOSTCC, but use the targets header. So on x86-64 / x86 it works, but probably 
in general you are right (I don't have the whole picture right now, but this 
makes sense).

That said, Al Viro changed this significantly when working on making UML 
cross-compile well, so you again are probably right. I'm currently merging 
his work in little pieces.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
