Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DllBB-0002QQ-8a	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Jun 2005 03:12:57 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DllB9-0002zN-He	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Jun 2005 03:12:57 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Question about the unexpected signal 11 when fork in
	UML-2.6.7 TT mode
References: <000301c578a3$2cc33480$9eb3c68a@SHZ.ST.COM>
In-Reply-To: <000301c578a3$2cc33480$9eb3c68a@SHZ.ST.COM>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506241217.56423.blaisorblade@yahoo.it>
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
Date: Fri, 24 Jun 2005 12:17:56 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Alex LIU <alex.liu@st.com>

On Friday 24 June 2005 11:57, Alex LIU wrote:
> I just let the SIGSEVG go and return from the sleeping_process_signal
> function instead of tracer_panic and hanging the UML. It seems ok. Is it
> dangerous? Thanks a lot!
The sleeping process will get the SIGSEGV, with whatever content it has; 
hopefully it should handle it in kernel code but I'm not too sure about the 
situation. To ignore the signal you'll need a PTRACE_CONT (or PTRACE_SYSCALL, 
depending on the situation) with a 0 signal value.

However, is this related to the below problem? Did you try the other way 
around (i.e. upgrading) to solve it?
> Alex

> -----Original Message-----
> From: Blaisorblade [mailto:blaisorblade@yahoo.it]
> Sent: Tuesday, June 21, 2005 11:42 PM
> To: user-mode-linux-devel@lists.sourceforge.net
> Cc: Alex LIU
> Subject: Re: [uml-devel] Question about the unexpected signal 11 when fork
> in UML-2.6.7 TT mode
>
> On Tuesday 21 June 2005 12:05, Alex LIU wrote:
> > Hi,all:
> >
> > When I fork() in UML TT mode,it always said "the sleeping process xxx
> > received unexpedted signal 11" and the UML hang...before fork I also
> > set the signal handler... My UML is 2.6.7 and I used TT mode.Thanks a
> > lot!
> >
> > Alex
>
> Have you a good reason to use UML 2.6.7? We can't know by heart the list of
> all fixed bugs in previous UML releases, really, and you'll be doing
> yourself a favor by upgrading to 2.6.11-bs5 or 2.6.12 (which contains
> almost everything from -bs).
>
> That said, you are talking about userspace code, right? It's anyway strange
> that your system boots but you can't write a simple code that fork()'s.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
