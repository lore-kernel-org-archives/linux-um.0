Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJIw6-0003Az-JE for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 Oct 2004 14:51:30 -0700
Received: from main.gmane.org ([80.91.229.2])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CJIw5-00033T-2r for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 Oct 2004 14:51:30 -0700
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CJIw2-0004Vh-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 17 Oct 2004 23:51:26 +0200
Received: from host-12-107-230-171.dtccom.net ([12.107.230.171])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 17 Oct 2004 23:51:26 +0200
Received: from srivasta by host-12-107-230-171.dtccom.net with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 17 Oct 2004 23:51:26 +0200
From: Manoj Srivastava <srivasta@ieee.org>
Message-ID: <878ya5yu70.fsf@glaurung.internal.golden-gryphon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] A recipe for building SELinux enabled UML kernsls and
	Root FS
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
Date: Sun, 17 Oct 2004 15:18:43 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net

Hi,

        I was trying to set up a UML guest that would be able to run
 SELinux, and I discovered that there were no pre-packaged solutions
 out there. Not only that, I found that I had to struggle quite a bit
 to put something like that together -- and I am not quite a kernel
 compilation newbie.

	I have put together a recipe page (not quite a HOWTO, of
 which there are several excellent examples out there) at 
 <URL:http://www.golden-gryphon.com/software/security/selinux-uml.xhtml>
 This is not a general HOWTO document, it is instead a step by step
 procedure that can be followed to generate a SELinux capable UML.

	The root_fs generation step is Debian specific, but there rest
 of it should be distribution agnostic.

	Hope this helps.

	manoj
-- 
Actual war is a very messy business.  Very, very messy business. Kirk,
"A Taste of Armageddon", stardate 3193.0
Manoj Srivastava     <srivasta@acm.org>    <http://www.golden-gryphon.com/>
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
