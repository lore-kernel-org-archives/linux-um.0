Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ACr13-0002hh-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 23 Oct 2003 18:45:26 -0700
Received: from h65s138a81n47.user.nortelnetworks.com ([47.81.138.65] helo=zsc3s004.nortelnetworks.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1ACi4O-0001wq-Tc
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 23 Oct 2003 09:12:16 -0700
Message-ID: <3F97FD98.10700@nortelnetworks.com>
From: Giovanni Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
References: <3F97E849.1090700@nortelnetworks.com> <1066924964.12497.2.camel@ixodes.goop.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 23 Oct 2003 12:11:04 -0400
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

Thank you for the reply.

Jeremy Fitzhardinge wrote:
> On Thu, 2003-10-23 at 07:40, Giovanni Marzot wrote:
> 
>>Can anyone confirm if the patches to valgrind mentioned below have found 
>>there way into the release?
> 
> 
> They haven't.  They were mostly slimy hacks to see what needed fixing,
> rather than proper fixes.  The good news is that I've been busily
> incorporating proper fixes and redesigns into Valgrind, so the
> development version should be capable of running uml unpatched soon.

hmmm...Should I wait until this is done or is there something I can try 
in the meantime.

Are the old patches even available anywhere?

If you have something you would like me to try out (even if its grungy) 
I would be happy to give it a whirl.

> 
> 
>>I wonder what "teaching valgrind about the false positives" entails.
> 
> 
> Not everything Valgrind reports is an error.  You can either generate a
> suppression rule to tell V not to report it, or you can use annotations
> in your program to tell V what's really going on.

cool.

-GSM

> 
> 	J
> 





-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
