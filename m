Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BpEqm-00019Y-US for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jul 2004 16:25:44 -0700
Received: from rwcrmhc12.comcast.net ([216.148.227.85])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BpEqm-0006Wa-MQ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jul 2004 16:25:44 -0700
Message-ID: <410592D9.3060304@hevanet.com>
From: Matt Clay <mattclay@hevanet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [alydar@users.sourceforge.net: Bug#260111:
	user-mode-linux: upgrade hangs at "NET4: Linux TCP/IP 1.0 for NET4.0"]
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
Date: Mon, 26 Jul 2004 16:25:13 -0700
To: UML Devel <user-mode-linux-devel@lists.sourceforge.net>

> mdz@de... said:
>  > Bug#260111: user-mode-linux: upgrade hangs at "NET4: Linux TCP/IP 1.0
>  > for NET4.0" 
>  
>  This resembles the GHz bug, except that one is fixed.  If someone could get
>  a stack trace from the last call to schedule(), that would be a help.

I've just run into this problem.  Turning on debugging symbols makes it 
go away.  Here's the diff between my broken and working configurations.

diff breaks/config works/config
301c301,304
< # CONFIG_DEBUGSYM is not set
---
 > CONFIG_DEBUGSYM=y
 > # CONFIG_PT_PROXY is not set
 > # CONFIG_GPROF is not set
 > # CONFIG_GCOV is not set

UML is 2.4.26 patched with uml-patch-2.4.26-2.bz2
Host is 2.4.27-rc3 patched with host-skas3-2.4.25.patch

I hope this helps.

  - Matt



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
