Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AJrJx-0004Z7-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 12 Nov 2003 01:29:53 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AJrJc-0004pc-UB
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 12 Nov 2003 01:29:33 -0800
From: M A Young <m.a.young@durham.ac.uk>
In-Reply-To: <200309172018.h8HKIjNu020871@ccure.karaya.com>
Message-ID: <Pine.GSO.4.58.0311120922330.5371@algedi.dur.ac.uk>
References: <Pine.GSO.4.53.0309102139120.9641@altair.dur.ac.uk>
 <Pine.GSO.4.53.0309122031300.4368@altair.dur.ac.uk> 
 <Pine.GSO.4.53.0309161720480.4325@algedi.dur.ac.uk> 
 <200309172018.h8HKIjNu020871@ccure.karaya.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: uml segfaults on fedcore core 1 (was redhat beta "severn")
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
Date: Wed, 12 Nov 2003 09:29:21 +0000 (GMT)
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

On Wed, 17 Sep 2003, Jeff Dike wrote:

> m.a.young@durham.ac.uk said:
> > The exec-shield code appears to have been modified in the latest
> > redhat beta kernel with the result that uml kernels no longer crash -
> > presumably the memory allocations aren't stirred up quite so much.
> > Hence patching this problem may now be unnecessary.
>
> Excellent.  I looked at mingo's original description briefly, and didn't see
> anything which would obviously break UML.

I think these are back, my current theory is that you see this if you
build your kernel on fedora core (ie. with exec-shield aware gcc). I will
investigate further, and recheck my test patch, but I think the workaround
echo 0 >/proc/sys/kernel/exec-shield-randomize
on the host kernel should avoid the problem for the moment.

	Michael Young


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
