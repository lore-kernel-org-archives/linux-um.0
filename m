Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cxpq1-000549-Sx for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Feb 2005 09:04:45 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cxppy-0004Qq-Ph for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Feb 2005 09:04:44 -0800
Message-Id: <200502061850.j16Io3Uv003239@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Xen going to be in Kernel 2.6 soon? 
In-Reply-To: Your message of "Sat, 05 Feb 2005 02:45:24 +0100."
	<cu189b$vnr$1@sea.gmane.org> 
References: <cu189b$vnr$1@sea.gmane.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Sun, 06 Feb 2005 13:50:02 -0500
To: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

skoehler@upb.de said:
> according to the german news-magazine heise.de, Xen will be in Kernel
> 2.6 soon. 

What Linus is quoted as saying is that it will go into 2.6.  This is consistent
with Xen going into 2.6.47 or something.  I don't get the feeling that it
will go in soon because aspects of the design are fairly controversial.

> I feel like this is a slap in Jeff's face, since i thought
> that UML will be developed as the first choice in virtualizations
> techniques. 

UML has never has any sort of privileged status.  Never has, never will.
Everything has to compete on its merits.  

> I also thought, that UML will perhaps soon be as fast as
> Xen  since SKAS4 is on horizon.

skas4 is an interface change, not a speedup.  As far as speed goes, I have
a bunch of nice things in my current patchset, like skas0, system call and
tlb flushing optimizations.  Also, we (me and some other Intel people) are
working on having UML support Intel's VT virtualization extensions, which
will bring it much closer to hardware speed.

So, as Rob Landley pointed out, except with much more sarcasm, the sky is
not falling.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
