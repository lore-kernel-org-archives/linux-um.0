Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BEMyy-0002h1-Te for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Apr 2004 23:37:48 -0700
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]
	helo=ms-smtp-03-eri0.texas.rr.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BEMyy-0002U4-Hr for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 15 Apr 2004 23:37:48 -0700
Received: from austin.rr.com (cs6668173-121.austin.rr.com [66.68.173.121])
	by ms-smtp-03-eri0.texas.rr.com (8.12.10/8.12.7) with ESMTP id
	i3G6auo7001065 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 16 Apr 2004 01:36:56 -0500 (CDT)
Message-ID: <407F7EFF.5060106@austin.rr.com>
From: Steven Elliott <selliott4@austin.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Problems with the SKAS patch and 2.6
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
Date: Fri, 16 Apr 2004 01:36:47 -0500
To: User Mode Linux Devel <user-mode-linux-devel@lists.sourceforge.net>

I'd like to first thank you for creating a very valuable kernel 
debugging tool.  I wish more people knew about UML as a means of 
learning about how kernels work.

I may be overlooking something, but as far as I can tell it is not 
currently possible to apply any of the SKAS patches to 2.6.

The host-skas3.patch patch has several conflicts when applied to 2.6.  I 
attempted to manually port host-skas3.patch to 2.6, but I ran into a 
missing file or function (unfortunately I can remember what it was).

Also, it is not obvious what host-skas-2.6.0-test1.diff should be 
applied to.  It seems to somehow depend on code added by the 
host-skas3.patch patch, but first applying the host-skas3.patch patch is 
not sufficient.  If someone could regenerate host-skas-2.6.0-test1.diff 
such that it can be applied to a straight 2.6 kernel that would be very 
helpful.

Right now I'll assume that there are some technical problems with 
porting SKAS to 2.6, so it is not just a simple matter of shuffling code 
from the host-skas3.patch patch to the corresponding place in 2.6.

Also, my experience has been that debugging with GDB works better when 
SKAS mode is used.  So, you might want to mention that in either the 
SKAS page or the debugging page.

-- 
-----------------------------------------------------------------------
|          Steven Elliott          |      selliott4@austin.rr.com     |
-----------------------------------------------------------------------



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
