Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQ9eW-0005H9-Ha for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Nov 2004 11:21:40 -0800
Received: from alyz.com ([66.220.1.229])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CQ9eW-0007ga-3C for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Nov 2004 11:21:40 -0800
From: Allen Chan <alydar@users.sourceforge.net>
Subject: Re: [uml-devel] 2.6.9-bb1, 2.4.27-bs1, SKAS3/2.6-V7 released
References: <200411041932.39733.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411041932.39733.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411051421.47632.alydar@users.sourceforge.net>
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
Date: Fri, 5 Nov 2004 14:21:47 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>

I just compiled a  2.6.9 + uml-2.6.9-bb1.patch.bz2 guest kernel, but 
it hangs on my system immediately after:

 ...
 Initializing software serial port version 1
 Using anticipatory io scheduler
  /dev/ubd/disc0: unknown partition table
 Initializing stdio console driver

My host kernel is 2.6.9-skas-v7 on Debian unstable.  My previous guest 
kernel (2.6.9 + JDike Incrementals + ptrace() hang patch) works 
flawlessly under the same conditions.

The http://www.user-mode-linux.org/~blaisorblade/ site appears to be 
inaccessible at this moment.  When the site comes back up, 
I will try to play with the broken out version of the 2.6.9-bb1 
patches to see if the cause of this problem can be isolated.

On Thursday 04 November 2004 01:32 pm, Blaisorblade wrote:
> You can find all on http://www.user-mode-linux.org/~blaisorblade/.
> Any testing and report is welcome.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
