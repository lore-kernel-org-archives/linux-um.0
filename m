Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DIv4x-0004gd-4u for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Apr 2005 13:55:19 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DIv4v-0000sB-GL for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Apr 2005 13:55:19 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] question about UML sigcontext in tt mode
References: <003501c535d8$e8574a50$90b3c68a@st.com>
	<20050404140011.GA1977@ccure.user-mode-linux.org>
	<200504051320.45424.rob@landley.net>
In-Reply-To: <200504051320.45424.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504052259.41817.blaisorblade@yahoo.it>
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
Date: Tue, 5 Apr 2005 22:59:41 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, Jeff Dike <jdike@addtoit.com>, Alex LIU <alex.liu@st.com>

On Tuesday 05 April 2005 19:20, Rob Landley wrote:
> On Monday 04 April 2005 10:00 am, Jeff Dike wrote:
> > On Thu, Mar 31, 2005 at 06:03:34PM +0800, Alex LIU wrote:
> > > union uml_pt_regs {
> > > #ifdef UML_CONFIG_MODE_TT
> > >  struct tt_regs {
> > >   long syscall;
> > >   void *sc;
> > >  } tt;
> > > #endif
> > > };
> > > -------------------------------------
> > >
> > > Then why the tt.sc is defined as void while not as struct sigcontext?
> > > Thanks!
> >
> > Probably because you can't get a definition of struct sigcontext into
> > processor.h and have it still compile.
> >
> > Try #including sigcontext.h there and you'll see what I mean.
>
> I don't know about can't.
>
> #define sigcontext WALRUS
> #include <processor.h>
> thingy
> #undef WALRUS
>
> Adviseable is another matter entirely.  (Did I mention I have a knack for
> coming up with disgusting solutions to impossible problems?)
I've not tested if it's impossible in this very case, however: if any host 
header includes kernel headers on the host, and we include it from a 
kernelspace file, we run into trouble.

So, defining away like you do above every and each identifier present in every 
possible versions of glibc / kernel headers would indeed work. Is this still 
a solution?

So, we cut the problem by excluding the unusable headers from the compiler 
search path. arch/um/include are includable everywhere, /usr/include from 
userspace files, <currentTreeRoot>/include/{asm,linux,*}/ from kernelspace 
only.

If you really come up with a general solution, let us know. Please. Thanks for 
you effort anyway.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
