Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOpvd-0002vr-0O	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 22:10:25 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EOpvi-0002eS-B0
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 22:10:31 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Blank process command lines in 2.6.13.2?
References: <200510091623.34322.rob@landley.net>
	<20051010020617.GC10677@ccure.user-mode-linux.org>
In-Reply-To: <20051010020617.GC10677@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510100010.10951.rob@landley.net>
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
Date: Mon, 10 Oct 2005 00:10:10 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Sunday 09 October 2005 21:06, Jeff Dike wrote:
> On Sun, Oct 09, 2005 at 04:23:34PM -0500, Rob Landley wrote:
> > 19874 pts/1    T+     0:00
> > 19968 pts/1    T+     0:00
> > 19979 pts/1    T+     0:00
> > 19981 pts/1    T+     0:04
> > 19983 pts/2    R+     0:00 ps ax
> >
> > *boggle*
> >
> > This expected?
>
> Yeah, it's not unexpected.  The host tasks for UML processes inherit the
> arglist address from UML, but UML has completely redone their address
> spaces, so those addresses don't point at arguments any more.

Any likelihood that at some point in the future it could accidentally point to 
something it would be a bad idea to display?

Rob


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
