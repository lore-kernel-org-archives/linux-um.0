Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyynM-0007rB-7D	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2005 14:23:00 -0700
Received: from rimuhosting.com ([69.90.33.248])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1DyynK-0000PZ-SM
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2005 14:23:00 -0700
Received: from [192.168.1.102] (222-153-41-3.jetstream.xtra.co.nz
	[222.153.41.3])	(authenticated bits=0)
	by rimuhosting.com (8.12.8/8.12.8) with ESMTP id j6ULMrTa016121
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 30 Jul 2005 21:22:56 GMT
Message-ID: <42EBEFAC.90208@rimuhosting.com>
From: Peter <peter.spamcatcher@rimuhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] skas v8.2 results
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
Date: Sun, 31 Jul 2005 09:22:52 +1200
To: user-mode-linux-devel@lists.sourceforge.net

Hi.

We tried 2.6.12.3-skas3-v8.2 on a host server.  It kernel paniced (could 
not capture the panic) after about 90 minutes.  I'd tried a 2.6.12 
skasv8.2 a week or so back on another server and got the same result.


2.6.11.12-skas3-v8.2 has been running fine for 20 odd hours.

Has anyone had success with 2.6.12 skas v8.2?  If so I'd be interested 
in a kernel .config.  FWIW our hosts are dual xeons.

Regards, Peter


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
