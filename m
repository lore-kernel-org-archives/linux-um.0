Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AD2X3-0001xZ-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 24 Oct 2003 07:03:16 -0700
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net
	([206.170.148.147] helo=gw.goop.org ident=firewall)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1ACiTr-00045V-UN
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 23 Oct 2003 09:38:36 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
In-Reply-To: <3F97E849.1090700@nortelnetworks.com>
References: <3F97E849.1090700@nortelnetworks.com>
Content-Type: text/plain
Message-Id: <1066924964.12497.2.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Valgrind meets UML
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
Date: Thu, 23 Oct 2003 09:02:44 -0700
To: Giovanni Marzot <gmarzot@nortelnetworks.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, 2003-10-23 at 07:40, Giovanni Marzot wrote:
> Can anyone confirm if the patches to valgrind mentioned below have found 
> there way into the release?

They haven't.  They were mostly slimy hacks to see what needed fixing,
rather than proper fixes.  The good news is that I've been busily
incorporating proper fixes and redesigns into Valgrind, so the
development version should be capable of running uml unpatched soon.

> I wonder what "teaching valgrind about the false positives" entails.

Not everything Valgrind reports is an error.  You can either generate a
suppression rule to tell V not to report it, or you can use annotations
in your program to tell V what's really going on.

	J



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
