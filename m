Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZi5x-0001xp-2c for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Dec 2004 19:57:29 -0800
Received: from rimuhosting.com ([69.90.33.248])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CZi5w-0002rW-EV
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Dec 2004 19:57:29 -0800
Received: from [192.168.0.4] (office.rimuhosting.co.nz [222.152.52.159] (may
	be forged)) (authenticated bits=0)
	by rimuhosting.com (8.12.8/8.12.8) with ESMTP id iB23vLY5031539
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 2 Dec 2004 03:57:25 GMT
Message-ID: <41AE92A0.4020401@rimuhosting.com>
From: Peter <peter.repliesignored@rimuhosting.com>
MIME-Version: 1.0
References: <20041130193047.3370F8D743@zion.localdomain>
In-Reply-To: <20041130193047.3370F8D743@zion.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Kernel panic: Kernel stack overflow
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
Date: Thu, 02 Dec 2004 16:57:20 +1300
Cc: user-mode-linux-devel@lists.sourceforge.net

Hi.  I get a "Kernel panic: Kernel stack overflow" error message on the 
UML instance console.  Then the UML instance exits.

I am running a test where I start up then stop a JBoss server.  (This 
does a bit of network, file and thread related stuff).  The stack 
overflow happens every 3-8 JBoss restarts.  i.e. it is relatively 
reproducible.

The guest kernel is a 2.4.27-bs1.  The host is a 2.6.8.1.  With 
host-skas3-2.6.7-v1.patch.  (Hmmm, maybe that's it?  Try v7?)

What can I do to gather some more useful information about the error for 
you all?

Or, better still, is there a known fix?

Cheers, Peter


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
