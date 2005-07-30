Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dyzxj-00021t-Qt	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2005 15:37:47 -0700
Received: from mail.scgiservices.com ([198.107.3.67])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1Dyzxi-0003Ei-Kf
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2005 15:37:47 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.scgiservices.com (Postfix) with ESMTP id 66A852881C
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 30 Jul 2005 15:37:45 -0700 (PDT)
Received: from mail.scgiservices.com ([127.0.0.1])
 by localhost (mail [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10436-02 for <user-mode-linux-devel@lists.sourceforge.net>;
 Sat, 30 Jul 2005 15:37:42 -0700 (PDT)
Received: from sterling (c-67-160-154-69.hsd1.or.comcast.net [67.160.154.69])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.scgiservices.com (Postfix) with ESMTP id B500C2881A
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 30 Jul 2005 15:37:41 -0700 (PDT)
From: "Anthony Brock" <brocka@sterlingcgi.com>
Subject: RE: [uml-devel] skas v8.2 results
Message-ID: <CBELIFGMBIEPIEOFCJFAIEILCAAA.brocka@sterlingcgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <42EBEFAC.90208@rimuhosting.com>
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
Date: Sat, 30 Jul 2005 15:38:08 -0700
To: user-mode-linux-devel@lists.sourceforge.net

Peter,

I haven't tried 2.6.12. However, I'm now testing v8.2 with 2.6.13-rc4 on one
of our development machines. It's been running for 16 hours without issue.
This is a dual Opteron system running a 32-bit kernel. Have you tried a
vanilla 2.6.12.3 kernel to determine if the issue is with SKAS?

Tony


-----Original Message-----
From: user-mode-linux-devel-admin@lists.sourceforge.net
[mailto:user-mode-linux-devel-admin@lists.sourceforge.net]On Behalf Of
Peter
Sent: Saturday, July 30, 2005 2:23 PM
To: user-mode-linux-devel@lists.sourceforge.net
Subject: [uml-devel] skas v8.2 results


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



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
