Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BAvM7-0002oW-Jj for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Apr 2004 11:31:27 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BAvM7-0001ZM-9A
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Apr 2004 11:31:27 -0700
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157])
	by externalmx-1.sourceforge.net with esmtp (Exim 4.30)
	id 1BB2s3-0007jD-2r for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Apr 2004 19:32:55 -0700
Received: from zbl6c012.us.nortel.com (zbl6c012.corpeast.baynetworks.com
	[132.245.205.62])
	by zcars0m9.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with ESMTP
	id i36ITce21832 for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 6 Apr 2004 14:29:39 -0400 (EDT)
Message-ID: <4072F711.8030209@nortelnetworks.com>
From: Joe Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] klogd stimulates kernel panic w/ 2.4.24-1
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
Date: Tue, 06 Apr 2004 14:29:37 -0400
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I saw some posts which mentioned problems with crashes which were 
stimulated by using klogd. I am using 2.4.24-1 uml patch and appear to 
having this problem. I disabled klogd and the crashes went away...

There was also mention of a code fix in UML...which would be preferable 
since I like klogd :)

Is there a patch for 2.4.24 which supports this?

thanks for any info, Giovanni Marzot (GSM)



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
