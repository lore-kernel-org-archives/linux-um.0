Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DshYC-0004di-4G	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 06:45:24 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.44)
	id 1DshYA-00010f-Ih	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 06:45:24 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <F47F4E3B83BE854AA0BCB998C69295169D2BB4@tiki.fastmail.usf.edu>
In-Reply-To: <F47F4E3B83BE854AA0BCB998C69295169D2BB4@tiki.fastmail.usf.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507131552.48095.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [uml-user] RE: 2.6.12-bb2-skas0 hanging after INIT
	(CORRECTION PREVIOUS POST)
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
Date: Wed, 13 Jul 2005 15:52:47 +0200
To: user-mode-linux-user@lists.sourceforge.net
Cc: "Gaspar, Alessio (USF Lakeland)" <alessio@lklnd.usf.edu>, user-mode-linux-devel@lists.sourceforge.net

On Tuesday 12 July 2005 20:15, Gaspar, Alessio (USF Lakeland) wrote:
> > On Tuesday 12 July 2005 18:45, Gaspar, Alessio (USF Lakeland) wrote:
> > > err... please read 2.6.12-bb2-skas0 in my previous post instead of
> > > 2.6.12-bs1-skas0. I did try too many patches lately :)
> >
> > Granted, but what about using plain -bs1? SKAS0 is still development
>
> code
>
> > (and
> > I'm not very acquainted with it), so I would avoid it in case of
>
> problems.
>
> > After that, UML has not a lovely relation with 2.6.10 and 2.6.9, so if
>
> you
>
> > can
> > go to either 2.6.8.1 or 2.6.11 it would be mairveillous...
>
> Sorry can't do (trust me I'd prefer too :)
> I just browsed again openSSI.org and we need their 1.9.x version which,
> of course, is based on 2.6.10.
>
> Concerning 2.6.12-bs1, I already tried it before but, since I couldn't
> recall what went wrong, I re-compiled the guest uml kernel using this
> time various options (support for SKAS and/or TT) and re-tested the
> whole thing
>
> Each version was compiled by doing a
> make ARCH=um mrproper
> make ARCH=um defconfig
> make ARCH=um menuconfig (to edit changes between trials)
> make ARCH=um linux
>
> Summary of results
>
> SKAS + TT			./linux-tt-skas
> hangs
> 				./linux-tt-skas mode=tt		hangs
> TT only			./linux-tt 				hangs
>
>
> In all cases, boot hangs on sleeping process gets unexpected signal 10
Ok, now let's wait a moment. Can you run, on the same machine, a vanilla 
kernel (even 2.6.10) and verify on that if TT mode works?

Nobody has ever seen this kind of crash, so I want to see if it's userspace 
related (some strange GCC/glibc/headers problem) or if it's the kernel 
triggering it (either a bug in SSI, or a bug of UML which is only triggered 
in that environment). I say "some machine" because distro differences could 
be part of the picture.

Btw, is the host being part of a cluster at the testing moment or not?

Also, on the community page there's a link about these setups (CILinux seems 
related with OpenSSI, if not the same thing):

http://usermodelinux.org/modules.php?name=News&file=article&sid=185

Btw, is OpenSSI purpose anyhow different from OpenMosix one or not? Just as a 
curiosity about OpenSSI (I'd like to understand a bit more what it does, I'm 
seeing the "features" page).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
