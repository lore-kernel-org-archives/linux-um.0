Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOjnc-0002KI-HW	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 15:37:44 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EOjng-0003N8-21
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 15:37:48 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Found the problem...
References: <200510090054.07750.rob@landley.net>
	<200510092106.00389.blaisorblade@yahoo.it>
In-Reply-To: <200510092106.00389.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510091737.36983.rob@landley.net>
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
Date: Sun, 9 Oct 2005 17:37:36 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sunday 09 October 2005 14:06, Blaisorblade wrote:
> On Sunday 09 October 2005 07:54, Rob Landley wrote:
> > When attempting to stat a nonexistent file, 2.6.11 returned a consistent
> > value in st_mode (BFFFF73C, every time), and 2.6.13 is returning random
> > crap that varies from invocation to invocation.  Hence the intermittent
> > failure.
> >
> > We _should_ be checking the error return value from lstat64() before
> > looking at S_ISDIR(), and I'll fix it.  Almost certainly, the value in
> > there is random garbage off the stack, and 2.6.13 simply has different
> > random garbage on the stack.
> >
> > So it's not your problem...
>
> Just to be sure: UML _does_ return an error code from lstat64, right? If
> not, complain again please.

Yeah, it does.  UML is ok.  The check was missing in busybox (I checked in a 
fix to -devel last night, I'll clean it up in 1.0.2 when I release that later 
this week).

The fixed version lasted over 1000 iterations of my testcase, whereas the 
previous version usually barfed somewhere in the first couple dozen.  Looks 
good.

Rob

P.S. Apparently, busybox's not checking the return value bug was in there for 
22 months (introduced in revision 8006, Nov 27, 2003, long before the 1.0 
release) without ever causing a problem.  Go figure.  And even now it only 
manifests under uclibc (not glibc), and even _then_ it's highly intermittent.

And you wonder why I'm working on an automated regression test suite in my 
Copious Free Time (tm)?


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
