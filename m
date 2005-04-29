Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRFz3-0002eD-LO	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 13:51:41 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DRFz3-0005pI-0K	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 13:51:41 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: Segfault 2.6.11-rc1-mm1
References: <200504241945.51674.lil_tux@web.de>
	<200504242059.15078.blaisorblade@yahoo.it> <200504242204.09786.lil_tux@web.de>
In-Reply-To: <200504242204.09786.lil_tux@web.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200504292252.47087.blaisorblade@yahoo.it>
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
Date: Fri, 29 Apr 2005 22:52:46 +0200
To: lil_tux@web.de, user-mode-linux-devel@lists.sourceforge.net

On Sunday 24 April 2005 22:04, Heiko Przybyl wrote:
> > > Could be the problem the position independent code or native posix
> > > thread library? I've got both enabled, but i don't want to recompile my
> > > whole system..
> >
> > Well, I have
>
> You have recompiled your system or enabled those options?
Sorry, I forgot to finish the sentence. I have NPTL on my system, so that's 
not the culprit. The hardened toolchain may be, I'll investigate on this.
> > > It doesn't matter if I turn on the 2G/2G or not. Or doesn't uml work
> > > without skas, anymore?
> >
> > Well, playing with all possible settings of MODE_TT, MODE_SKAS and
> > STATIC_LINKING is welcome.
>
> Ok I'll have a look at this. Currently, I'm trying an other binutils
> version, cause the old one gave me the following error, several times:
>
> /usr/lib/gcc/i686-pc-linux-gnu/3.4.3/../../../../i686-pc-linux-gnu/bin/ld:
> `__strtol_ul_max_tab' referenced in section `.text'
> of /usr/lib/libc.a(strtol_l.o): defined in discarded section
> `.gnu.linkonce.r.__strtol_ul_max_tab' of /usr/lib/libc.a(strtoul_l.o)
>
> > > Thx, Heiko.
> > >
> > > > --  There are no patches that I can think of.  If it"s any help, I"m
> > > >  running gentoo.  I"m listing the output of gcc and libc in case my
> > > >  configuration of them might be a problem.
> > > >
> > > >  gcc --version
> > > >  gcc (GCC) 3.3.4 20040623 (Gentoo Hardened Linux 3.3.4-r1,
> > > > ssp-3.3.2-2, pie-8.7.6)
> >
> > Hmm, Gentoo Hardened... I'd like to cross-check this with the other
> > report, but unfortunately I cannot find it. Can you forward it me,
> > please?
>
> This ist'n actually my system. It was some other users post, I found on the
> user mailing-list on your sourceforge project page
> (http://sourceforge.net/mailarchive/message.php?msg_id=10605445 and the
> previous posts). I'm not using the hardened toolchain at all.
Ok, you're not replying to the thread I thought.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
