Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPrIn-0005uG-R9 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Nov 2004 15:46:01 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CPrIm-0006kx-R2 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Nov 2004 15:46:01 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
References: <200411041932.39733.blaisorblade_spam@yahoo.it>
	<30067.1099600259@www73.gmx.net>
In-Reply-To: <30067.1099600259@www73.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411050046.06303.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [uml-user] 2.6.9-bb1, 2.4.27-bs1,
	SKAS3/2.6-V7 released
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
Date: Fri, 5 Nov 2004 00:46:06 +0100
To: jmtx@gmx.net
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Thursday 04 November 2004 21:30, jmtx@gmx.net wrote:
> > You can find all on http://www.user-mode-linux.org/~blaisorblade/.

> > The SKAS3/2.6-v7 was already released, but I probably forgot to announce
> > it.
> > So I'm announcing it now.
> >
> > Changes in SKAS:
> > * echo 0 > /proc/sysemu on the guests works fine, finally!
> >
> > Changes in both 2.6.9 and 2.4.27:

> > they run fine on 2.6.9 host kernels, without hanging at the exit.
Correction 1: for 2.6.9-bb1 (I maybe wasn't clear) and 2.4.27-bs1.
> don't work for me.
> my host is an 2.6.9 and uml is hanging after shutdown.

Which UML version, please? 2.4 or 2.6? I tested the 2.6 one (make sure to do a 
"make clean ARCH=um" before recompiling), but not the 2.4 one yet, maybe.

However, if you have this problem, please make sure you're using Uml 2.6.9-bb1 
and compiling it from a clean tree.

Also, try to see if it is the same kind of hang (which should be solved) or 
another one (which is, indeed, possible to happen).

> > Changes in 2.6.9 only:
> > included a large chunk of JDike tree (excluding all x86_64 related
> > patches),
> > and all the latest security patches from Bodo Stroesser; also it includes
> > the
> > -V7 skas patch in it.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
