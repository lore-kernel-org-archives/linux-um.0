Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A4zo7-0006Yv-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 02 Oct 2003 02:31:35 -0700
Received: from cimice4.lam.cz ([212.71.168.94] helo=vagabond.light.src)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A4zo6-00089P-99
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 02 Oct 2003 02:31:34 -0700
From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [uml-devel] Re: pthreads?
Message-ID: <20031002093128.GB3512@vagabond>
References: <20031002090834.GS24534@vagabond> <Pine.GSO.4.21.0310021112020.8567-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0310021112020.8567-100000@vervain.sonytel.be>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 2 Oct 2003 11:31:28 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Gerd Knorr <kraxel@bytesex.org>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Oct 02, 2003 at 11:24:11 +0200, Geert Uytterhoeven wrote:
> On Thu, 2 Oct 2003, Jan Hudec wrote:
> > On Fri, Sep 12, 2003 at 11:07:54 +0200, Geert Uytterhoeven wrote:
> > > BTW, it's libX11 that needs libpthread...
> > 
> > bulb@vagabond:~$ ldd /usr/X11R6/lib/libX11.so.6.2 
> > 	libdl.so.2 => /lib/libdl.so.2 (0x400d5000)
> > 	libc.so.6 => /lib/libc.so.6 (0x400d8000)
> > 	/lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x80000000)
> > 
> > Not see libpthread anywhere around!
> > 
> > However, I just checked gmodule and glib and neither seems to report
> > libpthread either!
> 
> ldd instead doesn't show it, but nm does:

GEEE, so fend of the LAST argument in that mail, which said:

I *RAN* a simple Gtk2.0 application, greped it's /proc/<pid>/maps for
string "pthr" and DIDN'T FIND IT. Which means, that during execution of
that applications, libpthread WAS NOT IN MEMORY.

If you thing it does not have to be there, well, I also greped strace of
the application for the same string an it was not there. And all
libraries are actualy _OPEN_ during execution. So neither was it ever
READ in memory.

Still don't consider that a sufficient proof it is NOT THERE?

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
