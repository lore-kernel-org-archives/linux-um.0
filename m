Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CxGPd-0006ZL-HX for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 19:15:09 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CxGPc-0002Uw-RP
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 19:15:09 -0800
From: Rob Landley <rob@landley.net>
Subject: Sky, comma,
	falling.  (Was Re: [uml-devel] Xen going to be in Kernel 2.6 soon?)
References: <cu189b$vnr$1@sea.gmane.org>
In-Reply-To: <cu189b$vnr$1@sea.gmane.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-15"
Message-Id: <200502042113.13876.rob@landley.net>
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
Date: Fri, 4 Feb 2005 21:13:13 -0500
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Sven =?iso-8859-15?q?K=F6hler?= <skoehler@upb.de>

On Friday 04 February 2005 08:45 pm, Sven K=F6hler wrote:
>  I feel like this is a slap in Jeff's face, since i thought=20
> that UML will be developed as the first choice in virtualizations=20
> techniques.

Yup, just like the inclusion of reiserfs in the kernel is a slap in the fac=
e=20
to ext3.  Obviously they did it just to be insulting, didn't you read Linus=
's=20
"I'm a bastard" speech?

> So what is it all about? When should somebody chose Xen, and when should
> somebody chose UML? and how will UML and Xen compete?

You know, ever since the release of the BSD source code in 1992 totally=20
derailed that "Linux" project people were playing with back then, this kind=
=20
of question has become vitally important.  The release of any remotely=20
similar project obviously can immediately halt all development of establish=
ed=20
projects that developers have sunk years of effort into, and they immediate=
ly=20
start porting over things like the COW mounts and hostfs and honeypot procf=
s,=20
and rewrite all the existing tutorials and retrain everybody overnight to=20
work on the new as yet untested thingy that hasn't been particularly debugg=
ed=20
yet.

Especially in a case like this, where Xen actually competes with VMWare rat=
her=20
than UML.  Obviously, UML is doomed.  What with Xen requiring a modified ho=
st=20
kernel to provide its virtualization environment whereas UML uses the proce=
ss=20
abstraction to virtualize it: I mean, who's going to use _processes_ in fiv=
e=20
years, will future kernels even bother to support them?  Sure, UML not only=
=20
runs on an unmodified Linux kernel (even running a 2.6 UML on a 2.2 host=20
kernel), and even an effort underway to get it running on windows (who know=
s=20
why, but a MacOS X host can only be a matter of time), but that just means =

maybe it can scrape on some tiny niches once it's driven off Linux by this =

new "Adeos" thing...  Er, I mean "Plex86"...  Um...  "Xen", that's it.  And=
=20
obviously its original use as a Linux development tool letting you do thing=
s=20
like create a filesystem driver and mount an instance of it without=20
destablizing your host kernel, or run bits of the kernel under normal=20
userspace debugging tools...  Well, we're well rid of that, aren't we?  And=
=20
being to swap kernel memory to backing store just like a regular applicatio=
n,=20
that was obviously a bad idea from day one...

Why was the question interesting again?

Rob


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
