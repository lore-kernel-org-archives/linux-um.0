Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A7u1R-0003vz-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 10 Oct 2003 02:57:21 -0700
Received: from fzkmail2.fzk.de ([141.52.27.52])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A7u1Q-000337-KP
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 10 Oct 2003 02:57:20 -0700
From: Ariel Garcia <garcia@iwr.fzk.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200310101154.42262.garcia@iwr.fzk.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Grsec?
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
Date: Fri, 10 Oct 2003 11:57:15 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I would like to run both the skas patch and the GRsecurity
(http://www.grsecurity.net/) patches in the host kernel. (The performance
is _way_ better using skas, and i really like some grsec features)

I've tried merging both patches already (using 2.4.21, applying first
grsec, then skas, then solving a few conflicts) but then got
init killed upon booting  ;-)   Obviously you have to know what you are
doing... even if from the merging the result seemed to be "reasonable" and
took only 30 mins.  ;-P

Do you have any comments of how feasible it would be, etc?

Thanks a lot, regards,
Ariel

PS: please CC directly to me also as i am not subscribed to this list.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
