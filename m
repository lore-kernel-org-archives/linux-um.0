Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Al0bE-0000Rm-O6 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Jan 2004 22:51:56 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AkB6Y-0002Wn-Cj for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Jan 2004 15:52:50 -0800
From: M A Young <m.a.young@durham.ac.uk>
In-Reply-To: <Pine.LNX.4.58.0401232125410.8188@vega.dur.ac.uk>
Message-ID: <Pine.GSO.4.58.0401232342360.24271@altair.dur.ac.uk>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<bu0gnf$ief$1@sea.gmane.org> <87y8sbbrup.fsf@bytesex.org>
	<200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
	<20040118162112.GA15509@elte.hu>
	<20040118235730.GC21046@ccure.user-mode-linux.org>
	<20040119075351.GA4088@elte.hu> <20040119082805.GA4412@elte.hu>
	<Pine.GSO.4.58.0401200008240.6442@altair.dur.ac.uk>
	<20040120002301.GA5708@elte.hu>
	<Pine.LNX.4.58.0401232125410.8188@vega.dur.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: tt mode tls/glibc crash with 2.6 (Was: Re:
	uml-patch-2.6.0)
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
Date: Fri, 23 Jan 2004 23:52:33 +0000 (GMT)
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeff Dike <jdike@addtoit.com>, Gerd Knorr <kraxel@bytesex.org>, user-mode-linux-devel@lists.sourceforge.net

On Fri, 23 Jan 2004, M A Young wrote:

> I now know where 0xbeffe018 comes from. The endless segfault is triggered
> from line 1256 of elf/rtld.c in the glibc code (1252-1258 are shown from
> RedHat's glibc-2.3.2-101.4.i686.rpm package)
>
> #ifdef NEED_DL_SYSINFO
>   if (GL(dl_sysinfo_dso) != NULL)
>     {
>       /* We have a prelinked DSO preloaded by the system.  */
>       GL(dl_sysinfo) = GL(dl_sysinfo_dso)->e_entry;
>
>       /* Do an abridged version of the work _dl_map_object_from_fd would do
>
>
> GL(dl_sysinfo_dso) is _dl_sysinfo_dso, _rtld_local._dl_sysinfo_dso or
> _rtld_global._dl_sysinfo_dso according to context
>
> _dl_sysinfo_dso=0 is at 0xa0603f50
> _rtld_local._dl_sysinfo_dso=0xbeffe000 is at 0x40015454
> _rtld_global._dl_sysinfo_dso=0xbeffe000 is at 0x40015454
>
> so I am guessing that _rtld_{local,global}._dl_sysinfo_dso should have
> been initialized from _dl_sysinfo_dso but wasn't. This could be a glibc
> bug, though I haven't looked closely enough to be sure.

Further checking shows that _rtld_global._dl_sysinfo_dso is set from the
value of AT_SYSINFO_EHDR passed by the kernel. So UML tt mode is broken
because it doesn't seem to pass this value. However glibc is also broken,
because it should set _rtld_global._dl_sysinfo_dso=NULL by default in case
AT_SYSINFO_EHDR isn't passed to it by the kernel.

Anyway, I intend to test whether this is the problem tomorrow, either by
recompiling glibc (it is a one-line fix), or possibly using a hex editor
to hack the existing ld.so.

	Michael Young


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
