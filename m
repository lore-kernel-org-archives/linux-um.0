Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HFGPS-0006tD-Js for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 13:02:26 -0800
Received: from ug-out-1314.google.com ([66.249.92.172])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HFGPS-0006TV-3n
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 13:02:26 -0800
Received: by ug-out-1314.google.com with SMTP id z38so584087ugc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 08 Feb 2007 13:02:17 -0800 (PST)
Message-ID: <84144f020702081302x351a9937ofc6e722b5c5cada3@mail.gmail.com>
Date: Thu, 8 Feb 2007 23:02:11 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
In-Reply-To: <20070208195711.GA6607@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <E1HFEIB-0000nJ-00@dorka.pomaz.szeredi.hu>
	<20070208195711.GA6607@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] UML hang with 100% CPU
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Miklos Szeredi <miklos@szeredi.hu>

Hi,

On Thu, Feb 08, 2007 at 07:46:47PM +0100, Miklos Szeredi wrote:
> > It boots fine, then usually just after logging in and before starting
> > the shell (but sometimes after the shell started) it gets into some
> > loop.  Looking at the strace shows that two processes are
> > sending/receiving single '\0' bytes on some sockets endlessly.
> >
> > Does this ring a bell?

On 2/8/07, Jeff Dike <jdike@addtoit.com> wrote:
> No, it doesn't.  This is a strace on the host, I take it?
>
> Can you get backtraces from the processes?

Just a datapoint: I had a similar problem with UML hanging on
2.6.20-rc something _host_ kernel whereas 2.6.19 worked fine. That was
with Gentoo userspace which I don't have anymore.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
