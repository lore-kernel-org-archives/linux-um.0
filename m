Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ACjaT-0002zy-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 23 Oct 2003 10:49:29 -0700
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1ACjaF-0004zV-Br
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 23 Oct 2003 10:49:15 -0700
Message-ID: <3F97E849.1090700@nortelnetworks.com>
From: Giovanni Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
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
Date: Thu, 23 Oct 2003 10:40:09 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jeremy@goop.org

Hi,

I see this email below...

Can anyone confirm if the patches to valgrind mentioned below have found 
there way into the release?

I will be attempting this with 2.4.20-6um.

Any words of wisdom appreciated. Has anyone used this combination 
succesfully?

I wonder what "teaching valgrind about the false positives" entails.

thanks for any info, GSM

 >bulb@ucw.cz said:
 >> Is it possible to run 2.4.20-3um (or -4um - I have not got around to
 >> updating yet) under valgrind?
 >>
 >> Does it need some specific config options to work?
 >
 >Any recent UML is as valgrindable as the UML mentioned in the post you 
 >saw.
 >
 >You need CONFIG_MODE_SKAS, !CONFIG_MODE_TT, and 
 >CONFIG_KERNEL_STACK_ORDER=3.
 >
 >You also probably need some valgrind patches unless the stuff I and 
 >Jeremy
 >have done have been merged into valgrind CVS.
 >
 >Once valgrind is working, you need to go through the false positives and
 >teach valgrind about how the kernel deals with memory allocation.  This is
 >the point at which I stopped.




-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
