Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AT9M0-0002zT-72
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 07 Dec 2003 16:34:24 -0800
Received: from tektonic.net
	([69.56.241.195] helo=unix.easyadmin ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AT9Lz-0007rw-PK
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 07 Dec 2003 16:34:23 -0800
Subject: Re: [uml-devel] Workaround for bug #851759 -  SuSE YAST in
	textmode does not work
From: Matt Ayres <matta@tektonic.net>
In-Reply-To: <055801c3bd22$f1a1b3f0$2000000a@schlepptopp>
References: <055801c3bd22$f1a1b3f0$2000000a@schlepptopp>
Content-Type: text/plain
Message-Id: <1070843660.31073.84.camel@wopr.tektonic.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 07 Dec 2003 19:34:21 -0500
To: roland <for_spam@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>, Gerd Knorr <kraxel@bytesex.org>

I don't know about llseek, but access to /dev/random seems to be VERY
slow from within UML.

On Sun, 2003-12-07 at 19:33, roland wrote:
> Hi !
> I found a better workaround:
> 
> digging deeper into yast, i found that yast (fortunately) uses a special "ycp" Scripting language. A menu-entry in
> yast consinsts of several ycp modules. a module, which loads quite often is the module "Arch.ycp". with that, yast seems to detect,
> which hardware architecture it`s running on.
> unfortunately, the detection within uml doesn`t seem to work correctly and results in the hanging "y2base"(seems to be the ycp
> "interpreter") process. i can supply more detailed strace output. y2base receives SIGSEGV after a fork (but still keeps running).
> 
> as a workaround, i would like to recommend the following:
> 
> edit /usr/share/Yast2/modules/Arch.ycp
> 
> and replace the line
> "list systemProbe = SCR:Read(.probe.system);"
> with
> "list systemProbe = nil;"
> 
> that works for me and fixes a lot of the "hanging" in yast.
> unfortunatly, starting the software-installation-module in yast is VERY slow under uml, when it reads the package information.
> strace (works inside uml, after all) shows me, that there are LOTS of seeks (was it llseek? must look again). is llseek known to be
> "extra slow" within uml and can be called a "worse case" ?
> 
> btw: what would be a better solution: asking the suse people to make yast "uml-aware" or fixing those things inside uml?
> 
> gerd, since i seem to be not the only person to experience this problem, perhaps you could add my solution to the suse uml-howto at
> http://www.suse.de/~kraxel/uml/howto.html, if you find it useful ? (btw: i had done the suse9 setup with the uml-suse-install
> script)
> 
> regards
> roland
> 
> 
> >Date: 2003-12-05 10:26
> >Sender: nobody
> >Logged In: NO
> >
> >I have seen a similar bug with YaST using SuSE8.2 running
> >under UML. I don't know a fix, but I do know a work around:
> >
> >Login via ssh, run top, locate the process that is consumming
> >most of the CPU cycles and send it a SIGHUP. Once the signal
> >is sent, YaST recovers and the CPU cycles drop to normal.
> >
> >But here is the strange thing, Sometimes, usually the first
> >attempt, it is only necessary to make the ssh connection to
> >recover the box. But on subsequent invocations of YaST, only
> >the signal will do.
> 
> 
> ----- Original Message ----- 
> From: "roland" <for_spam@gmx.de>
> To: <user-mode-linux-devel@lists.sourceforge.net>; "uml-user" <user-mode-linux-user@lists.sourceforge.net>
> Sent: Monday, December 01, 2003 12:03 AM
> Subject: bug: [ 851759 ] SuSE YAST in textmode does not work
> 
> 
> > Hi,
> > i have submitted a bugreport related to yast:
> > http://sourceforge.net/tracker/index.php?func=detail&atid=100429&aid=851759&group_id=429
> > i don`t know if it`s a yast bug or if it`s a uml bug - but the effect is, that yast isn`t really usable inside an uml. did others
> > experience this bug?  comments?
> >
> > regards
> > roland
> >
> > ps:
> > it is important for me to fix this, because if i setup uml`s for my users, the first thing they will do is firing up yast to
> install
> > packages. so - this is an essential tool which should work correct.
> >
> > pps:
> > sorry for flooding uml-lists with so many posts - but i had just some time this weekend :D
> >
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
-- 
Matt Ayres <matta@tektonic.net>
TekTonic



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
