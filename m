Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoueL-0004k2-VM
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 05 Feb 2004 17:19:17 -0800
Received: from mout1.freenet.de ([194.97.50.132] ident=exim)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AoueL-0002Jc-4Y
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 05 Feb 2004 17:19:17 -0800
From: Michael Koehne <kraehe@copyleft.de>
Message-ID: <20040206011916.GA15577@bakunin.copyleft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] linux 2.6.1 skas host on libretto laptop
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
Date: Fri, 6 Feb 2004 02:19:16 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: sdw@lig.net

Moin Stephen, Jeff and other UML Guru's,

  i'm happy that my "pocket mainframe" is now able to not only z/Linux
  with Hercules, but also UML with SKAS - in a much better performance!
  The libretto was unable to run UML as I needed 2.5 and 2.6 kernels to
  support power manangent and other features.

  Thanks to Stephen D. Williams: I applied the patch he posted at
  uml-devel on Sat, 10 Jan 2004 on Wed Feb 4 2004 and it worked out
  of the box to run a backup of my site (www.copyleft.de is running
  in UML for over a year - unfortunately its running at home with a
  slow DSL line currently ;) so - what next ?

  - linux 2.6.2 is out (or will be real soon now)
  - some patches over this patch fixed bugs - and I was just lucky
    not to run into one of the well known bugs.
  
  where to pick the next most actual version of 2.6.x-skas patch ?

Bye Michael
-- 
  mailto:kraehe@copyleft.de             UNA:+.? 'CED+2+:::Linux:2.4.22'UNZ+1'
  http://www.xml-edifact.org/           CETERUM CENSEO WINDOWS ESSE DELENDAM


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
