Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DIDt0-0006ZO-56 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Apr 2005 15:48:06 -0700
Received: from rimuhosting.com ([69.90.33.248])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DIDsx-00063J-C5
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Apr 2005 15:48:06 -0700
Received: from [192.168.1.102] (222-152-12-226.jetstream.xtra.co.nz
	[222.152.12.226]) (authenticated bits=0)
	by rimuhosting.com (8.12.8/8.12.8) with ESMTP id j33MluUk006803
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 3 Apr 2005 22:48:00 GMT
Message-ID: <4250729B.7040407@rimuhosting.com>
From: Peter <peter.spamcatcher@rimuhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 2.6.9-bs7 panic on check_sysemu
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
Date: Mon, 04 Apr 2005 10:47:55 +1200
To: user-mode-linux-devel@lists.sourceforge.net

I get this error starting up a 2.6.9-bs7 guest:

Checking syscall emulation patch for ptrace...<0>Kernel panic - not 
syncing: check_sysemu : expected SIGTRAP, got status = 256

The host is 2.6.8.1 with host-skas3-2.6.7-v2.patch.

The 2.6.9-bs7 kernel runs OK on my newer host kernels.

Is this a case where I should be upgrading my host kernels (will do that 
in time anyway)?

Or is there something that can be done on the guest to make it work on 
older kernels also?

Regards, Peter



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
